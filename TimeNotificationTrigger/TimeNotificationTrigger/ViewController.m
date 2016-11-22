//
//  ViewController.m
//  TimeNotificationTrigger
//
//  Created by youngstar on 16/10/9.
//  Copyright © 2016年 Young. All rights reserved.
//

#import "ViewController.h"
#import <UserNotifications/UserNotifications.h>
#import "AppDelegate.h"
#import <CoreLocation/CoreLocation.h>
#import "NotificationAction.h"

@interface ViewController ()<UNUserNotificationCenterDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self createLocalizedUserNotification];
    
//    [AppDelegate registerNotification:10];
    
}

// 本地推送
- (void)createLocalizedUserNotification{
    
    // 触发条件 一段时间后触发 是否可重复，如果是可重复则时间必须 >= 60秒
    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:15 repeats:NO];
    
    
    // 触发条件 定时提醒 是否可重复
//        NSDateComponents *component = [[NSDateComponents alloc]init];
//        component.hour = 17;
//        component.minute = 11;
//        component.day = 10;
//        component.month = 10;
//        component.year = 2016;
//        UNCalendarNotificationTrigger *trigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:component repeats:YES];

    
    // 触发条件 地域触发提醒  圆形区域，进入时候进行通知
//    CLLocationCoordinate2D localCenter = CLLocationCoordinate2DMake(116.487777,40.002843);
//    CLCircularRegion* region = [[CLCircularRegion alloc] initWithCenter:localCenter
//                                                            radius:2000.0 identifier:@"Headquarters"];
//    region.notifyOnEntry = YES;
//    region.notifyOnExit = NO;
//    UNLocationNotificationTrigger* trigger = [UNLocationNotificationTrigger
//                                              triggerWithRegion:region repeats:NO];
    
    
    // 通知内容
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc]init];
    content.title = @"智商不足提醒";
    content.subtitle = @"这是个地域推送通知";
    content.body = @"您好，智商不足请及时充值，如果您已充值，请自动忽略该提醒！！！";
    content.badge = @1;
    content.sound = [UNNotificationSound defaultSound];
    content.userInfo = @{@"key1":@"Value1", @"key2":@"Value2"};
    
    // 这两行是做Action处理的 3D touch的回复等显示
    content.categoryIdentifier = @"Dely_locationCategory";
    [NotificationAction addNotificationAction];
    
    
    // 创建通知提示
    NSString *requestID = @"Dely.X.time";
    
    // 创建通知请求 UNNotificationRequest 将触发条件和通知内容添加到请求中
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:requestID content:content trigger:trigger];
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    center.delegate = self;
    
    // 将通知请求添加到通知中心
    [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        if (!error) {
            NSLog(@"推送已添加成功 %@", requestID);
            //你自己的需求例如下面：
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"本地通知" message:@"成功添加推送" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            [alert addAction:cancelAction];
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
            //此处省略一万行需求。。。。
        }
    }];
 
}

// 点击通知的方法
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)())completionHandler __IOS_AVAILABLE(10.0) __WATCHOS_AVAILABLE(3.0) __TVOS_PROHIBITED
{
     // 处理推送的Action效果  即处理回复等按钮
     //点击或输入action
     NSString* actionIdentifierStr = response.actionIdentifier;
     //输入
     if ([response isKindOfClass:[UNTextInputNotificationResponse class]]) {
     
     NSString* userSayStr = [(UNTextInputNotificationResponse *)response userText];
     NSLog(@"actionid = %@\n  userSayStr = %@",actionIdentifierStr, userSayStr);
     //此处省略一万行需求代码。。。。
     }
     
     //点击
     if ([actionIdentifierStr isEqualToString:@"action.join"]) {
     
     //此处省略一万行需求代码
     NSLog(@"actionid = %@\n",actionIdentifierStr);
     }else if ([actionIdentifierStr isEqualToString:@"action.look"]){
     
     //此处省略一万行需求代码
     NSLog(@"actionid = %@\n",actionIdentifierStr);
     
     //下面代码就不放进来了，具体看Demo
     }
    
    //2016-09-27 14:42:16.353978 UserNotificationsDemo[1765:800117] Warning: UNUserNotificationCenter delegate received call to -userNotificationCenter:didReceiveNotificationResponse:withCompletionHandler: but the completion handler was never called.
    completionHandler(); // 系统要求执行这个方法
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
