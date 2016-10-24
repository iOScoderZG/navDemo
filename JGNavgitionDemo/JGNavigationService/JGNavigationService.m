//
//  JGNavigationService.m
//  JGNavgitionDemo
//
//  Created by coderZG on 16/10/21.
//  Copyright © 2016年 coderZG. All rights reserved.
//

#import "JGNavigationService.h"
#import "AppDelegate.h"
#import "JZLocationConverter.h"
#import <MapKit/MapKit.h>

static NSString *applicationName = @"JGNavgitionDemo";
static NSString *applicationScheme = @"JGNavgitionDemo";
@implementation JGNavigationService


+(void)navWithViewController:(UIViewController *)viewController WithEndLocation:(CLLocationCoordinate2D)endLocation andAddress:(NSString *)address{
    NSArray *maps = [self getInstalledMapAppWithEndLocation:endLocation withAddress:address];
    UIAlertController *sheet = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"导航到%@",address] message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    for (int i = 0 ;i<maps.count;i++) {
        NSDictionary *dict = maps[i];
        NSString *title = dict[@"title"];
        if (i==0) {
            UIAlertAction *action = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self navAppleMapWith:endLocation];
            }];
            [sheet addAction:action];
        }else{
        NSString *urlString= dict[@"url"];
        UIAlertAction *action = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
        }];
        [sheet addAction:action];

    }
    }
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [sheet addAction:cancel];
    
    [viewController  presentViewController:sheet animated:YES completion:nil];
}


#pragma mark - 导航方法
+ (NSArray *)getInstalledMapAppWithEndLocation:(CLLocationCoordinate2D)endLocation withAddress:(NSString *)address
{
    NSMutableArray *maps = [NSMutableArray array];
    
    //苹果地图
    NSMutableDictionary *iosMapDic = [NSMutableDictionary dictionary];
    iosMapDic[@"title"] = @"苹果地图";
    [maps addObject:iosMapDic];
    
    //百度地图
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://"]]) {
        NSMutableDictionary *baiduMapDic = [NSMutableDictionary dictionary];
        baiduMapDic[@"title"] = @"百度地图";
        NSString *urlString = [[NSString stringWithFormat:@"baidumap://map/direction?origin={{我的位置}}&destination=latlng:%f,%f|name=北京&mode=driving&coord_type=gcj02",endLocation.latitude,endLocation.longitude] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        baiduMapDic[@"url"] = urlString;
        [maps addObject:baiduMapDic];
    }
    
    //高德地图
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"iosamap://"]]) {
        NSMutableDictionary *gaodeMapDic = [NSMutableDictionary dictionary];
        gaodeMapDic[@"title"] = @"高德地图";
        
        
        NSString *urlString = [[NSString stringWithFormat:@"iosamap://navi?sourceApplication=%@&backScheme=%@&poiname=%@&poiid=BGVIS&lat=%f&lon=%f&dev=1&style=2",applicationName,applicationScheme,address,endLocation.latitude,endLocation.longitude] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        gaodeMapDic[@"url"] = urlString;
        [maps addObject:gaodeMapDic];
    }
    
    //谷歌地图
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"comgooglemaps://"]]) {
        NSMutableDictionary *googleMapDic = [NSMutableDictionary dictionary];
        googleMapDic[@"title"] = @"谷歌地图";
        NSString *urlString = [[NSString stringWithFormat:@"comgooglemaps://?x-source=%@&x-success=%@&saddr=&daddr=%f,%f&directionsmode=driving",@"导航测试",@"nav123456",endLocation.latitude, endLocation.longitude] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        googleMapDic[@"url"] = urlString;
        [maps addObject:googleMapDic];
    }
    
    //腾讯地图
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"qqmap://"]]) {
        NSMutableDictionary *qqMapDic = [NSMutableDictionary dictionary];
        qqMapDic[@"title"] = @"腾讯地图";
        NSString *urlString = [[NSString stringWithFormat:@"qqmap://map/routeplan?from=我的位置&type=drive&tocoord=%f,%f&to=终点&coord_type=1&policy=0",endLocation.latitude, endLocation.longitude] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        qqMapDic[@"url"] = urlString;
        [maps addObject:qqMapDic];
    }
    
    return maps;
}


//#pragma mark LCActionSheetDelegate
//-(void)actionSheet:(LCActionSheet *)actionSheet didClickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    if (buttonIndex != -1) {
//        if (buttonIndex == 0) {
//            [self navAppleMap];
//            return;
//        }
//        NSDictionary *dic = self.maps[buttonIndex];
//        NSString *urlString = dic[@"url"];
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
//    }
//}

//苹果地图
+ (void)navAppleMapWith:(CLLocationCoordinate2D)destinationCoordinate2D
{
    CLLocationCoordinate2D gps = [JZLocationConverter bd09ToWgs84:destinationCoordinate2D];
    
    MKMapItem *currentLoc = [MKMapItem mapItemForCurrentLocation];
    MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:gps addressDictionary:nil]];
    NSArray *items = @[currentLoc,toLocation];
    NSDictionary *dic = @{
                          MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving,
                          MKLaunchOptionsMapTypeKey : @(MKMapTypeStandard),
                          MKLaunchOptionsShowsTrafficKey : @(YES)
                          };
    
    [MKMapItem openMapsWithItems:items launchOptions:dic];
}
@end
