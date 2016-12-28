//
//  PNCallCarViewController.m
//  cfw
//
//  Created by majun on 16/12/27.
//  Copyright © 2016年 马军. All rights reserved.
//

#import "PNCallCarViewController.h"


@interface PNCallCarViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation PNCallCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}







#pragma mark --- tableViewDelegate


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return nil;
}

@end
