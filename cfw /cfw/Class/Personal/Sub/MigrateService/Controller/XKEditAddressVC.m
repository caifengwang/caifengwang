//
//  XKEditAddressVC.m
//  XKContactBook
//

#import "XKEditAddressVC.h"

#import "CityTextFieldCell.h"


@interface XKEditAddressVC ()<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>
//@property (nonatomic, strong) NSMutableArray *contactArray;
@property (nonatomic, strong) UITableView    *tableView;
@property (nonatomic, strong) UITextField    *textField;
@end

@implementation XKEditAddressVC

{
    
    NSArray * provinces;
    NSMutableArray * xkprovinces;//城市
    NSMutableArray *xkPartArr;//市区数组
    NSMutableArray *xkTempArr;//临时数组
    
    BOOL isSecond;
    BOOL isThird;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"城市选择";

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(save)];
    
    self.tableView                 = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH  ,SCREEN_HEIGHT)];
    self.tableView.delegate        = self;
    self.tableView.dataSource      = self;
    self.tableView.tableFooterView = [UIView new];
    
    [self.view addSubview:self.tableView];
    
    [self setData];
}

- (void)save{
    NSMutableString *str = [[NSMutableString alloc] init];
    
    if (xkTempArr.count < 4) {
        for (NSString *s in xkTempArr) {
            [str appendFormat:@"%@",s];
        }
    }else{
        return;
    }
    
    [str appendFormat:@"%@",[NSString getNil:self.textField.text]];
    
    [self.navigationController popViewControllerAnimated:YES];
    self.completionBlock(1,str);
}

- (void)setData
{
    
    provinces = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"city.plist" ofType:nil]];
    
    xkprovinces = [NSMutableArray array];
    xkPartArr = [[NSMutableArray alloc] init];
    xkTempArr = [[NSMutableArray alloc] init];
    
    for (int p = 0; p <[provinces count]; p ++) {
        NSDictionary * province = [provinces objectAtIndex:p];
        NSString *state = province[@"state"];//市
        
        NSArray *cities = province[@"cities"];//区
        
        NSMutableArray *arr = [[NSMutableArray alloc] initWithArray:cities];
        [arr removeObjectAtIndex:0];//去除地区"所有地区"字样
        
        [xkprovinces addObject:state];
        
        if (p > 0) {
            NSMutableDictionary *xkPartsDic = [[NSMutableDictionary alloc] init];
            [xkPartsDic setObject:arr forKey:state];
            [xkPartArr addObject:xkPartsDic];
            
        }
    }
    
    [xkprovinces removeObjectAtIndex:0];//去除城市"所有地区"字样
    
    xkTempArr = [xkprovinces mutableCopy];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (isThird &&  xkTempArr.count < 3) {
        return xkTempArr.count + 1;
    }
    return [xkTempArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    if (isThird && indexPath.row == 2) {
        
        CityTextFieldCell *textCell = [CityTextFieldCell cellWithTableView:tableView];
        self.textField = textCell.textfield;
        return textCell;
    }
    
    
    NSString * psitem = [xkTempArr safe_objectAtIndex:indexPath.row];
    cell.textLabel.text = psitem;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (!isSecond) {
        
        NSString *item = [xkTempArr safe_objectAtIndex:indexPath.row];
        [xkTempArr removeAllObjects];
        [xkTempArr safe_addObject:item];
        
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        dic = [xkPartArr safe_objectAtIndex:indexPath.row];
        NSArray *arr = dic[item];
        for (NSString *str in arr) {
            [xkTempArr safe_addObject:str];
        }
        
        isSecond = YES;
        isThird = NO;
        [self.tableView reloadData];
        
    }else if(isSecond && indexPath.row == 0){
        /*只显示城市*/
        
        xkTempArr = [xkprovinces mutableCopy];
        [self.tableView reloadData];
        isSecond = NO;
        isThird = NO;
    }
    
    else if(!isThird){
        NSString *str0 = [xkTempArr safe_objectAtIndex:0];
        
        NSString *item = [xkTempArr safe_objectAtIndex:indexPath.row];
        
        [xkTempArr removeAllObjects];
        [xkTempArr safe_addObject:str0];
        [xkTempArr safe_addObject:item];
        isThird = YES;
        [self.tableView reloadData];
        
    }else if (isThird && indexPath.row == 1){
        NSString *str0 = [xkTempArr safe_objectAtIndex:0];
        [xkTempArr removeAllObjects];
        [xkTempArr safe_addObject:str0];
        
        int index = 0;
        for (int i = 0; i < xkprovinces.count; i++) {
            if ([str0 isEqualToString:[xkprovinces safe_objectAtIndex:i]]) {
                index = i;
                break;
            }
        }
        
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        dic = [xkPartArr safe_objectAtIndex:index];
        NSArray *arr = dic[str0];
        for (NSString *str in arr) {
            [xkTempArr addObject:str];
        }
        isThird = NO;
        [self.tableView reloadData];
    }
    
}
@end
