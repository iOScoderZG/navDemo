//
//  JGNavigationService.h
//  JGNavgitionDemo
//
//  Created by coderZG on 16/10/21.
//  Copyright © 2016年 coderZG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface JGNavigationService : NSObject

/**
 打开第三方地图导航
 */
+(void)navWithViewController:(UIViewController *)viewController WithEndLocation:(CLLocationCoordinate2D)endLocation andAddress:(NSString *)address;
@end
