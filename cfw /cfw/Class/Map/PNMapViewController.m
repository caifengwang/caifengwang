//
//  PNMapViewController.m
//  cfw
//
//  Created by 马军 on 16/9/23.
//  Copyright © 2016年 马军. All rights reserved.
//
#import "WXDataService.h"
#import "NetWorkingHelpper.h"
#import "PNMapViewController.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件
#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件
#import <BaiduMapAPI_Radar/BMKRadarComponent.h>
#define COLOUR(R,G,B,A) [UIColor colorWithRed:R / 255.0 green:G / 255.0 blue:B / 255.0 alpha:A]
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define RECTMACK(A,B,X,Y) CGRectMake(A * SCREEN_WIDTH/414, B * SCREEN_WIDTH/414,X *SCREEN_WIDTH/414,Y *SCREEN_WIDTH/414)
@interface PNMapViewController ()<BMKMapViewDelegate,BMKLocationServiceDelegate,BMKRadarManagerDelegate,NetWorkingHelpperDelegate>
{
    BMKMapView* _mapView;
    BMKLocationService* _locService;
    BMKRadarManager *_radarManager;
    CLLocationCoordinate2D _myCoor;
    NSMutableDictionary *_locationDic;
}

@property (nonatomic, retain)NSString *str1;
@property (nonatomic, retain)NSString *str2;
@property (nonatomic, retain)NSString *citName;
@property (nonatomic, retain)UIImageView *tempImage;
@property (nonatomic, retain)UIView *bigview;
@property (nonatomic, retain)UILabel *temp;
@property (nonatomic, retain)UILabel *weather;
@property (nonatomic, retain)NSString *weathers;
@property (nonatomic, retain)NSString *location;
@property (nonatomic, copy)NSString* longitude;
@property (nonatomic, copy)NSString* latitude;
@end

@implementation PNMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   self.view.backgroundColor = [UIColor purpleColor];
    
    self.citName = @"宝鸡";
    
     [self addTitleViewWithTitle:@"地图"];
    
      _mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0,self.view.bounds.size.width,self.view.bounds.size.height - 50)];
   self.view = _mapView;
    //设定地图View能否支持用户多点缩放(双指)
    _mapView.zoomEnabled =YES;
    
    //设置地图上是否显示比例尺
    _mapView.showMapScaleBar =YES;
    //设置地图比例尺在地图上的位置
    _mapView.mapScaleBarPosition =CGPointMake(10,_mapView.frame.size.height-60);

     [self setUPLocService]; // 使用定位服务
    
    [self postJson];
    
    self.bigview = [[UIView alloc] initWithFrame:RECTMACK(10, 10,SCREEN_WIDTH / 4 + 5, SCREEN_WIDTH / 8 + 2)];
    self.bigview.backgroundColor = [UIColor redColor];
    [self.view addSubview: self.bigview];
    [self setWeather]; // 添加天气视图
    
//    [self getMap];
   
}

- (void)setWeather{
    UIView *weather = [[UIView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH / 4 + 5, SCREEN_WIDTH / 8 + 2)];
    weather.backgroundColor = COLOUR(255, 255, 255, 0.5);
    [_bigview addSubview: weather];
    weather.layer.cornerRadius = 5;
    self.tempImage = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, SCREEN_WIDTH / 15, SCREEN_WIDTH / 15)];
    _tempImage.image = [UIImage imageNamed:@"w1.png"];
    
    self.temp = [[UILabel alloc] initWithFrame:CGRectMake(5 + SCREEN_WIDTH / 15, 5, SCREEN_WIDTH / 4 - 5 - SCREEN_WIDTH / 15, SCREEN_WIDTH / 15)];
    _temp.font = [UIFont systemFontOfSize:10*SCREEN_WIDTH/414];
    _temp.textAlignment = NSTextAlignmentCenter;
    _temp.textColor = [UIColor whiteColor];
    _temp.text = @"无";
    
    [weather addSubview: _tempImage];
    [weather addSubview: _temp];
    
    self.weather = [[UILabel alloc] initWithFrame:CGRectMake(5, SCREEN_WIDTH / 15 + 5, 135, 13)];
    _weather.font = [UIFont systemFontOfSize:9*SCREEN_WIDTH/414];
    _weather.textColor = [UIColor whiteColor];
    NSString *wea = @"暂无";
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy/MM/dd"];
    NSString *date = [formatter stringFromDate:[NSDate date]];
    NSString *all = [NSString stringWithFormat:@"%@|%@",date,wea];
    _weather.text = all;
    _weather.textAlignment = NSTextAlignmentLeft;
    [weather addSubview: _weather];
    [self getWeather];
    
}

- (void)getWeather{
    NetWorkingHelpper *net = [[NetWorkingHelpper alloc] init];
    net.delegate = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
     [net getAndSynchronousMethodWithUrl:[[NSString stringWithFormat:@"http://apicloud.mob.com/v1/weather/query?key=18da0d9f1b813&city=宝鸡&province=陕西"]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        dispatch_async(dispatch_get_main_queue(), ^{
            //             [self setCarMassage];
            _tempImage.image = [UIImage imageNamed:self.weathers];
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy/MM/dd"];
            NSString *date = [formatter stringFromDate:[NSDate date]];
            
           // NSLog(@"%@",self.str2);
            NSString *all = [NSString stringWithFormat:@"%@|%@",date,self.str1];
            _weather.text = all;
            _temp.text = self.str2;

            //NSLog(@"%@",_temp.text);
        });
    });
}

- (void)getWeather1{
    
    
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];//默认的方式
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
#warning 请输入注册调用的网址
        
        NSString *urlStringlogin = [[NSString stringWithFormat:@"http://apicloud.mob.com/v1/weather/query?key=18da0d9f1b813&city=宝鸡&province=陕西"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
    

    [manager GET:urlStringlogin parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        NSString *result = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        
//        NSLog(@"result = %@",responseObject);
//        
//        NSLog(@"========%@",result);

        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
//        NSLog(@"请求失败");
//        NSLog(@"%@",error);
    }];
      
   
}


- (void)getMap{
    

    
    // 取出name
    
    NSDictionary *dic = [[NSUserDefaults standardUserDefaults]objectForKey:@"ResultAuthData"];
    
    NSLog(@"hhhhhhh%@",dic);
    
    
        // 取出uid
        NSString *uid = [dic objectForKey:@"uid"];
#warning 请输入上传位置信息的接口

        
        NSString *urlString = @"http://192.168.0.156:8080/miningbee-web/ws/userLocation/getNearUser";
        urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *url = [NSURL URLWithString:urlString];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        request.HTTPMethod = @"POST";
        
        // 2.设置请求头
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
//        NSString *longitude = [NSString stringWithFormat:@"%f",self.longitude];
//        NSString *latitude = [NSString stringWithFormat:@"%f",self.latitude];
    
    
    NSLog(@"llllll%@%@",self.longitude,self.latitude);
    if(dic ==nil){
        uid = @"";
    }
        // 3.设置请求体
        NSDictionary *json = @{
                               @"uid":uid,
                               @"longitude":self.longitude,
                               @"latitude":self.latitude,
                               };
    
        //    NSData --> NSDictionary
        // NSDictionary --> NSData
        NSData *data = [NSJSONSerialization dataWithJSONObject:json options:NSJSONReadingAllowFragments error:nil];
        request.HTTPBody = data;
        NSLog(@"sssssssss%lu", (unsigned long)data.length);
        
        // 4.发送请求
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            NSLog(@"cccccccccccc%lu", (unsigned long)data.length);
            
            NSLog(@"yyyyyyyyyyyyy%@",connectionError);
            
            NSLog(@"zzzzzzzzzz%@",response);
            
        }];
        
        
    
}



- (void)passValueWithData:(id)value{
    NSArray *arr = [NSArray arrayWithArray:[value objectForKey:@"result"]];
    NSArray *array = [arr[0] objectForKey:@"future"];
    NSString *temperature = [array[0] objectForKey:@"temperature"];
    NSString *weather = [arr[0] objectForKey:@"weather"];
    self.str1 = weather;
    self.str2 = temperature;
    if ([weather isEqualToString:@"阵雨"] || [weather isEqualToString:@"零散阵雨"]) {
        self.weathers=@"w4.png";
    }else if ([weather isEqualToString:@"晴"]) {
        self.weathers=@"w0.png";;
    }else if ([weather isEqualToString:@"少云"] || [weather isEqualToString:@"局部多云"]) {
        self.weathers=@"w1.png";
    }else if ([weather isEqualToString:@"阴"] || [weather isEqualToString:@"多云"]) {
        self.weathers=@"w2.png";
    }else if ([weather isEqualToString:@"小雪"] || [weather isEqualToString:@"中雪"] || [weather isEqualToString:@"大雪"] || [weather isEqualToString:@"小雪-中雪"]) {
        self.weathers=@"w27.png";
    }else if ([weather isEqualToString:@"小雨"] || [weather isEqualToString:@"中雨"] || [weather isEqualToString:@"大雨"] || [weather isEqualToString:@"雨"] || [weather isEqualToString:@"小到中雨"]) {
        self.weathers=@"w9.png";
    }else if ([weather isEqualToString:@"冰雹"] || [weather isEqualToString:@"雨夹雪"]) {
        self.weathers=@"w5.png";
        
    }else if ([weather isKindOfClass:[NSString class]]){
        self.weathers=@"w29.png";
    }
    
    
}


- (void)setUPLocService{
    
    //适配ios7
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0))
    {
        self.navigationController.navigationBar.translucent = NO;
    }
    _locService = [[BMKLocationService alloc]init];
    
}



- (void)viewWillAppear:(BOOL)animated
{
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
     _locService.delegate = self;
     [_locService startUserLocationService];
    NSLog(@"sssssss");
    _mapView.showsUserLocation = NO;//先关闭显示的定位图层
    _mapView.userTrackingMode = BMKUserTrackingModeFollow;//设置定位的状态
    _mapView.showsUserLocation = YES;//显示定位图层
    NSLog(@"zzzzzzzz");

}
-(void)viewWillDisappear:(BOOL)animated
{
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    _locService.delegate = nil;
}


- (void)viewDidAppear:(BOOL)animated{
    
    // 添加一个PointAnnotation
//    BMKPointAnnotation* annotation= [[BMKPointAnnotation alloc]init];
//    CLLocationCoordinate2D coor;
//    coor.latitude= 108.54;
//    coor.longitude= 34.16;
//    annotation.coordinate= coor;
//    annotation.title= @"这里是na";
//    [_mapView addAnnotation:annotation];
    
}


//// Override
//- (BMKAnnotationView*)mapView:(BMKMapView*)mapView viewForAnnotation:(id<BMKAnnotation>)annotation
//{
//    if([annotation isKindOfClass:[BMKPointAnnotation class]]) {
//        BMKPinAnnotationView *newAnnotationView= [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
//        newAnnotationView.pinColor= BMKPinAnnotationColorPurple;     //设置大头针的颜色
//        newAnnotationView.animatesDrop= YES;// 设置该标注点动画显示
//        //设置大头针在地图上是否可以拖动
//        newAnnotationView.draggable =YES;
//        
//        return newAnnotationView;
//    }
//    return nil;
//}




/**
 *在地图View将要启动定位时，会调用此函数
 *@param mapView 地图View
 */
- (void)willStartLocatingUser
{
    NSLog(@"start locate");
}

/**
 *用户方向更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    //获取自身的位置
    CLLocationCoordinate2D coor = CLLocationCoordinate2DMake(userLocation.location.coordinate.latitude, userLocation.location.coordinate.longitude);
    //将中心点设置为自身位置
    _mapView.centerCoordinate = coor;
    BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
    annotation.coordinate = coor;
    [_mapView addAnnotation:annotation];
    
    
    [_mapView updateLocationData:userLocation];
    NSLog(@"heading is %@",userLocation.heading);
}

/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    
    CLLocationCoordinate2D coor = CLLocationCoordinate2DMake(userLocation.location.coordinate.latitude, userLocation.location.coordinate.longitude);
    //将中心点设置为自身位置
    _mapView.centerCoordinate = coor;
    BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
    annotation.coordinate = coor;
    [_mapView addAnnotation:annotation];

    
    
    NSString *longitude = [NSString stringWithFormat:@"%f",userLocation.location.coordinate.longitude];
    NSString *latitude = [NSString stringWithFormat:@"%f",userLocation.location.coordinate.latitude];
    
   //  NSLog(@"longitude1 = %@, latitude1 = %@",longitude,latitude);
    
    NSString  *distance = [NSString stringWithFormat:@"%d",200];
    
    _locationDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:longitude,@"longitude",latitude,@"latitude",distance,@"distance",nil];

    
    //NSLog(@"%@",_locationDic);
    NSLog(@"=============didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    
    self.longitude = [NSString stringWithFormat:@"%f",userLocation.location.coordinate.longitude];
    self.latitude = [NSString stringWithFormat:@"%f",userLocation.location.coordinate.latitude];
    
    NSLog(@"xxxxxxxxxx%@,%@",self.longitude,self.latitude);
    
   // [self getMap];
    [_mapView updateLocationData:userLocation];
}


- (void)postJson
{
    
   

    NSURL *url = [NSURL URLWithString:@"http://localhost/post/postjson.php"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"post";
    
    
    if (_locationDic) {
        
        // 序列化
        NSData *data = [NSJSONSerialization dataWithJSONObject:_locationDic options:0 error:NULL];
        request.HTTPBody = data;
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            id res = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
           // NSLog(@"%@",res);
        }];

    }
 }

/**
 *在地图View停止定位后，会调用此函数
 *@param mapView 地图View
 */
- (void)didStopLocatingUser
{
    NSLog(@"stop locate");
}

/**
 *定位失败后，会调用此函数
 *@param mapView 地图View
 *@param error 错误号，参考CLError.h中定义的错误号
 */
- (void)didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"location error");
    NSLog(@"8888888888%ld",(long)error.code);
}

// 上传位置坐标
- (void)mapView:(BMKMapView *)mapView didUpdateUserLocation:(BMKUserLocation *)userLocation{
    
    NSString *longitude = [NSString stringWithFormat:@"%f",userLocation.location.coordinate.longitude];
    NSString *latitude = [NSString stringWithFormat:@"%f",userLocation.location.coordinate.latitude];
    
    NSLog(@"longitude = %@, latitude = %@",longitude,latitude);
    BMKRadarNearbySearchOption *option = [[BMKRadarNearbySearchOption alloc] init]
    ;
    option.radius = 8000;
    option.sortType = BMK_RADAR_SORT_TYPE_DISTANCE_FROM_NEAR_TO_FAR;
    option.centerPt = _myCoor;
    
    NSString *radius = [@8000 stringValue];
    NSDictionary *locationDic = [NSDictionary dictionaryWithObjectsAndKeys:longitude,@"longitude",latitude,@"latitude",radius,@"radius",nil];

    NSLog(@"%@。。。。。。",locationDic);
    

    
}


#pragma mark -lazy


-(NSString *)longitude{
    if (!_longitude) {
        _longitude = [[NSString alloc]init];
    }
    
    return _longitude;
}

- (NSString *)latitude{
    if (!_latitude) {
        _latitude = [[NSString alloc]init];
    }
    return _latitude;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)dealloc {
    if (_mapView) {
        _mapView = nil;
    }
}


@end
