//
//  ArticleScrollTableViewCell.h
//  Look At the World
//
//  Created by 胡永泰 on 2025/3/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ArticleScrollTableViewCell : UITableViewCell

@property (strong, nonatomic, readwrite)UIScrollView* imageScrollView;
@property (strong, nonatomic, readwrite)NSArray* imageArray;
@property (strong, nonatomic, readwrite)UIStackView* imageStackView;

- (void)configureWithImages:(NSArray<NSString *> *)imageURLs;

@end

NS_ASSUME_NONNULL_END
