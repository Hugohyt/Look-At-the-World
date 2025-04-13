//
//  BooksViewController.m
//  Look At the World
//
//  Created by 胡永泰 on 2025/3/4.
//

#import "BooksViewController.h"
#import "ManagerPost.h"
@interface BooksViewController ()
@property (nonatomic, strong) NSArray* arrTopImage;
@property (nonatomic, strong) NSArray* arrIndexPath1;
@property (nonatomic, strong) NSArray* arrIndexPath2;
@property (nonatomic, strong) NSArray* arrIndexPath3;
@property (nonatomic, strong) NSArray* arrScroll;
@property (nonatomic, strong) NSMutableArray* arrImage;
@property (nonatomic, strong) UIActivityIndicatorView * activityIndicator;
@property (nonatomic, strong) UIButton* avatarButton;
@end

@implementation BooksViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = YES;
    self.tabBarController.tabBar.hidden = NO;
    // 创建容器
    UIView *container = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 36, 36)];

    // 创建按钮
    self.avatarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.avatarButton.frame = CGRectMake(1, 1, 34, 34); // 四周留2pt边距
    self.avatarButton.layer.cornerRadius = 17;
    self.avatarButton.layer.masksToBounds = YES;
    self.avatarButton.imageView.contentMode = UIViewContentModeScaleAspectFill;

    // 设置图片
    UIImage *originalImage = [[ManagerPost sharedManager] getavatarImage];

    if (@available(iOS 15.0, *)) {
        UIButtonConfiguration *config = [UIButtonConfiguration plainButtonConfiguration];
        config.image = originalImage;
        self.avatarButton.configuration = config;
    } else {
        [self.avatarButton setImage:originalImage forState:UIControlStateNormal];
    }

    // 添加交互
    [self.avatarButton addTarget:self action:@selector(pushMine) forControlEvents:UIControlEventTouchUpInside];
    [container addSubview:self.avatarButton];

    // 添加到导航栏
    UIBarButtonItem *avatarItem = [[UIBarButtonItem alloc] initWithCustomView:container];
    self.navigationItem.rightBarButtonItem = avatarItem;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // 创建容器
    UIView *container = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 36, 36)];

    // 创建按钮
    UIButton *avatarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    avatarButton.frame = CGRectMake(1, 1, 34, 34); // 四周留2pt边距
    avatarButton.layer.cornerRadius = 17;
    avatarButton.layer.masksToBounds = YES;
    avatarButton.imageView.contentMode = UIViewContentModeScaleAspectFill;

    // 设置图片
    UIImage *originalImage = [[ManagerPost sharedManager] getavatarImage];

    if (@available(iOS 15.0, *)) {
        UIButtonConfiguration *config = [UIButtonConfiguration plainButtonConfiguration];
        config.image = originalImage;
        avatarButton.configuration = config;
    } else {
        [avatarButton setImage:originalImage forState:UIControlStateNormal];
    }

    // 添加交互
    [avatarButton addTarget:self action:@selector(pushMine) forControlEvents:UIControlEventTouchUpInside];
    [container addSubview:avatarButton];

    // 添加到导航栏
    UIBarButtonItem *avatarItem = [[UIBarButtonItem alloc] initWithCustomView:container];
    self.navigationItem.rightBarButtonItem = avatarItem;
    self.navigationItem.title = @"人间有道";
    self.navigationController.navigationBar.translucent = YES;
    self.arrIndexPath1 = [NSArray array];
    self.arrIndexPath2 = [NSArray array];
    self.arrIndexPath3 = [NSArray array];
    self.arrImage = [NSMutableArray array];
    self.arrScroll = [NSArray array];
    self.arrTopImage = [NSArray array];
    self.audiobooksView = [[AudioBookView alloc] initWithFrame:self.view.frame];
    self.activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyleMedium)];
    self.activityIndicator.frame= CGRectMake(self.view.frame.size.width/2 - 30, self.view.frame.size.height/2 - 30, 60, 60);
    //设置小菊花颜色
    self.activityIndicator.color = [UIColor grayColor];
    //设置背景颜色
    self.activityIndicator.backgroundColor = [UIColor whiteColor];
    //刚进入这个界面会显示控件，并且停止旋转也会显示，只是没有在转动而已，没有设置或者设置为YES的时候，刚进入页面不会显示
    [self.activityIndicator startAnimating];
    [self.view addSubview:self.activityIndicator];
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.audiobooksView.bounds;

    // 将 UIColor 对象转换为 CGColorRef 对象
    NSArray* cgColors = @[(id)[UIColor colorWithRed:0.95 green:0.9 blue:0.8 alpha:1.0].CGColor, (id)[UIColor whiteColor].CGColor];
    gradientLayer.colors = cgColors;

    NSArray* locations = @[@0.0, @0.6];
    gradientLayer.locations = locations;
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1);

    [self.audiobooksView.layer insertSublayer:gradientLayer atIndex:0];
//    self.arrTopImage = [NSMutableArray arrayWithObjects:[UIImage imageNamed:@"下载.jpeg"], [UIImage imageNamed:@"杂志1.jpeg"],  [UIImage imageNamed:@"杂志2.jpeg"], [UIImage imageNamed:@"杂志32.jpeg"], [UIImage imageNamed:@"杂志4.jpeg"], nil];
    
    
    id manager = [ManagerGet sharedManager];
    NSString* url = @"https://travel.knoci.cn/audiobooks/list";
    [manager GetRequestWithURL:url completion:^(id  _Nullable responseObject, NSError * _Nullable error) {
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
            self.detailModel = [AudioDetailModel yy_modelWithJSON:responseObject];
            NSLog(@"%lu", (unsigned long)self.detailModel.data.count);
            self.arrScroll = [self.detailModel.data subarrayWithRange:NSMakeRange(0, 5)];
            self.arrIndexPath1 = [self.detailModel.data subarrayWithRange:NSMakeRange(5, 5)];
            self.arrIndexPath2 = [self.detailModel.data subarrayWithRange:NSMakeRange(10, 5)];
            self.arrIndexPath3 = [self.detailModel.data subarrayWithRange:NSMakeRange(15, 5)];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self loadImages];
            });
        }
    }];
    
}
-(void) pushMine {
    PersonalController* personalController = [[PersonalController alloc] init];
    [self.navigationController pushViewController:personalController animated:YES];
}

- (void)loadImages {
    dispatch_group_t imageLoadGroup = dispatch_group_create();
    for (NSDictionary *dic in self.detailModel.data) {
        NSString* arr = dic[@"view"];
        NSURL *imageurl = [NSURL URLWithString:arr];
        if (!imageurl) {
            NSLog(@"无效的 URL: %@", arr);
            continue;
        }
        UIImageView *iview = [[UIImageView alloc] init];
        
        dispatch_group_enter(imageLoadGroup); // 进入组
        
        [iview sd_setImageWithURL:imageurl
                placeholderImage:[UIImage imageNamed:@"placeholder.png"]
                       completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            if (error) {
                NSLog(@"加载图片失败: %@", error.localizedDescription);
            } else {
                NSLog(@"图片加载成功");
            }
            dispatch_group_leave(imageLoadGroup); // 离开组
        }];
        
        [self->_arrImage addObject:iview];
    }

    // 在所有图片加载完成后设置主视图
    dispatch_group_notify(imageLoadGroup, dispatch_get_main_queue(), ^{
        self.arrTopImage = [self.arrImage subarrayWithRange:NSMakeRange(0, 5)];
        [self SettingTableView];
        self.audiobooksView.booksTableview.delegate = self;
        self.audiobooksView.booksTableview.dataSource = self;
        [self.view addSubview:self.audiobooksView];
        [self.activityIndicator stopAnimating];
    });
}

-(void) SettingTableView {
//    self.audiobooksView.booksTableview.userInteractionEnabled = NO;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        return 300;
    } else if(indexPath.section == 0) {
        return 120;
    } else {
        return 200;
    }
}
#pragma mark -设置cell中的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 1) {
        AudioScrollTableViewCell* cell = [self.audiobooksView.booksTableview dequeueReusableCellWithIdentifier:@"AudioScrollTableViewCell"];
        if(!cell) {
            cell = [[AudioScrollTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AudioScrollTableViewCell"];
        }
        for (int i = 0; i < 9; i++) {
            UIImageView *iView = [[UIImageView alloc] init]; // 创建新的UIImageView 实例
            // 根据 i 的值设置 UIImageView 的图像
            if (i == 1) {
                UIImageView* view = self->_arrTopImage[4];
                iView.image = view.image; // 使用数组中的图像
            } else if (i == 7) {
                UIImageView* view = self->_arrTopImage[0];
                iView.image = view.image;// 使用数组中的图像
            } else if (i == 8) {
                UIImageView* view = self->_arrTopImage[1];
                iView.image = view.image;
            } else if (i == 0){
                UIImageView* view = self->_arrTopImage[3];
                iView.image = view.image;
            } else {
                UIImageView* view = self->_arrTopImage[i - 2];
                iView.image = view.image; // 使用数组中的图像
            }
            iView.userInteractionEnabled = YES;
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTapped:)];
            tapGesture.cancelsTouchesInView = NO; // 允许其他触摸事件
            iView.tag = i; // 使用 tag 保存索引
            [iView addGestureRecognizer:tapGesture];
            // 设置 frame
            iView.frame = CGRectMake(220 * i, 25, 187.5, 250);
            iView.layer.masksToBounds = YES;
            iView.layer.cornerRadius = 15;
            [cell.arrTopImage addObject:iView];
            [cell.audioScrollView addSubview:iView];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else if (indexPath.section == 0) {
        IrregularButtonCell* buttonCell = [self.audiobooksView.booksTableview dequeueReusableCellWithIdentifier:@"IrregularButtonCell"];
        if(!buttonCell) {
            buttonCell = [[IrregularButtonCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"IrrgularButtonCell"];
        }
        [buttonCell.btn1 addTarget:self action:@selector(PressIrrgularBtn:) forControlEvents:UIControlEventTouchUpInside];
        [buttonCell.btn2 addTarget:self action:@selector(PressIrrgularBtn:) forControlEvents:UIControlEventTouchUpInside];
        [buttonCell.btn3 addTarget:self action:@selector(PressIrrgularBtn:) forControlEvents:UIControlEventTouchUpInside];
        return buttonCell;
    } else {
        AudioBookCell* booksCell = [self.audiobooksView.booksTableview dequeueReusableCellWithIdentifier:@"ButtonTableViewCell"];
        if(!booksCell) {
            booksCell = [[AudioBookCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ButtonTableViewCell"];
        }
        booksCell.titleLabel.text = @"走遍中国";
        switch (indexPath.section) {
            case 2:
                [self configureBookCell:booksCell
                           withTitle:@"走遍中国"
                             dataArray:self.arrIndexPath1
                            imageArray:self.arrImage
                          sectionIndex:indexPath.section
                            baseTag:100];
                break;
            case 3:
                [self configureBookCell:booksCell
                           withTitle:@"围炉品城"
                             dataArray:self.arrIndexPath2
                            imageArray:self.arrImage
                          sectionIndex:indexPath.section
                            baseTag:200];
                break;
            default:
                [self configureBookCell:booksCell
                           withTitle:@"生活美学"
                             dataArray:self.arrIndexPath3
                            imageArray:self.arrImage
                          sectionIndex:indexPath.section
                            baseTag:300];
                break;
        }

        booksCell.titleLabel.font = [UIFont fontWithName:@"fulu-luxi" size:18];
        
         return booksCell;
    }
}

- (void)configureBookCell:(AudioBookCell *)cell
               withTitle:(NSString *)title
               dataArray:(NSArray *)dataArray
              imageArray:(NSArray *)imageArray
            sectionIndex:(NSInteger)section
                baseTag:(NSInteger)baseTag {
    
    // 设置标题
    cell.titleLabel.text = title;
    
    // 获取随机元素
    NSDictionary *dict = randomlySelectThreeElementsWithIndices(dataArray);
    NSArray<NSNumber *> *arrIndex = dict[@"indices"];
    
    // 配置三个按钮
    NSArray<AudioBooksButton *> *buttons = @[cell.btn1, cell.btn2, cell.btn3];
    
    for (NSInteger i = 0; i < 3; i++) {
        if (i >= arrIndex.count) break;
        
        NSInteger index = [arrIndex[i] integerValue];
        NSInteger imageIndex = (section - 1) * 5 + index;
        NSDictionary *bookData = dataArray[index];
        // 设置按钮内容
        [buttons[i] setImage:imageArray[imageIndex]
                   mainTitle:bookData[@"name"]
                    subTitle:bookData[@"author"]];
        // 设置标签
        buttons[i].tag = baseTag + index + 1;
        // 添加点击事件
        [buttons[i] addTarget:self
                       action:@selector(PressCellBtn:)
             forControlEvents:UIControlEventTouchUpInside];
    }
}

-(void) imageTapped:(UITapGestureRecognizer*) gesture {
    NSInteger index = gesture.view.tag;
    switch (index) {
        case 0:
            index = 3;
            break;
        case 1:
            index = 4;
            break;;
        case 7:
            index = 0;
            break;
        case 8:
            index = 1;
            break;
        default:
            index -= 2;
            break;
    }
    AudioDetailsController* audioDetailsController = [[AudioDetailsController alloc] init];
    NSDictionary* dic = self.arrScroll[index];
    audioDetailsController.dataModel = [AudioListDataModel yy_modelWithDictionary:dic];
    [self.navigationController pushViewController:audioDetailsController animated:YES];
}
#pragma mark - 随机获取集合中的内容
NSDictionary *randomlySelectThreeElementsWithIndices(NSArray *originalArray) {
    NSUInteger arrayCount = [originalArray count];
    // 检查数组元素个数是否小于 3，若小于则返回原数组及其对应下标
    if (arrayCount < 3) {
        NSMutableArray *elements = [NSMutableArray arrayWithArray:originalArray];
        NSMutableArray *indices = [NSMutableArray array];
        for (NSUInteger i = 0; i < arrayCount; i++) {
            [indices addObject:@(i)];
        }
        return @{@"elements": elements, @"indices": indices};
    }
    
    NSMutableSet *randomIndicesSet = [NSMutableSet set];
    NSMutableArray *selectedElements = [NSMutableArray array];
    NSMutableArray *selectedIndices = [NSMutableArray array];
    
    // 生成 3 个不重复的随机索引
    while ([randomIndicesSet count] < 3) {
        NSUInteger randomIndex = arc4random_uniform((u_int32_t)arrayCount);
        [randomIndicesSet addObject:@(randomIndex)];
    }
    // 根据随机索引从数组中取出元素及其下标
    for (NSNumber *indexNumber in randomIndicesSet) {
        NSUInteger index = [indexNumber unsignedIntegerValue];
        id element = originalArray[index];
        [selectedElements addObject:element];
        [selectedIndices addObject:@(index)];
    }
    
    return @{@"elements": selectedElements, @"indices": selectedIndices};
}
#pragma mark -pressFirstCell
-(void) PressIrrgularBtn:(UIButton*) btn {
    AudioBooksListController* listController = [[AudioBooksListController alloc] init];
    listController.booksDetailArr = [NSArray array];
    switch (btn.tag) {
        case 101:
            listController.booksDetailArr = self.arrIndexPath1;
            listController.navigationItem.title = @"走遍中国";
            break;
        case 102:
            listController.booksDetailArr = self.arrIndexPath2;
            listController.navigationItem.title = @"围炉品城";
            break;
        default:
            listController.booksDetailArr = self.arrIndexPath3;
            listController.navigationItem.title = @"生活美学";
            break;
    }
    [self.navigationController pushViewController:listController animated:YES];
}

-(void) PressCellBtn:(UIButton*) btn {
    NSLog(@"%ld", btn.tag);
    AudioDetailsController* audioDetailsController = [[AudioDetailsController alloc] init];
    if (btn.tag < 200) {
        NSDictionary* dic = self.arrIndexPath1[btn.tag - 101];
        audioDetailsController.dataModel = [AudioListDataModel yy_modelWithDictionary:dic];
    } else if (200 < btn.tag && btn.tag < 300) {
        NSDictionary* dic = self.arrIndexPath2[btn.tag - 201];
        audioDetailsController.dataModel = [AudioListDataModel yy_modelWithDictionary:dic];
    } else {
        NSDictionary* dic = self.arrIndexPath3[btn.tag - 301];
        audioDetailsController.dataModel = [AudioListDataModel yy_modelWithDictionary:dic];
    }
    [self.navigationController pushViewController:audioDetailsController animated:YES];
}

@end
