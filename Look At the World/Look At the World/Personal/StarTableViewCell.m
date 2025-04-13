//
//  StarTableViewCell.m
//  Look At the World
//
//  Created by 李睿鑫 on 2025/4/9.
//

#import "StarTableViewCell.h"
#import "Masonry/Masonry.h"

@implementation StarTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:@"StarTableViewCell"];
    self.iconImageView = [[UIImageView alloc] init];
    self.nameLabel = [[UILabel alloc] init];
    return self;
}

- (void)layoutSubviews {
    
}

- (void)configureWithModel:(StarModel*)model {
    [self.nameLabel setText:model.name];
    [self.iconImageView setImage:model.image];
}



@end
