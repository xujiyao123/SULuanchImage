//
//  LaunchPicManager.h
//  ValleyWaterSource
//
//  Created by 软件技术中心 on 2017/12/1.
//  Copyright © 2017年 xujiyao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LaunchPicManager : UIViewController



+ (void)showLaunchImageWindow:(UIWindow *)window completeHuandel:(void(^)(LaunchPicManager * mang))block;


+ (BOOL)canShowLuanchImage;
@end
