//
//  NetWork.h
//  SingleViewApp
//
//  Created by PFZC on 2017/4/25.
//  Copyright © 2017年 PFZC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@protocol NetDelegate <NSObject>
/**
 *  代理回调方法
 *
 *  @param feedbackInfo 服务器返回的数据
 */
-(void)getWeatherInfoSuccessFeedback:(id)feedbackInfo;
-(void)getWeatherInfoFailFeedback:(id)failInfo;

@end

@interface NetWork : NSObject

@property (nonatomic,strong) id<NetDelegate> delegate;
-(void)getWeatherInfoWithCity:(NSString *)cityName;
+(NetWork *)getInstance;
@end
