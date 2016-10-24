# navDemo
项目内跳转第三方地图导航

使用前，先判断设备上是否已安装应用

[[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://"]]


只需要三个参数就可以完美调用第三方地图应用进行导航
[JGNavigationService navWithViewController:self WithEndLocation:coordinte andAddress:@"北京天安门"];


