//
//  AudioPlayView.h
//  Look At the World
//
//  Created by 李睿鑫 on 2025/3/18.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>
NS_ASSUME_NONNULL_BEGIN

@interface AudioPlayView : UIView

@property (nonatomic, strong) UIImageView* coverImage;
@property (nonatomic, strong) UIButton* downloadBtn;
@property (nonatomic, strong) UIButton* multipleBtn;
@property (nonatomic, strong) UIButton* goodBtn;
@property (nonatomic, strong) UIButton* commentBtn;
@property (nonatomic, strong) UIProgressView* slider;
@property (nonatomic, strong) UIButton* priorBtn;
@property (nonatomic, strong) UIButton* playBtn;
@property (nonatomic, strong) UIButton* nextBtn;
@property (nonatomic, strong) UILabel* totalTimeLabel;
@property (nonatomic, strong) UILabel* currentTimeLabel;
@property (nonatomic, strong) UILabel* authorLabel;
@property (nonatomic, strong) UILabel* titleLabel;
@property (nonatomic, strong) UIScrollView* titleScrollView;


@end

NS_ASSUME_NONNULL_END
