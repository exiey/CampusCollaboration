package com.campus.framework.web.service;

import java.util.Collections;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import com.campus.common.constant.CacheConstants;
import com.campus.common.constant.Constants;
import com.campus.common.constant.UserConstants;
import com.campus.common.core.domain.entity.SysUser;
import com.campus.common.core.domain.model.RegisterBody;
import com.campus.common.core.redis.RedisCache;
import com.campus.common.exception.ServiceException;
import com.campus.common.exception.user.CaptchaException;
import com.campus.common.exception.user.CaptchaExpireException;
import com.campus.common.utils.DateUtils;
import com.campus.common.utils.MessageUtils;
import com.campus.common.utils.SecurityUtils;
import com.campus.common.utils.StringUtils;
import com.campus.framework.manager.AsyncManager;
import com.campus.framework.manager.factory.AsyncFactory;
import com.campus.system.domain.SysUserRole;
import com.campus.system.mapper.SysUserRoleMapper;
import com.campus.system.service.ISysConfigService;
import com.campus.system.service.ISysUserService;

/**
 * 注册校验方法
 * 
 * @author crazyLee
 */
@Component
public class SysRegisterService
{
    @Autowired
    private ISysUserService userService;

    @Autowired
    private ISysConfigService configService;

    @Autowired
    private RedisCache redisCache;

    @Autowired
    private SysUserRoleMapper userRoleMapper;

    /**
     * 注册
     */
    @Transactional(rollbackFor = Exception.class)
    public String register(RegisterBody registerBody)
    {
        String msg = "", username = registerBody.getUsername(), password = registerBody.getPassword();
        SysUser sysUser = new SysUser();
        sysUser.setUserName(username);

        boolean captchaEnabled = configService.selectCaptchaEnabled();
        if (captchaEnabled)
        {
            validateCaptcha(username, registerBody.getCode(), registerBody.getUuid());
        }

        if (StringUtils.isEmpty(username))
        {
            msg = "用户名不能为空";
        }
        else if (StringUtils.isEmpty(password))
        {
            msg = "用户密码不能为空";
        }
        else if (username.length() < UserConstants.USERNAME_MIN_LENGTH
                || username.length() > UserConstants.USERNAME_MAX_LENGTH)
        {
            msg = "账户长度必须在2到20个字符之间";
        }
        else if (password.length() < UserConstants.PASSWORD_MIN_LENGTH
                || password.length() > UserConstants.PASSWORD_MAX_LENGTH)
        {
            msg = "密码长度必须在5到20个字符之间";
        }
        else if (!userService.checkUserNameUnique(sysUser))
        {
            msg = "保存用户'" + username + "'失败，注册账号已存在";
        }
        else
        {
            sysUser.setNickName(username);
            sysUser.setPwdUpdateDate(DateUtils.getNowDate());
            sysUser.setPassword(SecurityUtils.encryptPassword(password));
            boolean regFlag = userService.registerUser(sysUser);
            if (!regFlag)
            {
                msg = "注册失败,请联系系统管理人员";
            }
            else
            {
                bindDefaultRole(sysUser);
                AsyncManager.me().execute(AsyncFactory.recordLogininfor(username, Constants.REGISTER, MessageUtils.message("user.register.success")));
            }
        }
        return msg;
    }

    /**
     * 绑定默认角色
     * 
     * @param sysUser 注册用户
     */
    private void bindDefaultRole(SysUser sysUser)
    {
        String defaultRoleIdValue = configService.selectConfigByKey("sys.user.defaultRole");
        if (StringUtils.isEmpty(defaultRoleIdValue))
        {
            throw new ServiceException("默认注册角色未配置，请联系系统管理员");
        }

        Long defaultRoleId;
        try
        {
            defaultRoleId = Long.valueOf(defaultRoleIdValue);
        }
        catch (NumberFormatException ex)
        {
            throw new ServiceException("默认注册角色配置无效，请联系系统管理员");
        }

        SysUserRole userRole = new SysUserRole();
        userRole.setUserId(sysUser.getUserId());
        userRole.setRoleId(defaultRoleId);
        userRoleMapper.batchUserRole(Collections.singletonList(userRole));
    }

    /**
     * 校验验证码
     * 
     * @param username 用户名
     * @param code 验证码
     * @param uuid 唯一标识
     * @return 结果
     */
    public void validateCaptcha(String username, String code, String uuid)
    {
        String verifyKey = CacheConstants.CAPTCHA_CODE_KEY + StringUtils.nvl(uuid, "");
        String captcha = redisCache.getCacheObject(verifyKey);
        redisCache.deleteObject(verifyKey);
        if (captcha == null)
        {
            throw new CaptchaExpireException();
        }
        if (!code.equalsIgnoreCase(captcha))
        {
            throw new CaptchaException();
        }
    }
}
