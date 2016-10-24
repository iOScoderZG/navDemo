//
//  ViewController.m
//  JGNavgitionDemo
//
//  Created by coderZG on 16/10/21.
//  Copyright © 2016年 coderZG. All rights reserved.
//

#import "ViewController.h"
#import "JGNavigationService.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    CLLocationCoordinate2D coordinte = CLLocationCoordinate2DMake((CLLocationDegrees)23.322595, (CLLocationDegrees)114.233879);
    [JGNavigationService navWithViewController:self WithEndLocation:coordinte andAddress:@"北京天安门"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
