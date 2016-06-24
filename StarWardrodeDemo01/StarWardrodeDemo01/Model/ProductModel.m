//
//  ProductModel.m
//  StarWardrodeDemo01
//
//  Created by Mac on 16/6/18.
//  Copyright © 2016年 LvShuai. All rights reserved.
//

#import "ProductModel.h"

@implementation ProductModel

-(instancetype)initWithShopDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        self.picUrl = dic[@"component"][@"picUrl"];
    }
    
    return self;
    
}
+(instancetype)createShopModelWithShopDic:(NSDictionary *)dic{
    
    return [[self alloc]initWithShopDic:dic];
    
    
    
}










@end
