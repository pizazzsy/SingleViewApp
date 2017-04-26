//
//  ViewController.m
//  SingleViewApp
//
//  Created by PFZC on 2017/4/25.
//  Copyright © 2017年 PFZC. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "AFNetworking.h"


@interface ViewController ()<UITextFieldDelegate>
{
    UILabel *Weather;
    UILabel *Temperature;
    UILabel *cityLab;
    UILabel *wind;
    UILabel *humidity;
    UILabel *pressure;
    UIImageView *weatherImg;
    UITextField *cityText;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor blackColor]];
    UIImageView *bgview=[[UIImageView alloc]init];
    [bgview setImage:[UIImage imageNamed:@"bg"]];
    [self.view addSubview:bgview];

    [bgview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(-10);
        make.right.bottom.mas_equalTo(10);
    }];
    
    cityLab=[[UILabel alloc]init];
    cityLab.text=@"城市";
    [self.view addSubview:cityLab];
    cityLab.textColor=[UIColor whiteColor];
    cityLab.textAlignment=NSTextAlignmentCenter;
    [cityLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.mas_equalTo(50);
        make.size.mas_equalTo(CGSizeMake(80, 30));
    }];
    
    Temperature=[[UILabel alloc]init];
    Temperature.text=@"28°";
    Temperature.textColor=[UIColor whiteColor];
    Temperature.font=[UIFont systemFontOfSize:60];
    Temperature.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:Temperature];
    [Temperature mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cityLab).offset(40);
        make.left.mas_equalTo(20);
        make.right.equalTo(self.view.mas_centerX).offset(-20);
        make.height.equalTo(Temperature.mas_width);
    }];
    
    weatherImg=[[UIImageView alloc]init];
    weatherImg.image=[UIImage imageNamed:@"1"];
    [self.view addSubview:weatherImg];
    
    [weatherImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cityLab).offset(40);
        make.right.mas_equalTo(-10);
        make.width.equalTo(Temperature);
        make.height.equalTo(Temperature);
    }];

    Weather=[[UILabel alloc]init];
    Weather.text=@"晴";
    Weather.textColor=[UIColor whiteColor];
    Weather.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:Weather];
    [Weather mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(Temperature.mas_bottom).offset(0);
        make.top.equalTo(Temperature.mas_top).offset(0);
        make.left.equalTo(Temperature.mas_right).offset(0);
        make.right.equalTo(weatherImg.mas_left).offset(0);
    }];
    
    wind=[[UILabel alloc]init];
    wind.text=@"东南风 一级";
    wind.textColor=[UIColor whiteColor];
    wind.textAlignment=NSTextAlignmentLeft;
    wind.font=[UIFont systemFontOfSize:14];
    [self.view addSubview:wind];
    [wind mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(Temperature.mas_bottom).offset(5);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(20);
    }];
    
    pressure=[[UILabel alloc]init];
    pressure.text=@"气压 1018";
    pressure.textColor=[UIColor whiteColor];
    pressure.textAlignment=NSTextAlignmentLeft;
     pressure.font=[UIFont systemFontOfSize:14];
    [self.view addSubview:pressure];
    [pressure mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wind.mas_bottom).offset(5);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(20);
    }];
    
    humidity=[[UILabel alloc]init];
    humidity.text=@"相对湿度 76";
    humidity.textColor=[UIColor whiteColor];
    humidity.textAlignment=NSTextAlignmentLeft;
    humidity.font=[UIFont systemFontOfSize:14];
    [self.view addSubview:humidity];
    [humidity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(pressure.mas_bottom).offset(5);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(20);
    }];
    
    double with=(self.view.frame.size.width-60)/3;
    
    cityText=[[UITextField alloc]init];
    cityText.placeholder=@"输入地点";
    cityText.borderStyle=UITextBorderStyleRoundedRect;
    cityText.layer.borderColor=[UIColor whiteColor].CGColor;
    cityText.delegate=self;
    [self.view addSubview:cityText];
    
    [cityText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(humidity.mas_bottom).offset(20);
        make.left.mas_equalTo(20);
        make.size.height.mas_equalTo(CGSizeMake(with, 30));
    }];
    
    
    UIButton *btn=[[UIButton alloc]init];
    [btn setTitle:@"查询" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor colorWithRed:((float) 182 / 255.0f)
                                            green:((float) 171 / 255.0f)
                                             blue:((float) 138 / 255.0f)
                                            alpha:1.0f]];
    [btn addTarget:self action:@selector(btnTouched:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(humidity.mas_bottom).offset(20);
        make.centerX.equalTo(self.view.mas_centerX).offset(0);
        make.size.mas_equalTo(CGSizeMake(with, 30));
    }];
    
    UIButton *local=[[UIButton alloc]init];
    [local setTitle:@"查询本地" forState:UIControlStateNormal];
    [local setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //    [local setBackgroundImage:[UIImage imageNamed:@"btnbg"] forState:UIControlStateNormal];
    [local setBackgroundColor:[UIColor colorWithRed:((float) 182 / 255.0f)
                                              green:((float) 171 / 255.0f)
                                               blue:((float) 138 / 255.0f)
                                              alpha:1.0f]];
    [local addTarget:self action:@selector(localTouched:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:local];
    
    [local mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(humidity.mas_bottom).offset(20);
        make.right.mas_equalTo(-20);
        make.size.mas_equalTo(CGSizeMake(with, 30));
    }];

    _KYNet=[NetWork getInstance];//得到单例
    _KYNet.delegate=self; //将KYNet的代理与ViewController连接
    
        // Do any additional setup after loading the view, typically from a nib.
}
-(void)getWeatherInfoSuccessFeedback:(id)feedbackInfo{
    //当服务器返回成功数据后，下列代码被激活
    NSLog(@"%@",[feedbackInfo class]);
    NSDictionary *dic=feedbackInfo;
    NSArray *weather1=[dic objectForKey:@"results"];
    
    NSLog(@"%@", weather1);
    NSString *temp=[NSString stringWithFormat:@"%@°",weather1[0][@"now"][@"temperature"]];
    NSString *weatherInfo=[NSString stringWithFormat:@"%@",weather1[0][@"now"][@"text"]];
    NSString *city=[NSString stringWithFormat:@"%@",weather1[0][@"location"][@"name"]];
    cityLab.text=city;
    Weather.text=weatherInfo;
    Temperature.text=temp;
    NSString*code=[NSString stringWithFormat:@"%@",weather1[0][@"now"][@"code"]];
    weatherImg.image=[UIImage imageNamed:code];
    
}

-(void)getWeatherInfoFailFeedback:(id)failInfo{
    NSLog(@"%@",failInfo);
}
//查询当前位置按钮
- (void)localTouched:(id)sender {
    self.locationManger=[[CLLocationManager alloc]init];
    self.locationManger.delegate=self;
    self.locationManger.desiredAccuracy=kCLLocationAccuracyBest;
    [self FindMe];
   
}
-(void)FindMe
{
    if ([self.locationManger respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        NSLog(@"允许app始终定位");
        [self.locationManger requestAlwaysAuthorization];
    }
    [self.locationManger startUpdatingLocation];
    NSLog(@"开始定位");
}
#pragma textfileddelagate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma locationDelegate
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    CLLocation *location=[locations lastObject];
    CLLocationCoordinate2D coordinate = location.coordinate;
    NSLog(@"纬度:%f 经度:%f", coordinate.latitude, coordinate.longitude);
    
    self.geocoder=[[CLGeocoder alloc]init];
    
    [self.geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (error||placemarks.count==0) {
             cityLab.text=@"你输入的地址没找到，可能在月球上";
        }else
        {
             CLPlacemark *firstPlacemark=[placemarks firstObject];
            NSString *citi=[NSString stringWithFormat:@"%@",firstPlacemark.locality];
            [_KYNet getWeatherInfoWithCity:citi];
        }
    }];

    [manager stopUpdatingLocation];
}



//上海按钮
- (void)btnTouched:(id)sender {
    
    
    [_KYNet getWeatherInfoWithCity:cityText.text];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
