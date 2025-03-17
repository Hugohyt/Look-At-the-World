//
//  ListTableViewCell.m
//  Look At the World
//
//  Created by 胡永泰 on 2025/3/5.
//

#import "ListTableViewCell.h"

@implementation ListTableViewCell

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
    
    self.sightsImageView = [[UIImageView alloc] init];
    self.sightsProductionLabel = [[UILabel alloc] init];
    self.sightsLocationLabel = [[UILabel alloc] init];
    self.sightsNameLabel = [[UILabel alloc] init];
    
    self.sightsImageView.frame = CGRectMake(10, 5, 110, 110);
    self.sightsProductionLabel.frame = CGRectMake(130, 40, 264, 60);
    self.sightsLocationLabel.frame = CGRectMake(130, 96, 394, 20);
    self.sightsNameLabel.frame = CGRectMake(130, 10, 394, 40);
    
    self.sightsNameLabel.font = [UIFont systemFontOfSize:30];
    self.sightsNameLabel.textColor = [UIColor colorWithRed:91/255.0 green:58/255.0 blue:41/255.0 alpha:1.0];
    
    self.sightsProductionLabel.font = [UIFont systemFontOfSize:16];
    self.sightsProductionLabel.textColor = [UIColor colorWithRed:184/255.0 green:154/255.0 blue:116/255.0 alpha:1.0];
    self.sightsProductionLabel.numberOfLines = 0;
    self.sightsProductionLabel.lineBreakMode = YES;
    
    self.sightsLocationLabel.textColor = [UIColor lightGrayColor];
    self.sightsLocationLabel.font = [UIFont systemFontOfSize:14];

    self.sightsImageView.image = [UIImage imageNamed:@"西安.jpg"];
    [self.sightsProductionLabel setText:@"城墙花朵怒放成海，古都浪漫秘境等你来打卡"];
    [self.sightsLocationLabel setText:@"中国·西安"];
    [self.sightsNameLabel setText:@"西安城墙"];
    
    self.sightsImageView.layer.cornerRadius = 6;
    self.sightsImageView.layer.masksToBounds = YES;
    

    [self.contentView addSubview:self.sightsImageView];
    [self.contentView addSubview:self.sightsProductionLabel];
    [self.contentView addSubview:self.sightsLocationLabel];
    [self.contentView addSubview:self.sightsNameLabel];
    
    return self;
}

@end
