//
//  ViewController.h
//  SingleViewApp
//
//  Created by PFZC on 2017/4/25.
//  Copyright © 2017年 PFZC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetWork.h"
#import <CoreLocation/CoreLocation.h>
@interface ViewController : UIViewController<NetDelegate,CLLocationManagerDelegate>
@property NetWork *KYNet;
@property(nonatomic,strong)CLGeocoder*geocoder;
@property(nonatomic,strong)CLLocationManager*locationManger;
@end

