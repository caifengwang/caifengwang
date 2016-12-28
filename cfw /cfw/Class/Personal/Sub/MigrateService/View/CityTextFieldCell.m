//
//  CityTextFieldCell.m
//  ContactBook
//
//

#import "CityTextFieldCell.h"

@implementation CityTextFieldCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString * ID = @"CityTextFieldCell";
    CityTextFieldCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:ID owner:nil options:nil]lastObject];
    }
    
    return cell;
}

@end
