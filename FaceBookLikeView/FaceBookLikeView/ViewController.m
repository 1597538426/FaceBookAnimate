//
//  ViewController.m
//  FaceBookLikeView
//
//  Created by 伟哥 on 2017/9/24.
//  Copyright © 2017年 vege. All rights reserved.
//

#import "ViewController.h"
#import "FaceBookLikeView.h"
#import <Masonry.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    FaceBookLikeView * view = [[FaceBookLikeView alloc]init];
//    view.backgroundColor = [UIColor redColor];
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.centerY.equalTo(self.view);
        make.width.mas_equalTo(350);//
        make.height.mas_equalTo(100);
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
