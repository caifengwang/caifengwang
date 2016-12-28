//
//  NSString+Extension.h
//
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)
/**
 *  MD5加密
 */
- (NSString *)MD5;

/**
 *  判断字符串是否为空，为空返回YES
 */
+ (BOOL )isEmpty:(NSString *)string;

/**
 *  是否为空或者"--"
 */
+ (BOOL)isDefaultEmpty:(NSString *)string;

/**
 *
 *  @return YES 为含有空格字符串
 */
+ (BOOL)isEmptys:(NSString *)string;

/**
 *  三目运算，string为nil则为空字符串
 */
+ (NSString * )getNil:(NSString *)string;
/**
 *
 *  为空则返回 “--”
 */
+ (NSString *)getTextNil:(NSString *)string;

/**
 *  string 转 JSON
 */
+ (NSString *)JSONString:(NSString *)aString;

/**
 *  为string增加横行间距
 */
+ (NSMutableAttributedString *)setSpaceStr:(NSString *)string;

/**
 *  手机号正则判断
 *
 *  @retutn YES 为手机号
 */
- (BOOL)checkPhoneNumInput;

/**
 *  时间范围转换
 *
 *
 *  @return 时间戳
 */
+ (NSString *)timeRange:(NSString *)string;

/**
 *  字符串判空，为空是返回暂未填写
 */
+ (NSString *)judgeString:(NSString *)string;

/**
 *  判断是否包含特殊字符
 */
+ (BOOL)judgeContainspecialCharacter:(NSString *)string;

+ (BOOL)stringContainsEmoji:(NSString *)string;
@end
