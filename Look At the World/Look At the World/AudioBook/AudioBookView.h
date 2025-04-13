//
//  AudioBookView.h
//  Look At the World
//
//  Created by 李睿鑫 on 2025/3/9.
//

#import <UIKit/UIKit.h>
#import "AudioBookCell.h"
#import "AudioScrollTableViewCell.h"
#import "IrregularButtonCell.h"
NS_ASSUME_NONNULL_BEGIN

@interface AudioBookView : UIView
@property (nonatomic, strong) UITableView* booksTableview;
@end

NS_ASSUME_NONNULL_END
