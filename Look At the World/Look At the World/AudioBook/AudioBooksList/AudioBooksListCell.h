//
//  AudioBooksListCell.h
//  Look At the World
//
//  Created by 李睿鑫 on 2025/4/4.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>
NS_ASSUME_NONNULL_BEGIN

@interface AudioBooksListCell : UITableViewCell
@property (nonatomic, strong) UIImageView* coverIamge;
@property (nonatomic, strong) UILabel* nameLabel;
@property (nonatomic, strong) UILabel* authorLabel;
@property (nonatomic, strong) UILabel* playCount;
@property (nonatomic, strong) UIImageView* playImage;

@end

NS_ASSUME_NONNULL_END
