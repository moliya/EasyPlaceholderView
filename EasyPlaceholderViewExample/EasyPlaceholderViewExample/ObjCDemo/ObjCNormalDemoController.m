//
//  ObjCNormalDemoController.m
//  EasyPlaceholderViewExample
//
//  Created by carefree on 2022/6/26.
//

#import "ObjCNormalDemoController.h"
#import "UIColor+Extension.h"
#import <EasyPlaceholderView-Swift.h>
#import <Masonry/Masonry.h>

@interface ObjCNormalDemoController ()

@end

@implementation ObjCNormalDemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(changeState)];
    
    // 添加空白页
    [self.view.easy_placeholder setViewBy:^UIView * _Nullable(KFEasyPlaceholder * _Nonnull p) {
        UIView *contentView = [[UIView alloc] init];
        contentView.backgroundColor = [UIColor colorWithHex:0xf8f8f8];
        
        UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"img_empty_normal"]];
        imgView.contentMode = UIViewContentModeScaleAspectFit;
        [contentView addSubview:imgView];
        [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(contentView);
            make.centerY.equalTo(contentView).offset(-20);
            make.width.equalTo(@(120));
        }];
        
        UILabel *msgLabel = [[UILabel alloc] init];
        msgLabel.font = [UIFont systemFontOfSize:12];
        msgLabel.numberOfLines = 0;
        msgLabel.textAlignment = NSTextAlignmentCenter;
        msgLabel.textColor = [UIColor colorWithHex:0x808080];
        msgLabel.text = @"这里空空如也~\nThere's nothing here~";
        [contentView addSubview:msgLabel];
        [msgLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(imgView.mas_bottom).offset(-70);
            make.centerX.equalTo(contentView);
        }];
        
        return contentView;
    } forState:KFEasyPlaceholderStateEmpty];
    
    // 添加失败状态的自定义配置
    __weak typeof(self) weakSelf = self;
    [self.view.easy_placeholder setCustomizeBy:^(UIView * _Nonnull view) {
        for (UIView *subview in view.subviews) {
            if ([subview isKindOfClass:UIButton.class]) {
                UIButton *button = (UIButton *)subview;
                // 给按钮添加点击事件
                [button addTarget:weakSelf action:@selector(retryAction) forControlEvents:UIControlEventTouchUpInside];
            }
        }
    } forState:KFEasyPlaceholderStateFailed];
    
    // 最终展示的内容
    UIImageView *iconView = [[UIImageView alloc] init];
    iconView.image = [UIImage imageNamed:@"img_watermelon"];
    [self.view addSubview:iconView];
    [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(60);
        make.width.height.equalTo(@(160));
    }];
    UITextView *textView = [[UITextView alloc] init];
    textView.font = [UIFont systemFontOfSize:18 weight:UIFontWeightMedium];
    textView.editable = NO;
    textView.text = @"Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.";
    [self.view addSubview:textView];
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(iconView.mas_bottom);
        make.leading.trailing.bottom.equalTo(self.view);
    }];
    
    // 开始Loading
    [self.view.easy_placeholder showLoading];
}

- (void)retryAction {
    [self.view.easy_placeholder showLoading];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.view.easy_placeholder showEmpty];
    });
}

- (void)changeState {
    UIAlertController *sheet = [UIAlertController alertControllerWithTitle:@"变更状态(Change State)" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [sheet addAction:[UIAlertAction actionWithTitle:@"加载中(Loading)" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.view.easy_placeholder showLoading];
    }]];
    [sheet addAction:[UIAlertAction actionWithTitle:@"空白(Empty)" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.view.easy_placeholder showEmpty];
    }]];
    [sheet addAction:[UIAlertAction actionWithTitle:@"失败(Failed)" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.view.easy_placeholder showFailed];
    }]];
    [sheet addAction:[UIAlertAction actionWithTitle:@"完成(Finished)" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.view.easy_placeholder showFinished];
    }]];
    [sheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:sheet animated:YES completion:nil];
}

@end
