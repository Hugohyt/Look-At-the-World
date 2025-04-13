//
//  CommentCell.m
//  Look At the World
//
//  Created by 胡永泰 on 2025/3/26.
//

#import "CommentCell.h"
#import "Masonry/Masonry.h"

@implementation CommentCell

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
    
    self.commentTextView = [[UITextView alloc] init];
    [self.commentTextView setFont:[UIFont systemFontOfSize:17]];
    self.commentTextView.textColor = [UIColor darkGrayColor];
    self.commentTextView.delegate = self;
    self.commentTextView.scrollEnabled = NO;
    self.commentTextView.selectable = NO;
//    self.replyTextView.selectable = NO;
    self.commentTextView.editable = NO;
    [self.contentView addSubview:self.commentTextView];
    
    self.nameLabel = [[UILabel alloc] init];
    [self.nameLabel setFont:[UIFont boldSystemFontOfSize:18]];
    [self.contentView addSubview:self.nameLabel];
    
    self.nameIcon = [[UIImageView alloc] init];
    [self.contentView addSubview:self.nameIcon];
    
    self.timeLabel = [[UILabel alloc] init];
    [self.timeLabel setFont:[UIFont systemFontOfSize:16]];
    [self.timeLabel setTextColor:[UIColor lightGrayColor]];
    [self.contentView addSubview:self.timeLabel];
    
//    self.likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [self.contentView addSubview:self.likeButton];
//    [self.likeButton setImage:[UIImage imageNamed:@"评论点赞.jpg"] forState:UIControlStateNormal];
//    self.likeButton.tag = 101;
//    [self.likeButton addTarget:self action:@selector(likes:) forControlEvents:UIControlEventTouchUpInside];
//    
//    self.likes = [[UILabel alloc] init];
//    [self.contentView addSubview:self.likes];
    
    [self.commentTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameIcon).offset(20);
        make.left.mas_equalTo(78);
        make.width.mas_equalTo(300);
    }];
    [self.nameIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.left.mas_equalTo(20);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(40);
    }];
    self.nameIcon.layer.cornerRadius = 20;
    self.nameIcon.layer.masksToBounds = YES;
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(80);
        make.width.mas_equalTo(300);
        make.height.mas_equalTo(20);
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.commentTextView.mas_bottom).mas_offset(10);
        make.left.mas_equalTo(80);
        make.width.mas_equalTo(180);
        make.height.mas_equalTo(20);
        make.bottom.mas_equalTo(self.contentView).mas_offset(-20);
    }];
//    [self.likeButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.commentTextView.mas_bottom).mas_offset(20);
//        make.left.mas_equalTo(300);
//        make.height.mas_equalTo(20);
//        make.width.mas_equalTo(20);
//    }];
//    [self.likes mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.commentTextView.mas_bottom).mas_offset(20);
//        make.left.mas_equalTo(280);
//        make.height.mas_equalTo(20);
//        make.width.mas_equalTo(20);
//    }];
    
    return self;
}

- (void)likes:(UIButton*) button {
    if (button.tag == 101) {
        [button setImage:[UIImage imageNamed:@"评论已点赞.jpg"] forState:UIControlStateNormal];
        self.likes.text = [NSString stringWithFormat:@"%d",[self.likes.text intValue] + 1];
        button.tag = 102;
    } else {
        [button setImage:[UIImage imageNamed:@"评论点赞.jpg"] forState:UIControlStateNormal];
        self.likes.text = [NSString stringWithFormat:@"%d",[self.likes.text intValue] - 1];
        button.tag = 101;
    }
}

//- (void)setupCellShortCommentsDate:(CommentModel*)model {
//    NSString *suffixStr = @"";
//    NSMutableString* replyString = [NSMutableString stringWithFormat:@"//%@",model.reply_to[@"author"]];
//    [replyString appendString:[NSString stringWithFormat:@":%@",model.reply_to[@"content"]]];
//    NSString *contentStr = [NSString stringWithFormat:@"%@", replyString];
//    CGFloat H = model.titleActualH;
//    NSLog(@"daomeidao");
//    
//    if (model.titleActualH > model.titleMaxH) {
//        if (model.isOpen) {
//            NSLog(@"1le");
//            suffixStr = @"收起";
//            contentStr = [NSString stringWithFormat:@"%@ %@", contentStr, suffixStr];
//            H = model.titleActualH;
//        } else {
//            NSLog(@"2le");
//            NSUInteger numCount = 1;
//            CGFloat W = 300;
//            NSString *tempStr = [self stringByTruncatingString:contentStr suffixStr:@"...展开" font:[UIFont systemFontOfSize:17] forLength:W * numCount];
//            contentStr = tempStr;
//            suffixStr = @"展开";
//            H = model.titleMaxH;
//        }
//    }
//    
//    NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc] initWithString:contentStr attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:[UIColor lightGrayColor]}];
//    self.replyTextView.linkTextAttributes = @{};
//    
//    if (suffixStr != NULL) {
//        NSRange range3 = [contentStr rangeOfString:suffixStr];
//        [attStr addAttribute:NSForegroundColorAttributeName value:[UIColor systemGrayColor] range:range3];
//        NSString *valueString3 = [[NSString stringWithFormat:@"didOpenClose://%@", suffixStr] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
//        [attStr addAttribute:NSLinkAttributeName value:valueString3 range:range3];
//    }
//    self.replyTextView.attributedText = attStr;
//}
//
//- (NSString*)stringByTruncatingString:(NSString*)str suffixStr:(NSString*)suffixStr font:(UIFont *)font forLength:(CGFloat)length {
//    NSLog(@"nitian:%lu",length);
//    if (!str) {
//        return nil;
//    }
//    if (str && [str isKindOfClass:[NSString class]]) {
//        for (int i = (int)[str length] - (int)[suffixStr length]; i < [str length]; i = i - (int)[suffixStr length]) {
//            NSString *tempStr = [str substringToIndex:i];
//            CGSize size = [tempStr sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]}];
//            if (size.width < length) {
//                NSLog(@"changdu:%lu %lu",size.width, length);
//                tempStr = [NSString stringWithFormat:@"%@%@",tempStr, suffixStr];
//                CGSize size1 = [tempStr sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]}];
//                if (size1.width < length) {
//                    str = tempStr;
//                    break;
//                }
//            }
//        }
//    }
//    return str;
//}
//
//- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange {
//    if ([[URL scheme] isEqualToString:@"didOpenClose"]) {
//        NSLog(@"触发啦");
//        if (self.openCloseBlock) {
//            self.openCloseBlock();
//        }
//        return NO;
//    }
//    return YES;
//}

@end
