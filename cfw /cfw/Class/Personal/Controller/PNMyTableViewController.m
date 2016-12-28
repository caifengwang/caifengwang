//
//  PNMyTableViewController.m
//  cfw
//
//  Created by 马军 on 16/9/26.
//  Copyright © 2016年 马军. All rights reserved.
//

#import "PNMyTableViewController.h"
#import "PNMyHeadView.h"
#import "GPSettingItem.h"
#import "RegistrationVC.h"
#import "PNAutoLoginViewController.h"
//#import "PNAboutViewController.h"
#import "PNPerfectInfoViewController.h"
#import "PNFeedbackViewController.h"
#import "PNSettingTableViewController.h"
#import "PNSetupShopViewController.h"
#import "RegistrationVC.h"
#import "PNQualityTestingViewController.h"
#import "PNHelpViewController.h"
@interface PNMyTableViewController ()
{
    UIButton *SignOutBtn;
}
@end

@implementation PNMyTableViewController


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
   
     self.tabBarController.tabBar.hidden = NO;
    
    
//    NSDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:@"ResultAuthData"];
//    
//    NSString *result = [dic objectForKey:@"status"];
//    
//    NSLog(@"------------%@",result);
//    
//    if ([result isEqualToString:@"1"]) {
//        
//        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"已登陆" style:UIBarButtonItemStylePlain target:self action:@selector(rightAction)];
//        self.navigationItem.rightBarButtonItem = rightItem;
//        [SignOutBtn setTitle:@"退出" forState:UIControlStateNormal]; // 设置退出按钮的状态
//    }else if([result isEqualToString:@"0"]){
//        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"登录" style:UIBarButtonItemStylePlain target:self action:@selector(rightAction)];
//        self.navigationItem.rightBarButtonItem = rightItem;
//        [SignOutBtn setTitle:@"请登录" forState:UIControlStateNormal];
//        
//        
//    }

    
    [self setUpHeadView];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"服务";
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.scrollEnabled = YES;
    self.navigationItem.backBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self setUpHeadView];
    [self setUpGroup0];
    [self setUpFootView];
    
    
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    [self.tableView setContentOffset:CGPointMake(0,-64) animated:YES];
    
    self.tableView.contentSize = CGSizeMake(0, SCREEN_HEIGHT - 20);
}

- (void)rightAction{
    NSLog(@"点击了右baritem");
    
//    RegistrationVC *regVC = [[RegistrationVC alloc]init];
//    // [self setHidesBottomBarWhenPushed:YES];
//    [self.navigationController pushViewController:regVC animated:YES];
    
    PNAutoLoginViewController *autoLoginVC = [[PNAutoLoginViewController alloc]init];
    [self presentViewController:autoLoginVC animated:YES completion:nil];
    
}

- (void)setUpHeadView{
    
    
    
    PNMyHeadView *headView = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([PNMyHeadView class]) owner:nil options:nil].lastObject;
    
    headView.frame = CGRectMake(0, 0,self.view.bounds.size.width, 70);
  
        //  取出用户名name也就是手机号
        NSDictionary *dic = [[NSUserDefaults standardUserDefaults]objectForKey:@"ResultAuthData"];
        
        NSString *name = [dic objectForKey:@"name"];
    // 轻拍手势
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    //设置触控对象的个数（几个手指）
    [tapGR setNumberOfTouchesRequired:1];
    //设置轻拍次数
    [tapGR setNumberOfTapsRequired:1];
    //给创建好的视图添加手势
    [headView addGestureRecognizer:tapGR];

    
            headView.username.text = name;
            headView.userIphoneNum.text = name;
            NSNumber *type = [dic objectForKey:@"type"];
            NSString *types = [NSString stringWithFormat:@"%@",type];
            
            NSLog(@"types========++++++++%@",types);
            if ([types isEqualToString:@"1"]) {
                headView.authLevel.text = @"游客";
            }else if ([types isEqualToString:@"2"]){
                headView.authLevel.text = @"蜂农";
            }else if([types isEqualToString:@"3"]){
                headView.authLevel.text = @"蜂企";
            }
            
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            
            self.tableView.tableHeaderView = headView;
}

//轻拍手势的回调方法
- (void)tapAction:(UITapGestureRecognizer*)sender{
    
    PNPerfectInfoViewController *perInfoVC = [[PNPerfectInfoViewController alloc]init];
    [self.navigationController pushViewController:perInfoVC animated:YES];

}

- (void)setUpGroup0{
    // 创建组模型
    GPSettingGroup *group = [[GPSettingGroup alloc] init];
    group.items = [NSMutableArray array];
    
    group.header = @"个人设置";
    NSArray *oneSection = @[@"资质认证",@"专家问诊",@"技术帮助",@"质检审核",@"迁徙服务",@"叫车服务",@"设置"];
    NSArray *imageArray = @[@"xiaoxi",@"jiaoyi",@"shenfen",@"fankui",@"jiaobu",@"car",@"guanyu"];
    for (int i = 0; i < oneSection.count; i ++) {
        // 创建行模型
        //GPSettingItem *item = [GPSettingArrowItem itemWithTitle:oneSection[i]];
        GPSettingItem *item1 = [GPSettingArrowItem itemWithTitle:oneSection[i] itemWithImage:imageArray[i]];
        item1.operation = ^(NSIndexPath *indexPath){
            
            if (indexPath.row == 0)
            {
                PNSetupShopViewController *setShopVC = [[PNSetupShopViewController alloc]init];
                [self.navigationController pushViewController:setShopVC animated:YES];
            }
            else if (indexPath.row == 1)
            {
                NSLog(@"点击了专家问诊");
//                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"警告" message:@"非法操作" preferredStyle:UIAlertControllerStyleAlert];
//                [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                    
//                }]];
//                [self presentViewController:alert animated:true completion:nil];
                [SRAlertView sr_showAlertViewWithTitle:@"提醒"
                                               message:@"程序猿正在玩命开发，敬请期待"
                                       leftActionTitle:@"确定"
                                      rightActionTitle:@"取消"
                                        animationStyle:AlertViewAnimationDownToCenterSpring
                                              delegate:self];
                
            }
            else if (indexPath.row == 2)
            {
                NSLog(@"点击了技术支持");
                
                PNHelpViewController *help = [[PNHelpViewController alloc]init];
                [self.navigationController pushViewController:help animated:YES];
            }
            else if (indexPath.row == 3)
            {
                PNQualityTestingViewController *qTestVC = [[PNQualityTestingViewController alloc]init];
                [self.navigationController pushViewController:qTestVC animated:YES];
                
            }
            else if (indexPath.row == 4){
                NSLog(@"迁徙服务");
                
                PNMigrateServiceViewController *maseVC = [[PNMigrateServiceViewController alloc]init];
                [self.navigationController pushViewController:maseVC animated:NO];
            }
            else if (indexPath.row == 5){
                NSLog(@"叫车服务");
            }
            else if (indexPath.row == 6)
            {
                NSLog(@"设置界面");
                PNSettingTableViewController *aboutVC = [[PNSettingTableViewController alloc]init];
                [self.navigationController pushViewController:aboutVC animated:NO];
            }
            
        };
        [group.items addObject:item1];
    }
    [self.groups addObject:group];

}


- (void)setUpFootView{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
     SignOutBtn = [[UIButton alloc]init];
     SignOutBtn.frame = CGRectMake(0, 0,self.view.bounds.size.width,50);
     SignOutBtn.backgroundColor = [UIColor grayColor];
    [SignOutBtn setTitle:@"退出" forState:UIControlStateNormal];
    [SignOutBtn addTarget:self action:@selector(signOut:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:SignOutBtn];
    
    self.tableView.tableFooterView = view;
}

- (void)signOut:(UIButton *)btn{
    NSLog(@"点击了退出按钮");
    EMError * error = [[EMClient sharedClient] logout:YES];
    if (!error)
    {
        NSLog(@"退出成功");
    }
    
    


    PNAutoLoginViewController *autoLoginVC = [[PNAutoLoginViewController alloc]init];
    
//    RegistrationVC *registrVC = [[RegistrationVC alloc]init];
    
    
    
    
    
    
//#pragma mark  发送一个下线状态
//    
//    // 取出name
//    
//    NSDictionary *dic = [[NSUserDefaults standardUserDefaults]objectForKey:@"ResultAuthData"];
//    
//    NSLog(@"%@",dic);
//    
//    if (dic) {
//        
//        NSString *name = [dic objectForKey:@"name"];
//        
//        // 取出uid
//        NSString *uid = [dic objectForKey:@"uid"];
//        
//        
//        NSDictionary *resultDiction = [NSDictionary dictionaryWithObjectsAndKeys:@"0",@"status",uid,@"uid",name,@"name", nil];
//        
//        [[NSUserDefaults standardUserDefaults] setObject:resultDiction forKey:@"ResultAuthData"];
//        //保存数据，实现持久化存储
//        [[NSUserDefaults standardUserDefaults] synchronize];
//        
//        
//        
//#pragma mark 返回给后台一个json数据
//        
//        NSString *urlString = @"http://192.168.0.169:8080/miningbee-web/ws/userStatus/status";
//        urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//        NSURL *url = [NSURL URLWithString:urlString];
//        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
//        request.HTTPMethod = @"POST";
//        
//        // 2.设置请求头
//        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//        
//        // 3.设置请求体
//        NSDictionary *json = @{
//                               @"uid":uid,
//                               @"status" : @"0",
//                               };
//        
//        //    NSData --> NSDictionary
//        // NSDictionary --> NSData
//        NSData *data = [NSJSONSerialization dataWithJSONObject:json options:NSJSONReadingAllowFragments error:nil];
//        request.HTTPBody = data;
//        NSLog(@"%lu", (unsigned long)data.length);
//        
//        // 4.发送请求
//        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
//            NSLog(@"%lu", (unsigned long)data.length);
//            
//            NSLog(@"%@",connectionError);
//            NSLog(@"用户下线了！！");
//        }];
//        
//        
//    }
//    
//
//
    
     [self presentViewController:autoLoginVC animated:YES completion:^{
         
     }];

    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
