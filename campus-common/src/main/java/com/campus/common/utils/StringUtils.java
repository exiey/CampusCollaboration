package com.campus.common.utils;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import org.springframework.util.AntPathMatcher;
import com.campus.common.constant.Constants;
import com.campus.common.core.text.StrFormatter;

import cn.hutool.core.util.StrUtil;

/**
 * 字符串工具类 - 基于 Hutool StrUtil
 * 
 * @author crazyLee
 */
public class StringUtils
{
    /** 空字符串 */
    private static final String NULLSTR = "";

    /** 下划线 */
    private static final char SEPARATOR = '_';

    /** 星号 */
    private static final char ASTERISK = '*';

    /** 字符串常量：{@code "null"} */
    public static final String NULL = "null";

    /** 字符串常量：空字符串 {@code ""} */
    public static final String EMPTY = "";

    /** 字符串常量：空格符 {@code " "} */
    public static final String SPACE = " ";

    /** 表示搜索失败的索引 */
    public static final int INDEX_NOT_FOUND = -1;

    // ==================== Hutool StrUtil 委托方法 ====================

    /**
     * 判断字符串是否为空白（null、空字符串、空白字符）
     * 
     * @param str 要检查的字符串
     * @return true：空白 false：非空白
     */
    public static boolean isBlank(CharSequence str)
    {
        return StrUtil.isBlank(str);
    }

    /**
     * 判断字符串是否为非空白
     * 
     * @param str 要检查的字符串
     * @return true：非空白 false：空白
     */
    public static boolean isNotBlank(CharSequence str)
    {
        return StrUtil.isNotBlank(str);
    }


    /**
     * 判断两个字符串是否相等
     * 
     * @param str1 字符串1
     * @param str2 字符串2
     * @return true：相等 false：不相等
     */
    public static boolean equals(CharSequence str1, CharSequence str2)
    {
        return StrUtil.equals(str1, str2);
    }

    /**
     * 判断两个字符串是否相等（忽略大小写）
     * 
     * @param str1 字符串1
     * @param str2 字符串2
     * @return true：相等 false：不相等
     */
    public static boolean equalsIgnoreCase(CharSequence str1, CharSequence str2)
    {
        return StrUtil.equalsIgnoreCase(str1, str2);
    }

    /**
     * 判断字符串是否以指定的任意一个前缀开头
     * 
     * @param str 要检查的字符串
     * @param prefixes 前缀数组
     * @return true：以任意一个前缀开头 false：不以任意一个前缀开头
     */
    public static boolean startsWithAny(CharSequence str, CharSequence... prefixes)
    {
        return StrUtil.startWithAny(str, prefixes);
    }

    /**
     * 判断字符串是否以指定前缀开头
     * 
     * @param str 要检查的字符串
     * @param prefix 前缀
     * @return true：以前缀开头 false：不以前缀开头
     */
    public static boolean startsWith(CharSequence str, CharSequence prefix)
    {
        return StrUtil.startWith(str, prefix);
    }

    /**
     * 判断字符串是否以指定后缀结尾
     * 
     * @param str 要检查的字符串
     * @param suffix 后缀
     * @return true：以后缀结尾 false：不以后缀结尾
     */
    public static boolean endsWith(CharSequence str, CharSequence suffix)
    {
        return StrUtil.endWith(str, suffix);
    }

    /**
     * 判断字符串是否以指定后缀结尾（忽略大小写）
     * 
     * @param str 要检查的字符串
     * @param suffix 后缀
     * @return true：以后缀结尾 false：不以后缀结尾
     */
    public static boolean endsWithIgnoreCase(CharSequence str, CharSequence suffix)
    {
        return StrUtil.endWithIgnoreCase(str, suffix);
    }

    /**
     * 判断字符串是否包含指定字符串
     * 
     * @param str 要检查的字符串
     * @param searchStr 要搜索的字符串
     * @return true：包含 false：不包含
     */
    public static boolean contains(CharSequence str, CharSequence searchStr)
    {
        return StrUtil.contains(str, searchStr);
    }

    /**
     * 判断字符串是否包含指定字符串（忽略大小写）
     * 
     * @param str 要检查的字符串
     * @param searchStr 要搜索的字符串
     * @return true：包含 false：不包含
     */
    public static boolean containsIgnoreCase(CharSequence str, CharSequence searchStr)
    {
        return StrUtil.containsIgnoreCase(str, searchStr);
    }

    /**
     * 获取字符串长度，null返回0
     * 
     * @param str 字符串
     * @return 字符串长度
     */
    public static int length(CharSequence str)
    {
        return StrUtil.length(str);
    }

    /**
     * 查找字符串在另一个字符串中的位置
     * 
     * @param str 要搜索的字符串
     * @param searchStr 要查找的字符串
     * @return 位置，未找到返回-1
     */
    public static int indexOf(CharSequence str, CharSequence searchStr)
    {
        return StrUtil.indexOf(str, searchStr, 0, false);
    }

    /**
     * 查找字符串在另一个字符串中的位置（忽略大小写）
     * 
     * @param str 要搜索的字符串
     * @param searchStr 要查找的字符串
     * @return 位置，未找到返回-1
     */
    public static int indexOfIgnoreCase(CharSequence str, CharSequence searchStr)
    {
        return StrUtil.indexOfIgnoreCase(str, searchStr);
    }

    /**
     * 移除字符串开头的指定字符串
     * 
     * @param str 原字符串
     * @param remove 要移除的字符串
     * @return 移除后的字符串
     */
    public static String removeStart(CharSequence str, CharSequence remove)
    {
        return StrUtil.removePrefix(str, remove);
    }

    /**
     * 移除字符串末尾的指定字符串
     * 
     * @param str 原字符串
     * @param remove 要移除的字符串
     * @return 移除后的字符串
     */
    public static String removeEnd(CharSequence str, CharSequence remove)
    {
        return StrUtil.removeSuffix(str, remove);
    }

    /**
     * 去除字符串末尾的指定字符
     * 
     * @param str 原字符串
     * @param stripChars 要去除的字符
     * @return 去除后的字符串
     */
    public static String stripEnd(String str, String stripChars)
    {
        if (str == null)
        {
            return null;
        }
        int end = str.length();
        if (end == 0 || stripChars == null)
        {
            return str;
        }
        if (stripChars.isEmpty())
        {
            return str;
        }
        while (end != 0 && stripChars.indexOf(str.charAt(end - 1)) != INDEX_NOT_FOUND)
        {
            end--;
        }
        return str.substring(0, end);
    }

    /**
     * 首字母大写
     * 
     * @param str 字符串
     * @return 首字母大写后的字符串
     */
    public static String capitalize(String str)
    {
        return StrUtil.upperFirst(str);
    }

    /**
     * 首字母小写
     * 
     * @param str 字符串
     * @return 首字母小写后的字符串
     */
    public static String uncapitalize(String str)
    {
        return StrUtil.lowerFirst(str);
    }

    /**
     * 获取第一个分隔符之前的子字符串
     * 
     * @param str 原字符串
     * @param separator 分隔符
     * @return 分隔符之前的子字符串
     */
    public static String substringBefore(String str, String separator)
    {
        return StrUtil.subBefore(str, separator, false);
    }

    /**
     * 分割字符串
     * 
     * @param str 原字符串
     * @param separator 分隔符
     * @return 分割后的字符串数组
     */
    public static String[] split(String str, String separator)
    {
        return StrUtil.splitToArray(str, separator);
    }

    /**
     * 分割字符串（按字符分割）
     * 
     * @param str 原字符串
     * @param separator 分隔符
     * @return 分割后的字符串数组
     */
    public static String[] split(String str, char separator)
    {
        return StrUtil.splitToArray(str, separator);
    }

    /**
     * 判断字符串是否以指定前缀开头（忽略大小写）
     * 
     * @param str 要检查的字符串
     * @param prefix 前缀
     * @return true：以前缀开头 false：不以前缀开头
     */
    public static boolean startsWithIgnoreCase(CharSequence str, CharSequence prefix)
    {
        return StrUtil.startWithIgnoreCase(str, prefix);
    }

    /**
     * 重复字符
     * 
     * @param c 字符
     * @param count 重复次数
     * @return 重复后的字符串
     */
    public static String repeat(char c, int count)
    {
        return StrUtil.repeat(c, count);
    }

    /**
     * 如果字符串为null，返回空字符串
     * 
     * @param str 字符串
     * @return 非null字符串
     */
    public static String defaultString(String str)
    {
        return str == null ? EMPTY : str;
    }

    /**
     * 如果字符串为null，返回默认值
     * 
     * @param str 字符串
     * @param defaultStr 默认值
     * @return 非null字符串
     */
    public static String defaultString(String str, String defaultStr)
    {
        return str == null ? defaultStr : str;
    }

    /**
     * 连接字符串数组
     * 
     * @param array 字符串数组
     * @param separator 分隔符
     * @return 连接后的字符串
     */
    public static String join(String[] array, String separator)
    {
        if (array == null)
        {
            return null;
        }
        return String.join(separator, array);
    }

    /**
     * 连接字符串数组（无分隔符）
     * 
     * @param array 字符串数组
     * @return 连接后的字符串
     */
    public static String join(String[] array)
    {
        if (array == null)
        {
            return null;
        }
        return String.join("", array);
    }

    /**
     * 连接集合元素
     * 
     * @param collection 集合
     * @param separator 分隔符
     * @return 连接后的字符串
     */
    public static String join(Collection<?> collection, String separator)
    {
        if (collection == null)
        {
            return null;
        }
        return collection.stream()
                .map(Object::toString)
                .collect(java.util.stream.Collectors.joining(separator));
    }

    /**
     * 获取第一个分隔符之后的子字符串
     * 
     * @param str 原字符串
     * @param separator 分隔符
     * @return 分隔符之后的子字符串
     */
    public static String substringAfter(String str, String separator)
    {
        return StrUtil.subAfter(str, separator, false);
    }

    /**
     * 获取最后一个分隔符之前的子字符串
     * 
     * @param str 原字符串
     * @param separator 分隔符
     * @return 最后一个分隔符之前的子字符串
     */
    public static String substringBeforeLast(String str, String separator)
    {
        return StrUtil.subBefore(str, separator, true);
    }

    /**
     * 获取最后一个分隔符之后的子字符串
     * 
     * @param str 原字符串
     * @param separator 分隔符
     * @return 最后一个分隔符之后的子字符串
     */
    public static String substringAfterLast(String str, String separator)
    {
        return StrUtil.subAfter(str, separator, true);
    }

    /**
     * 统计字符串中子字符串出现的次数
     * 
     * @param str 原字符串
     * @param sub 子字符串
     * @return 出现次数
     */
    public static int countMatches(CharSequence str, CharSequence sub)
    {
        return StrUtil.count(str, sub);
    }

    /**
     * 判断字符串是否为数字
     * 
     * @param str 字符串
     * @return true：是数字 false：不是数字
     */
    public static boolean isNumeric(CharSequence str)
    {
        return StrUtil.isNumeric(str);
    }

    /**
     * 判断字符串是否包含指定的任意一个字符串
     * 
     * @param str 要检查的字符串
     * @param searchStrs 要搜索的字符串数组
     * @return true：包含 false：不包含
     */
    public static boolean containsAny(CharSequence str, CharSequence... searchStrs)
    {
        return StrUtil.containsAny(str, searchStrs);
    }

    /**
     * 替换字符串中的指定字符串
     * 
     * @param str 原字符串
     * @param searchStr 要替换的字符串
     * @param replacement 替换后的字符串
     * @return 替换后的字符串
     */
    public static String replace(String str, String searchStr, String replacement)
    {
        return StrUtil.replace(str, searchStr, replacement);
    }

    /**
     * 替换字符串中的多个指定字符串
     * 
     * @param str 原字符串
     * @param searchList 要替换的字符串数组
     * @param replacementList 替换后的字符串数组
     * @return 替换后的字符串
     */
    public static String replaceEach(String str, String[] searchList, String[] replacementList)
    {
        if (str == null || str.isEmpty())
        {
            return str;
        }
        if (searchList == null || replacementList == null || searchList.length != replacementList.length)
        {
            return str;
        }
        String result = str;
        for (int i = 0; i < searchList.length; i++)
        {
            if (searchList[i] != null && replacementList[i] != null)
            {
                result = StrUtil.replace(result, searchList[i], replacementList[i]);
            }
        }
        return result;
    }

    /**
     * 如果字符串为空，返回默认值
     * 
     * @param str 字符串
     * @param defaultStr 默认值
     * @return 非空字符串
     */
    public static String defaultIfEmpty(String str, String defaultStr)
    {
        return StrUtil.emptyToDefault(str, defaultStr);
    }

    /**
     * 判断字符串是否与任意一个字符串相等
     * 
     * @param str 要检查的字符串
     * @param searchStrs 要比较的字符串数组
     * @return true：相等 false：不相等
     */
    public static boolean equalsAny(CharSequence str, CharSequence... searchStrs)
    {
        return StrUtil.equalsAny(str, searchStrs);
    }

    /**
     * 判断字符串是否与任意一个字符串相等（忽略大小写）
     * 
     * @param str 要检查的字符串
     * @param searchStrs 要比较的字符串数组
     * @return true：相等 false：不相等
     */
    public static boolean equalsAnyIgnoreCase(CharSequence str, CharSequence... searchStrs)
    {
        if (str == null || searchStrs == null)
        {
            return false;
        }
        for (CharSequence searchStr : searchStrs)
        {
            if (StrUtil.equalsIgnoreCase(str, searchStr))
            {
                return true;
            }
        }
        return false;
    }

    /**
     * 去除字符串两端空白，如果为null则返回空字符串
     * 
     * @param str 字符串
     * @return 去除空白后的字符串
     */
    public static String trimToEmpty(String str)
    {
        return str == null ? EMPTY : str.trim();
    }

    /**
     * 如果对象为null，返回默认值
     * 
     * @param value 对象
     * @param defaultValue 默认值
     * @return 非null对象
     */
    public static <T> T nvl(T value, T defaultValue)
    {
        return value != null ? value : defaultValue;
    }


    // ==================== 原有自定义方法 ====================

    /**
     * * 判断一个Collection是否为空， 包含List，Set，Queue
     * 
     * @param coll 要判断的Collection
     * @return true：为空 false：非空
     */
    public static boolean isEmpty(Collection<?> coll)
    {
        return isNull(coll) || coll.isEmpty();
    }

    /**
     * * 判断一个Collection是否非空，包含List，Set，Queue
     * 
     * @param coll 要判断的Collection
     * @return true：非空 false：空
     */
    public static boolean isNotEmpty(Collection<?> coll)
    {
        return !isEmpty(coll);
    }

    /**
     * * 判断一个对象数组是否为空
     * 
     * @param objects 要判断的对象数组
     * @return true：为空 false：非空
     */
    public static boolean isEmpty(Object[] objects)
    {
        return isNull(objects) || (objects.length == 0);
    }

    /**
     * * 判断一个对象数组是否非空
     * 
     * @param objects 要判断的对象数组
     * @return true：非空 false：空
     */
    public static boolean isNotEmpty(Object[] objects)
    {
        return !isEmpty(objects);
    }

    /**
     * * 判断一个Map是否为空
     * 
     * @param map 要判断的Map
     * @return true：为空 false：非空
     */
    public static boolean isEmpty(Map<?, ?> map)
    {
        return isNull(map) || map.isEmpty();
    }

    /**
     * * 判断一个Map是否为空
     * 
     * @param map 要判断的Map
     * @return true：非空 false：空
     */
    public static boolean isNotEmpty(Map<?, ?> map)
    {
        return !isEmpty(map);
    }

    /**
     * * 判断一个字符串是否为空串
     * 
     * @param str String
     * @return true：为空 false：非空
     */
    public static boolean isEmpty(String str)
    {
        return isNull(str) || NULLSTR.equals(str.trim());
    }

    /**
     * * 判断一个字符串是否为非空串
     * 
     * @param str String
     * @return true：非空串 false：空串
     */
    public static boolean isNotEmpty(String str)
    {
        return !isEmpty(str);
    }

    /**
     * * 判断一个对象是否为空
     * 
     * @param object Object
     * @return true：为空 false：非空
     */
    public static boolean isNull(Object object)
    {
        return object == null;
    }

    /**
     * * 判断一个对象是否非空
     * 
     * @param object Object
     * @return true：非空 false：空
     */
    public static boolean isNotNull(Object object)
    {
        return !isNull(object);
    }

    /**
     * * 判断一个对象是否是数组类型（Java基本型别的数组）
     * 
     * @param object 对象
     * @return true：是数组 false：不是数组
     */
    public static boolean isArray(Object object)
    {
        return isNotNull(object) && object.getClass().isArray();
    }

    /**
     * 去空格
     */
    public static String trim(String str)
    {
        return (str == null ? "" : str.trim());
    }

    /**
     * 替换指定字符串的指定区间内字符为"*"
     *
     * @param str 字符串
     * @param startInclude 开始位置（包含）
     * @param endExclude 结束位置（不包含）
     * @return 替换后的字符串
     */
    public static String hide(CharSequence str, int startInclude, int endExclude)
    {
        if (isEmpty(str))
        {
            return NULLSTR;
        }
        final int strLength = str.length();
        if (startInclude > strLength)
        {
            return NULLSTR;
        }
        if (endExclude > strLength)
        {
            endExclude = strLength;
        }
        if (startInclude > endExclude)
        {
            // 如果起始位置大于结束位置，不替换
            return NULLSTR;
        }
        final char[] chars = new char[strLength];
        for (int i = 0; i < strLength; i++)
        {
            if (i >= startInclude && i < endExclude)
            {
                chars[i] = ASTERISK;
            }
            else
            {
                chars[i] = str.charAt(i);
            }
        }
        return new String(chars);
    }

    /**
     * 判断CharSequence是否为空
     */
    private static boolean isEmpty(CharSequence str)
    {
        return str == null || str.length() == 0;
    }


    /**
     * 截取字符串
     * 
     * @param str 字符串
     * @param start 开始
     * @return 结果
     */
    public static String substring(final String str, int start)
    {
        if (str == null)
        {
            return NULLSTR;
        }

        if (start < 0)
        {
            start = str.length() + start;
        }

        if (start < 0)
        {
            start = 0;
        }
        if (start > str.length())
        {
            return NULLSTR;
        }

        return str.substring(start);
    }

    /**
     * 截取字符串
     * 
     * @param str 字符串
     * @param start 开始
     * @param end 结束
     * @return 结果
     */
    public static String substring(final String str, int start, int end)
    {
        if (str == null)
        {
            return NULLSTR;
        }

        if (end < 0)
        {
            end = str.length() + end;
        }
        if (start < 0)
        {
            start = str.length() + start;
        }

        if (end > str.length())
        {
            end = str.length();
        }

        if (start > end)
        {
            return NULLSTR;
        }

        if (start < 0)
        {
            start = 0;
        }
        if (end < 0)
        {
            end = 0;
        }

        return str.substring(start, end);
    }

    /**
     * 获取两个字符串之间的子字符串
     * 
     * @param str 要截取的字符串
     * @param open 起始字符串
     * @param close 结束字符串
     * @return 截取结果
     */
    public static String substringBetween(final String str, final String open, final String close)
    {
        return StrUtil.subBetween(str, open, close);
    }

    /**
     * 在字符串中查找第一个出现的 `open` 和最后一个出现的 `close` 之间的子字符串
     * 
     * @param str 要截取的字符串
     * @param open 起始字符串
     * @param close 结束字符串
     * @return 截取结果
     */
    public static String substringBetweenLast(final String str, final String open, final String close)
    {
        if (isEmpty(str) || isEmpty(open) || isEmpty(close))
        {
            return NULLSTR;
        }
        final int start = str.indexOf(open);
        if (start != INDEX_NOT_FOUND)
        {
            final int end = str.lastIndexOf(close);
            if (end != INDEX_NOT_FOUND)
            {
                return str.substring(start + open.length(), end);
            }
        }
        return NULLSTR;
    }

    /**
     * 判断是否为空，并且不是空白字符
     * 
     * @param str 要判断的value
     * @return 结果
     */
    public static boolean hasText(String str)
    {
        return (str != null && !str.isEmpty() && containsText(str));
    }

    private static boolean containsText(CharSequence str)
    {
        int strLen = str.length();
        for (int i = 0; i < strLen; i++)
        {
            if (!Character.isWhitespace(str.charAt(i)))
            {
                return true;
            }
        }
        return false;
    }

    /**
     * 格式化文本, {} 表示占位符<br>
     * 此方法只是简单将占位符 {} 按照顺序替换为参数<br>
     * 如果想输出 {} 使用 \\转义 { 即可，如果想输出 {} 之前的 \ 使用双转义符 \\\\ 即可<br>
     * 例：<br>
     * 通常使用：format("this is {} for {}", "a", "b") -> this is a for b<br>
     * 转义{}： format("this is \\{} for {}", "a", "b") -> this is \{} for a<br>
     * 转义\： format("this is \\\\{} for {}", "a", "b") -> this is \a for b<br>
     * 
     * @param template 文本模板，被替换的部分用 {} 表示
     * @param params 参数值
     * @return 格式化后的文本
     */
    public static String format(String template, Object... params)
    {
        if (isEmpty(params) || isEmpty(template))
        {
            return template;
        }
        return StrFormatter.format(template, params);
    }

    /**
     * 是否为http(s)://开头
     * 
     * @param link 链接
     * @return 结果
     */
    public static boolean ishttp(String link)
    {
        return StringUtils.startsWithAny(link, Constants.HTTP, Constants.HTTPS);
    }

    /**
     * 字符串转set
     * 
     * @param str 字符串
     * @param sep 分隔符
     * @return set集合
     */
    public static final Set<String> str2Set(String str, String sep)
    {
        return new HashSet<String>(str2List(str, sep, true, false));
    }

    /**
     * 字符串转list
     * 
     * @param str 字符串
     * @param sep 分隔符
     * @return list集合
     */
    public static final List<String> str2List(String str, String sep)
    {
        return str2List(str, sep, true, false);
    }


    /**
     * 字符串转list
     * 
     * @param str 字符串
     * @param sep 分隔符
     * @param filterBlank 过滤纯空白
     * @param trim 去掉首尾空白
     * @return list集合
     */
    public static final List<String> str2List(String str, String sep, boolean filterBlank, boolean trim)
    {
        List<String> list = new ArrayList<String>();
        if (StringUtils.isEmpty(str))
        {
            return list;
        }

        // 过滤空白字符串
        if (filterBlank && StringUtils.isBlank(str))
        {
            return list;
        }
        String[] split = str.split(sep);
        for (String string : split)
        {
            if (filterBlank && StringUtils.isBlank(string))
            {
                continue;
            }
            if (trim)
            {
                string = string.trim();
            }
            list.add(string);
        }

        return list;
    }

    /**
     * 判断给定的collection列表中是否包含数组array 判断给定的数组array中是否包含给定的元素value
     *
     * @param collection 给定的集合
     * @param array 给定的数组
     * @return boolean 结果
     */
    public static boolean containsAny(Collection<String> collection, String... array)
    {
        if (isEmpty(collection) || isEmpty(array))
        {
            return false;
        }
        else
        {
            for (String str : array)
            {
                if (collection.contains(str))
                {
                    return true;
                }
            }
            return false;
        }
    }

    /**
     * 查找指定字符串是否包含指定字符串列表中的任意一个字符串同时串忽略大小写
     *
     * @param cs 指定字符串
     * @param searchCharSequences 需要检查的字符串数组
     * @return 是否包含任意一个字符串
     */
    public static boolean containsAnyIgnoreCase(CharSequence cs, CharSequence... searchCharSequences)
    {
        if (isEmpty(cs) || isEmpty(searchCharSequences))
        {
            return false;
        }
        for (CharSequence testStr : searchCharSequences)
        {
            if (containsIgnoreCase(cs, testStr))
            {
                return true;
            }
        }
        return false;
    }

    /**
     * 驼峰转下划线命名
     */
    public static String toUnderScoreCase(String str)
    {
        if (str == null)
        {
            return null;
        }
        StringBuilder sb = new StringBuilder();
        // 前置字符是否大写
        boolean preCharIsUpperCase = true;
        // 当前字符是否大写
        boolean curreCharIsUpperCase = true;
        // 下一字符是否大写
        boolean nexteCharIsUpperCase = true;
        for (int i = 0; i < str.length(); i++)
        {
            char c = str.charAt(i);
            if (i > 0)
            {
                preCharIsUpperCase = Character.isUpperCase(str.charAt(i - 1));
            }
            else
            {
                preCharIsUpperCase = false;
            }

            curreCharIsUpperCase = Character.isUpperCase(c);

            if (i < (str.length() - 1))
            {
                nexteCharIsUpperCase = Character.isUpperCase(str.charAt(i + 1));
            }

            if (preCharIsUpperCase && curreCharIsUpperCase && !nexteCharIsUpperCase)
            {
                sb.append(SEPARATOR);
            }
            else if ((i != 0 && !preCharIsUpperCase) && curreCharIsUpperCase)
            {
                sb.append(SEPARATOR);
            }
            sb.append(Character.toLowerCase(c));
        }

        return sb.toString();
    }

    /**
     * 是否包含字符串
     * 
     * @param str 验证字符串
     * @param strs 字符串组
     * @return 包含返回true
     */
    public static boolean inStringIgnoreCase(String str, String... strs)
    {
        if (str != null && strs != null)
        {
            for (String s : strs)
            {
                if (str.equalsIgnoreCase(trim(s)))
                {
                    return true;
                }
            }
        }
        return false;
    }


    /**
     * 将下划线大写方式命名的字符串转换为驼峰式。如果转换前的下划线大写方式命名的字符串为空，则返回空字符串。 例如：HELLO_WORLD->HelloWorld
     * 
     * @param name 转换前的下划线大写方式命名的字符串
     * @return 转换后的驼峰式命名的字符串
     */
    public static String convertToCamelCase(String name)
    {
        StringBuilder result = new StringBuilder();
        // 快速检查
        if (name == null || name.isEmpty())
        {
            // 没必要转换
            return "";
        }
        else if (!name.contains("_"))
        {
            // 不含下划线，仅将首字母大写
            return name.substring(0, 1).toUpperCase() + name.substring(1);
        }
        // 用下划线将原始字符串分割
        String[] camels = name.split("_");
        for (String camel : camels)
        {
            // 跳过原始字符串中开头、结尾的下换线或双重下划线
            if (camel.isEmpty())
            {
                continue;
            }
            // 首字母大写
            result.append(camel.substring(0, 1).toUpperCase());
            result.append(camel.substring(1).toLowerCase());
        }
        return result.toString();
    }

    /**
     * 驼峰式命名法
     * 例如：user_name->userName
     */
    public static String toCamelCase(String s)
    {
        if (s == null)
        {
            return null;
        }
        if (s.indexOf(SEPARATOR) == -1)
        {
            return s;
        }
        s = s.toLowerCase();
        StringBuilder sb = new StringBuilder(s.length());
        boolean upperCase = false;
        for (int i = 0; i < s.length(); i++)
        {
            char c = s.charAt(i);

            if (c == SEPARATOR)
            {
                upperCase = true;
            }
            else if (upperCase)
            {
                sb.append(Character.toUpperCase(c));
                upperCase = false;
            }
            else
            {
                sb.append(c);
            }
        }
        return sb.toString();
    }

    /**
     * 查找指定字符串是否匹配指定字符串列表中的任意一个字符串
     * 
     * @param str 指定字符串
     * @param strs 需要检查的字符串数组
     * @return 是否匹配
     */
    public static boolean matches(String str, List<String> strs)
    {
        if (isEmpty(str) || isEmpty(strs))
        {
            return false;
        }
        for (String pattern : strs)
        {
            if (isMatch(pattern, str))
            {
                return true;
            }
        }
        return false;
    }

    /**
     * 判断url是否与规则配置: 
     * ? 表示单个字符; 
     * * 表示一层路径内的任意字符串，不可跨层级; 
     * ** 表示任意层路径;
     * 
     * @param pattern 匹配规则
     * @param url 需要匹配的url
     * @return
     */
    public static boolean isMatch(String pattern, String url)
    {
        AntPathMatcher matcher = new AntPathMatcher();
        return matcher.match(pattern, url);
    }

    @SuppressWarnings("unchecked")
    public static <T> T cast(Object obj)
    {
        return (T) obj;
    }

    /**
     * 数字左边补齐0，使之达到指定长度。注意，如果数字转换为字符串后，长度大于size，则只保留 最后size个字符。
     * 
     * @param num 数字对象
     * @param size 字符串指定长度
     * @return 返回数字的字符串格式，该字符串为指定长度。
     */
    public static final String padl(final Number num, final int size)
    {
        return padl(num.toString(), size, '0');
    }

    /**
     * 字符串左补齐。如果原始字符串s长度大于size，则只保留最后size个字符。
     * 
     * @param s 原始字符串
     * @param size 字符串指定长度
     * @param c 用于补齐的字符
     * @return 返回指定长度的字符串，由原字符串左补齐或截取得到。
     */
    public static final String padl(final String s, final int size, final char c)
    {
        final StringBuilder sb = new StringBuilder(size);
        if (s != null)
        {
            final int len = s.length();
            if (s.length() <= size)
            {
                for (int i = size - len; i > 0; i--)
                {
                    sb.append(c);
                }
                sb.append(s);
            }
            else
            {
                return s.substring(len - size, len);
            }
        }
        else
        {
            for (int i = size; i > 0; i--)
            {
                sb.append(c);
            }
        }
        return sb.toString();
    }
}
