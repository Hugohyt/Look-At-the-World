//
//  AudioDetailsAuthorCell.h
//  Look At the World
//
//  Created by 李睿鑫 on 2025/3/25.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>
NS_ASSUME_NONNULL_BEGIN

@interface AudioDetailsAuthorCell : UITableViewCell
@property (nonatomic, strong) UIImageView* bookImage;
@property (nonatomic, strong) UILabel* bookName;
@property (nonatomic, strong) UILabel* authorName;
@property (nonatomic, strong) UILabel* scoreLabel;
@property (nonatomic, strong) UILabel* numberLabel;
@property (nonatomic, strong) UILabel* chaoterLabel;
@property (nonatomic, strong) UILabel* renewLabel;
@property (nonatomic, strong) UILabel* scoreSubLabel;
@property (nonatomic, strong) UILabel* numberSubLabel;
@property (nonatomic, strong) UILabel* chaoterSubLabel;
@property (nonatomic, strong) UILabel* renewSubLabel;

@end

NS_ASSUME_NONNULL_END
