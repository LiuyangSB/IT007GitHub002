//
//  shopModel.h
//  StarWardrodeDemo01
//
//  Created by Mac on 16/6/17.
//  Copyright © 2016年 LvShuai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface shopModel : NSObject

@property(nonatomic,copy)NSString *picUrl;

-(instancetype)initWithShopDic:(NSDictionary *)dic;
+(instancetype)createShopModelWithShopDic:(NSDictionary *)dic;



@end
