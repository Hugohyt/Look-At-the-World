//
//  ManagerPost.h
//  Look At the World
//
//  Created by 李睿鑫 on 2025/3/27.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import <YYModel/YYModel.h>
#import "NoticeModel.h"
#import "LoginModel.h"
//111
typedef void (^NetworkCompletionHandler)(id  _Nullable responseObject, NSError * _Nullable error);
NS_ASSUME_NONNULL_BEGIN

@interface ManagerPost : NSObject

+ (instancetype)sharedManager;

- (void)sendPostRequestWithURL:(NSString *)urlString parameters:(NSDictionary *)parameters completion:(NetworkCompletionHandler)completion;
- (void)uploadImageToServer:(NSString *)url
                     image:(UIImage *)image
                parameters:(NSDictionary *)parameters
                 completion:(NetworkCompletionHandler)completion;
@property (nonatomic, strong) LoginSubModel* personalModel;
- (LoginSubModel*) getModel;
@property (nonatomic, strong) UIImageView* avatarImage;
-(void) getAvatarImage;
-(UIImage*) getavatarImage;
-(void) changeAvatarImage:(UIImage*) image;
@end

NS_ASSUME_NONNULL_END
