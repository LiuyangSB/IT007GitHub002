//
//  DatabaseTool.h
//  StarWardrodeDemo01
//
//  Created by Mac on 16/6/17.
//  Copyright © 2016年 LvShuai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface DatabaseTool : NSObject

//发送请求
+(void)getProductUrlInfo:(void(^)(NSMutableArray *array))completeBlock;

+(void)getShopingUrlInfo:(void (^)(NSMutableArray *shArrry))completeBlock;


@end
