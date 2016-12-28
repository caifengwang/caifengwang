//
//  NSString+Extension.m
//
//

#import "NSString+Extension.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Extension)

- (NSString *)MD5
{
    const char *cStr = [self UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    if (cStr == NULL) {
        cStr = "";
    }
    CC_MD5(cStr, (CC_LONG)strlen(cStr), digest);
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02x", digest[i]];
    }
    return result;
}

+ (NSString * )getNil:(NSString *)string {
    
    return string?string:@"";
}

+ (NSString *)getTextNil:(NSString *)string {
    
    if (string.length < 1) {
        return @"--";
    }
    
    return string?string:@"--";
}

+ (BOOL )isEmpty:(NSString *)string{
    
    if (string == nil || [string isEqualToString:@""]) {
        return YES;
    }else{
        return NO;
    }
}

+ (BOOL)isDefaultEmpty:(NSString *)string{
    if (string == nil || [string isEqualToString:@""] || [string isEqualToString:@"--"]) {
        return YES;
    }
    return NO;
}

+ (BOOL)isEmptys:(NSString *) str {
    
    if (!str) {
        return true;
    } else {
        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        NSString *trimedString = [str stringByTrimmingCharactersInSet:set];
        
        if ([trimedString length] == 0) {
            return true;
        } else {
            return false;
        }
    }
}

+ (NSString *)JSONString:(NSString *)aString{
    
    NSMutableString *s = [NSMutableString stringWithString:aString];
    [s replaceOccurrencesOfString:@"\"" withString:@"\\\"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"/" withString:@"\\/" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\n" withString:@"\\n" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\b" withString:@"\\b" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\f" withString:@"\\f" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\r" withString:@"\\r" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\t" withString:@"\\t" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    return [NSString stringWithString:s];
}





+ (NSMutableAttributedString *)setSpaceStr:(NSString *)string{
    NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:string];
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle1 setLineSpacing:4];
    [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, string.length)];
    return attributedString1;
}


- (BOOL)checkPhoneNumInput {
    
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    BOOL res1 = [regextestmobile evaluateWithObject:self];
    BOOL res2 = [regextestcm evaluateWithObject:self];
    BOOL res3 = [regextestcu evaluateWithObject:self];
    BOOL res4 = [regextestct evaluateWithObject:self];
    
    if (res1 || res2 || res3 || res4 )
    {
        return YES;
    }
    else
    {
        return NO;
    }
    
}

+ (NSString *)timeRange:(NSString *)string{
    int caseNum = 0;
    if ([string isEqualToString:@"一天以内"]) {
        caseNum = 1;
    }else if ([string isEqualToString:@"三天以内"]){
        caseNum = 2;
    }else if ([string isEqualToString:@"七天以内"]){
        caseNum = 3;
    }else if([string isEqualToString:@"一月以内"]){
        caseNum = 4;
    }else if([string isEqualToString:@"一年以内"]){
        caseNum = 5;
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    
    NSString *target;
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents * components = [cal components:NSWeekdayCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:[[NSDate alloc] init]];
    
    switch (caseNum) {
        case 1:
            target = currentDateStr;
            break;
        case 2: //3
            [components setDay:([components day] - 3)];
            target = [dateFormatter stringFromDate:[cal dateFromComponents:components]];
            
            break;
        case 3: //7
            [components setDay:([components day] - 7)];
            target = [dateFormatter stringFromDate:[cal dateFromComponents:components]];
            break;
        case 4: //moutn
            [components setMonth:([components month] - 1)];
            target = [dateFormatter stringFromDate:[cal dateFromComponents:components]];
            break;
        case 5: //year
            [components setYear:([components year] - 1)];
            target = [dateFormatter stringFromDate:[cal dateFromComponents:components]];
            break;
            
        default:
            break;
    }
    NSString * timesamp = [NSString stringWithFormat:@"%@,%@",target,currentDateStr];
    if([string isEqualToString:@"所有时间"]){
        return @"";
    }else{
        return timesamp;
    }
}

+ (NSString *)judgeString:(NSString *)string{
    return string?string:@"暂未填写";
}

+ (BOOL)judgeContainspecialCharacter:(NSString *)string{
    NSString *regex = @"[a-zA-Z\u4e00-\u9fa5][a-zA-Z0-9\u4e00-\u9fa5]+";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:string];
}

+ (BOOL)stringContainsEmoji:(NSString *)string
{
    __block BOOL returnValue = NO;
    
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                const unichar hs = [substring characterAtIndex:0];
                                if (0xd800 <= hs && hs <= 0xdbff) {
                                    if (substring.length > 1) {
                                        const unichar ls = [substring characterAtIndex:1];
                                        const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                        if (0x1d000 <= uc && uc <= 0x1f77f) {
                                            returnValue = YES;
                                        }
                                    }
                                } else if (substring.length > 1) {
                                    const unichar ls = [substring characterAtIndex:1];
                                    if (ls == 0x20e3) {
                                        returnValue = YES;
                                    }
                                } else {
                                    if (0x2100 <= hs && hs <= 0x27ff) {
                                        returnValue = YES;
                                    } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                        returnValue = YES;  
                                    } else if (0x2934 <= hs && hs <= 0x2935) {  
                                        returnValue = YES;  
                                    } else if (0x3297 <= hs && hs <= 0x3299) {  
                                        returnValue = YES;  
                                    } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {  
                                        returnValue = YES;  
                                    }  
                                }  
                            }];  
    
    return returnValue;  
}

@end
