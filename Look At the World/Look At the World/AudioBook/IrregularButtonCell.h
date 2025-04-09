//
//  IrregularButtonCell.h
//  Look At the World
//
//  Created by 李睿鑫 on 2025/3/17.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>
#import "IrregularButton.h"
NS_ASSUME_NONNULL_BEGIN

@interface IrregularButtonCell : UITableViewCell
@property (nonatomic, strong) IrregularButton* btn1;
@property (nonatomic, strong) IrregularButton* btn2;
@property (nonatomic, strong) IrregularButton* btn3;
@end

NS_ASSUME_NONNULL_END
