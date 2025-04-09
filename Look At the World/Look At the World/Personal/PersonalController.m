//
//  PersonalController.m
//  Look At the World
//
//  Created by 李睿鑫 on 2025/4/9.
//

#import "PersonalController.h"

@interface PersonalController ()

@end

@implementation PersonalController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.personalView = [[PersonalView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:self.personalView];
    [self.personalView.avatarImageBtn addTarget:self action:@selector(PressImageBtn) forControlEvents:UIControlEventTouchUpInside];
}

-(void) PressImageBtn {
    UIImagePickerController* imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    // 例如显示在 ImageView 上
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    [self.personalView.avatarImageBtn setImage:image forState:UIControlStateNormal];
    id manager = [ManagerPost sharedManager];
    NSString* url = @"https://travel.knoci.cn/user/userdue/postavatar";
    NSDictionary* heads = @{@"Authorization":@"Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOiI4YTNlODViNi05YWQ2LTQ5YTAtYWRhMy1mNDI2MjA1ZjlhMTgiLCJuYW1lIjoiTE8iLCJlbWFpbCI6Imh0dHBzOi8vYXZhdGFycy5naXRodWJ1c2VyY29udGVudC5jb20vdS8xMjkwNzgxOTQiLCJhdmF0YXIiOiIzMjYxMDc4OTQwQHFxLmNvbSIsImV4cCI6MTc0NDY1MTY1MCwibmJmIjoxNzQ0MjE5NjUwLCJpYXQiOjE3NDQyMTk2NTB9.qCI3H-zRBrcjRaFv1-WraF8W1TNyuAC0CJGDCETVVJU", @"Content-Type":@"image/jpg"};
    [manager uploadImageToServer:url image:image parameters:heads completion:^(id  _Nullable responseObject, NSError * _Nullable error) {
        if(error) {
            if ([error.domain isEqualToString:AFURLResponseSerializationErrorDomain]) {
                    // server error
                NSData *responseData = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
                NoticeModel *errorModel = [NoticeModel yy_modelWithJSON:responseData];
                if (errorModel) {
                    
                    NSLog(@"服务器返回错误码: %ld，错误信息: %@", (long)errorModel.code, errorModel.msg);
                }
            } else if ([error.domain isEqualToString:NSCocoaErrorDomain]) {
                // server throw exception
                NSLog(@"服务器抛出异常，请稍后重试");
            } else if ([error.domain isEqualToString:NSURLErrorDomain]) {
                // network error
                NSLog(@"网络连接错误，请检查网络设置");
            } else {
                // 其他未知错误
                NSLog(@"发生未知错误: %@", error.localizedDescription);
            }
        } else {
            NSLog(@"上传成功");
        }
    }];
    // 关闭 UIImagePickerController
    [picker dismissViewControllerAnimated:YES completion:nil];
}
@end
