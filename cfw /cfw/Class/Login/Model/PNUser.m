//
//  PNUser.m
//  cfw
//
//  Created by majun on 16/12/26.
//  Copyright © 2016年 马军. All rights reserved.
//

#import "PNUser.h"

@implementation PNUser

-(instancetype)initWithDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}
@end
