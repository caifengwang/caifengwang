//
//  PNMigrateServiceViewController.m
//  cfw
//
//  Created by majun on 16/12/27.
//  Copyright © 2016年 马军. All rights reserved.
//

#import "PNMigrateServiceViewController.h"

@interface PNMigrateServiceViewController ()

@end

@implementation PNMigrateServiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.title = @"迁徙服务";
    
    
    UIButton *btn = [UIButton  buttonWithType:UIButtonTypeSystem];
    [btn setTitle:@"手动选择城市" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(200);
        make.size.mas_equalTo(CGSizeMake(150,45));
    }];
    
    
    
    UIButton *btn1 = [UIButton  buttonWithType:UIButtonTypeSystem];
    [btn1 setTitle:@"地图选择城市" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(btn1Action) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(250);
        make.size.mas_equalTo(CGSizeMake(150,45));
    }];

    
    
}

- (void)btnAction{
    
    
    XKEditAddressVC *vc = [XKEditAddressVC new];
    
    [vc setCompletionBlock:^(int i, id value) {
        
        NSLog(@"你的地址是 %@",value);
    }];
    
    [self.navigationController pushViewController:vc animated:YES];

}
- (void)btn1Action{
    
    YMAnnotationController *ymaVC = [[YMAnnotationController alloc]init];
    [self.navigationController pushViewController:ymaVC animated:YES];
}


@end
