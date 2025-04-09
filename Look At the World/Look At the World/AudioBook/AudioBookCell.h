//
//  AudioBookCell.h
//  Look At the World
//
//  Created by 李睿鑫 on 2025/3/9.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>
#import "AudioBooksButton.h"
NS_ASSUME_NONNULL_BEGIN

@interface AudioBookCell : UITableViewCell
@property (nonatomic, strong) AudioBooksButton* btn1;
@property (nonatomic, strong) AudioBooksButton* btn2;
@property (nonatomic, strong) AudioBooksButton* btn3;
@property (nonatomic, strong) UILabel* titleLabel;
@end

NS_ASSUME_NONNULL_END
