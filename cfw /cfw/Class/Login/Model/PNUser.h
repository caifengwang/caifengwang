//
//  PNUser.h
//  cfw
//
//  Created by majun on 16/12/26.
//  Copyright © 2016年 马军. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PNUser : NSObject
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *uid;
@property (nonatomic,copy) NSString *type;
- (instancetype)initWithDic:(NSDictionary *)dic;
@end
