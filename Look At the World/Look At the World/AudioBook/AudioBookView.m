//
//  AudioBookView.m
//  Look At the World
//
//  Created by 李睿鑫 on 2025/3/9.
//

#import "AudioBookView.h"


static const CGFloat width = 393;

@implementation AudioBookView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.booksTableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 97, width, 660) style:UITableViewStyleGrouped];
        [self.booksTableview registerClass:[AudioScrollTableViewCell class] forCellReuseIdentifier:@"AudioScrollTableViewCell"];
        [self.booksTableview registerClass:[AudioBookCell class] forCellReuseIdentifier:@"ButtonTableViewCell"];
        [self.booksTableview registerClass:[IrregularButtonCell class] forCellReuseIdentifier:@"IrregularButtonCell"];
        self.booksTableview.sectionHeaderHeight = 10;
        self.booksTableview.sectionFooterHeight = 10;
//        UIView* backgroundView  = [[UIView alloc] initWithFrame:self.booksTableview.bounds];
//        UIImageView* backgroundImage = [[UIImageView alloc] initWithFrame:backgroundView.bounds];
//        backgroundImage.image = [UIImage imageNamed:@"tableBackground.jpeg"];
//        [backgroundView addSubview:backgroundImage];
//        self.booksTableview.backgroundView = backgroundView;
        self.booksTableview.backgroundColor = [UIColor clearColor];
        self.booksTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self addSubview:self.booksTableview];
        return self;
    }
    return self;
}

@end
