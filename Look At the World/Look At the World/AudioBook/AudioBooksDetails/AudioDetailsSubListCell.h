//
//  AudioDetailsSubListCell.h
//  Look At the World
//
//  Created by 李睿鑫 on 2025/3/25.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>
NS_ASSUME_NONNULL_BEGIN

@interface AudioDetailsSubListCell : UITableViewCell

@property (nonatomic, strong) UILabel* title;
@property (nonatomic, strong) UILabel* playTime;
@property (nonatomic, strong) UIButton* downloadBtn;
@property (nonatomic, strong) UILabel* numberLabel;

@end

NS_ASSUME_NONNULL_END
