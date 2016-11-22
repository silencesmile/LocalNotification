//
//  AppDelegate.h
//  TimeNotificationTrigger
//
//  Created by youngstar on 16/10/9.
//  Copyright © 2016年 Young. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

+(void)registerNotification:(NSInteger )alerTime;

@end

