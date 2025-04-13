//
//  PersonalController.h
//  Look At the World
//
//  Created by 李睿鑫 on 2025/4/9.
//

#import <UIKit/UIKit.h>
#import "PersonalView.h"
#import "ChangeController.h"
#import "LoginSubModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PersonalController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic)PersonalView* personalView;
@property (strong, nonatomic)LoginSubModel* personalModel;
@property (nonatomic, strong) NSMutableArray<StarModel*> *leftData;
@property (nonatomic, strong) NSMutableArray<StarModel*> *rightData;
@end

NS_ASSUME_NONNULL_END
