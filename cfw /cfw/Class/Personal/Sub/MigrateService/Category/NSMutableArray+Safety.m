//
//  NSMutableArray+Safety.m
//  HiTao
//
//  Created by hitao on 16/5/17.
//  Copyright © 2016年 hitao. All rights reserved.
//

#import "NSMutableArray+Safety.h"

@implementation NSMutableArray (Safety)
-(void)safe_addObjectsFromArray:(NSArray *)otherArray{
    if (otherArray && [otherArray count]) {
        [self addObjectsFromArray:otherArray];
    }
}

-(void)safe_addObject:(id)anObject{
    if (anObject) {
        [self addObject:anObject];
    }
}

@end

@implementation NSArray (Safety)
-(id)safe_objectAtIndex:(NSUInteger)index{
    if (([self count]-1) >= index && self.count > 0) {
        return [self objectAtIndex:index];
    }
    return nil;
}
@end