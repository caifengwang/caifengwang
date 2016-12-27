//
//  PNMyHeadView.h
//  cfw
//
//  Created by 马军 on 16/9/26.
//  Copyright © 2016年 马军. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PNMyHeadView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *iconImage;

@property (weak, nonatomic) IBOutlet UILabel *username;

@property (weak, nonatomic) IBOutlet UILabel *userIphoneNum;
@property (weak, nonatomic) IBOutlet UILabel *authLevel;
@property (nonatomic,copy) void(^BtnClick)();

@end
