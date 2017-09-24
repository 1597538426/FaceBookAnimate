//
//  AppDelegate.h
//  FaceBookLikeView
//
//  Created by 伟哥 on 2017/9/24.
//  Copyright © 2017年 vege. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

