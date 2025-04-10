//
//  ArticleScrollTableViewCell.m
//  Look At the World
//
//  Created by 胡永泰 on 2025/3/25.
//

#import "ArticleScrollTableViewCell.h"
#import "Masonry/Masonry.h"
#import "UIImageView+WebCache.h"

@implementation ArticleScrollTableViewCell

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
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    self.imageScrollView = [[UIScrollView alloc] init];
    self.imageScrollView.showsHorizontalScrollIndicator = NO;
    self.imageScrollView.pagingEnabled = YES;
    [self.contentView addSubview:self.imageScrollView];
    
    [self.imageScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.contentView);
            make.top.bottom.equalTo(self.contentView);
            make.height.mas_lessThanOrEqualTo(500);
    }];
    
    self.imageStackView = [[UIStackView alloc] init];
    self.imageStackView.axis = UILayoutConstraintAxisHorizontal;
    [self.imageScrollView addSubview:self.imageStackView];
    
    [self.imageStackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.imageScrollView);
        make.height.equalTo(self.imageScrollView);
    }];
}

- (void)configureWithImages:(NSArray<NSString *> *)imageURLs {

    for (UIView *subview in self.imageStackView.arrangedSubviews) {
        [subview removeFromSuperview];
    }
    
    UIView *lastView = nil;
    
    for (NSString *imageURL in imageURLs) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.clipsToBounds = YES;
        imageView.backgroundColor = [UIColor lightGrayColor];
        NSURL *url = [NSURL URLWithString:imageURL];
        [imageView sd_setImageWithURL:url];
        imageView.backgroundColor = [UIColor whiteColor];
        imageView.contentMode = UIViewContentModeScaleToFill;
        
        [self.imageStackView addArrangedSubview:imageView];
        
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(self.contentView.mas_width);
            make.height.equalTo(self.imageStackView.mas_height);
        }];
        
        lastView = imageView;
    }
}

@end
