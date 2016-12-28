//
//  CityTextFieldCell.h
//  ContactBook
//
//

#import <UIKit/UIKit.h>

@interface CityTextFieldCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextField *textfield;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
