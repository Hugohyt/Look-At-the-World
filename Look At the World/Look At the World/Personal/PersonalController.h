//
//  PersonalController.h
//  Look At the World
//
//  Created by 李睿鑫 on 2025/4/9.
//

#import <UIKit/UIKit.h>
#import "PersonalView.h"
#import "ManagerPost.h"
#import "NOticeModel.h"
#import <YYModel/YYModel.h>

NS_ASSUME_NONNULL_BEGIN

@interface PersonalController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic)PersonalView* personalView;

@end

NS_ASSUME_NONNULL_END
