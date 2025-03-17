//
//  ButtonTableViewCell.m
//  Look At the World
//
//  Created by 胡永泰 on 2025/3/5.
//

#import "ButtonTableViewCell.h"
#import "Masonry.h"

@implementation ButtonTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    [self setBackgroundColor:[UIColor whiteColor]];
    NSArray *images = [NSArray arrayWithObjects:[UIImage imageNamed:@"北京按钮.jpg"], [UIImage imageNamed:@"深圳按钮.jpg"], [UIImage imageNamed:@"三亚按钮.jpg"], [UIImage imageNamed:@"杭州按钮.jpg"], [UIImage imageNamed:@"桂林按钮.jpg"], [UIImage imageNamed:@"大连按钮.jpg"], [UIImage imageNamed:@"大理按钮.jpg"], [UIImage imageNamed:@"成都按钮.jpg"], nil];
    NSArray* titles = [NSArray arrayWithObjects:@"北京", @"深圳", @"三亚", @"杭州", @"桂林", @"大连", @"大理", @"成都", nil];
    
    self.buttons = [NSMutableArray array];
    for (int i = 0; i < 8; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setImage:images[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithRed:184/255.0 green:154/255.0 blue:116/255.0 alpha:1.0] forState:UIControlStateNormal];
        [self.contentView addSubview:button];
        [self.buttons addObject:button];
        button.imageEdgeInsets = UIEdgeInsetsMake(-20, 0, 0, -button.titleLabel.intrinsicContentSize.width);
        button.titleEdgeInsets = UIEdgeInsetsMake(50, -50, 0, 0);
    }
    
    int columns = 4;
    CGFloat buttonSpacing = 5;
    CGFloat buttonWidth = (394 - (columns - 1) * buttonSpacing) / columns;
    CGFloat buttonHeight = 95;
    
    [self.buttons enumerateObjectsUsingBlock:^(UIButton * _Nonnull button, NSUInteger idx, BOOL * _Nonnull stop) {
        int row = (int)(idx / columns);
        int col = (int)(idx % columns);
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(row * (buttonHeight + buttonSpacing));
            make.left.equalTo(self.contentView).offset(col * (buttonWidth + buttonSpacing));
            make.width.equalTo(@(buttonWidth));
            make.height.equalTo(@(buttonHeight));
        }];
    }];
    
    return self;
}

@end
