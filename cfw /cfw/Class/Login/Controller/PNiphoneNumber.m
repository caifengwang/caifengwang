
//
//  PNiphoneNumber.m
//  cfw
//
//  Created by 马军 on 16/9/27.
//  Copyright © 2016年 马军. All rights reserved.
//

#import "PNiphoneNumber.h"

@implementation PNiphoneNumber



+ (NSString *)myNumber{
    return CTSettingCopyMyPhoneNumber();
}

@end
