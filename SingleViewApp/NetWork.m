//
//  NetWork.m
//  SingleViewApp
//
//  Created by PFZC on 2017/4/25.
//  Copyright © 2017年 PFZC. All rights reserved.
//

#import "NetWork.h"



 __strong static AFHTTPRequestOperationManager *AFHTTPMgr;
 __strong static NetWork *NetInstance=nil;

@implementation NetWork

+(NetWork *)getInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        NetInstance= [[NetWork alloc]init];//初始化实例
        
        //一下是AFHTTPOerrationManager的配置
        AFHTTPMgr=[AFHTTPRequestOperationManager manager];
        //申明返回的结果是json类型
        AFHTTPMgr.responseSerializer=[AFJSONResponseSerializer serializer];
        //申明请求的数据是json类型
        AFHTTPMgr.requestSerializer=[AFJSONRequestSerializer serializer];
        //如果报接受类型不一致请替换一致text/xml或别的
        //AFHTTPMgr.responseSerializer.acceptableContentTypes= [NSSet setWithObject:@"text/xml"];
        //设置超时时间
        AFHTTPMgr.requestSerializer.timeoutInterval=5;
    });
    return NetInstance;
}
-(void)getWeatherInfoWithCity:(NSString *)cityName{
    //接口地址
    NSString *url=[NSString stringWithFormat:@"https://api.seniverse.com/v3/weather/now.json?key=6ims6h7nppcgyrec&language=zh-Hans&unit=c"];
    //参数
    NSDictionary *parameters=[[NSDictionary alloc]initWithObjectsAndKeys:cityName,@"location", nil];
    //发请求
    [AFHTTPMgr GET:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //请求成功Block
        [self.delegate getWeatherInfoSuccessFeedback:responseObject];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.delegate getWeatherInfoFailFeedback:error];
        //请求失败Blick
    }];
}

@end
