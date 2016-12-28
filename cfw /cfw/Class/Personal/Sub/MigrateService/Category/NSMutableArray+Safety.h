//
//  NSMutableArray+Safety.h
//  HiTao
//
//  Created by hitao on 16/5/17.
//  Copyright © 2016年 hitao. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSMutableArray (Safety)
-(void)safe_addObject:(id)anObject;
-(void)safe_addObjectsFromArray:(NSArray *)otherArray;
@end

@interface NSArray (Safety)
-(id)safe_objectAtIndex:(NSUInteger)index;
@end
