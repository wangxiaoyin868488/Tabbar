//
//  AppDelegate.m
//  Tabbar
//
//  Created by apple on 16/5/9.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "AppDelegate.h"
#import "MainTabbarController.h"
#import "AdvertiseView.h"

#import "VideoPlayerController.h"
#define ApplicationDelegate   ((AppDelegate *)[[UIApplication sharedApplication] delegate])


@interface AppDelegate ()

//@property (strong , nonatomic) AdvertiseView *advertiseView;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    _rootViewController = [[MainTabbarController alloc]init];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:_rootViewController];
    
    navi.navigationBar.hidden = YES;
    
    self.window.rootViewController = navi;
    [self.window makeKeyAndVisible];
    
    
    
    
    // 1.判断沙盒中是否存在广告图片，如果存在，直接显示
    NSString *filePath = [self getFilePathWithImageName:[kUserDefaults valueForKey:adImageName]];
    NSLog(@"%@",[kUserDefaults valueForKey:adImageName]);
    
    BOOL isExist = [self isFileExistWithFilePath:filePath];
    
    if (isExist) {//图片存在
        
        AdvertiseView * advertiseView = [[AdvertiseView alloc]initWithFrame:self.window.bounds];
//        advertiseView.backgroundColor = [UIColor redColor];
        advertiseView.firePath = filePath;
        [advertiseView show];
    }
    
    // 2.无论沙盒中是否有广告图片，都要重新调用广告接口，判断广告是否更新
    
    [self getAdvertisingImage];
    

    return YES;
}
//判断文件是否存在

- (BOOL)isFileExistWithFilePath:(NSString *)firePath{
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDirectory = FALSE;
    return [fileManager fileExistsAtPath:firePath isDirectory:&isDirectory];
    
}


//// 哪些页面支持自动转屏
//- (BOOL)shouldAutorotate{
//    
//    //    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:self];
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:_rootViewController];
//    
//    // MoviePlayerViewController这个页面支持自动转屏
//    if ([nav.topViewController isKindOfClass:[VideoPlayerController class]]) {
//        return !ApplicationDelegate.isLockScreen;  // 调用AppDelegate单例记录播放状态是否锁屏
//    }
//    return NO;
//}
//
//// viewcontroller支持哪些转屏方向
//- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
//    
//    //    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:self];
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:_rootViewController];
//    
//    if ([nav.topViewController isKindOfClass:[VideoPlayerController class]]) { // VideoPlayerController这个页面支持转屏方向
//        return UIInterfaceOrientationMaskAllButUpsideDown;
//    }else { // 其他页面支持转屏方向
//        return UIInterfaceOrientationMaskPortrait;
//    }
//    return UIInterfaceOrientationMaskPortrait;
//}



//初始化广告页面
- (void)getAdvertisingImage{

    //在这里请求广告接口
    
    //这里用现成的
    NSArray *imageArray = @[@"http://imgsrc.baidu.com/forum/pic/item/9213b07eca80653846dc8fab97dda144ad348257.jpg", @"http://pic.paopaoche.net/up/2012-2/20122220201612322865.png", @"http://img5.pcpop.com/ArticleImages/picshow/0x0/20110801/2011080114495843125.jpg", @"http://www.mangowed.com/uploads/allimg/130410/1-130410215449417.jpg"];
    NSString *imageUrl = imageArray[arc4random() % imageArray.count];
    
    // 获取图片名:43-130P5122Z60-50.jpg
    NSArray *stringArr = [imageUrl componentsSeparatedByString:@"/"];
    NSString *imageName = stringArr.lastObject;
    
    // 拼接沙盒路径
    NSString *filePath = [self getFilePathWithImageName:imageName];
    BOOL isExist = [self isFileExistWithFilePath:filePath];
    if (!isExist){// 如果该图片不存在，则删除老图片，下载新图片
        
        [self downloadAdImageWithUrl:imageUrl imageName:imageName];
        
    }
}

//下载新图片
- (void)downloadAdImageWithUrl:(NSString *)imageUrl imageName:(NSString *)imageName{

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
        UIImage *image = [UIImage imageWithData:data];
        
        NSString *filePath = [self getFilePathWithImageName:imageName]; // 保存文件的名称
        
        if ([UIImagePNGRepresentation(image) writeToFile:filePath atomically:YES]) {// 保存成功
            NSLog(@"保存成功");
            [self deleteOldImage];
            [kUserDefaults setValue:imageName forKey:adImageName];
            [kUserDefaults synchronize];
            // 如果有广告链接，将广告链接也保存下来
        }else{
            NSLog(@"保存失败");
        }
        
    });

}

//删除旧图片
- (void)deleteOldImage{

    NSString *imageName = [kUserDefaults valueForKey:adImageName];
    
    if (imageName) {
        NSString *filePath = [self getFilePathWithImageName:imageName];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        [fileManager removeItemAtPath:filePath error:nil];
    }
    
}

// 根据图片名拼接文件路径

- (NSString *)getFilePathWithImageName:(NSString *)imageName{
    
    
    if (imageName) {
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES);
        NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:imageName];
        
        return filePath;
    }
    
    return nil;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}








@end
