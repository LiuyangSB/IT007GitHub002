//
//  DatabaseTool.m
//  StarWardrodeDemo01
//
//  Created by Mac on 16/6/17.
//  Copyright © 2016年 LvShuai. All rights reserved.
//

#import "DatabaseTool.h"
#import "AFNetworking.h"
#import "shopModel.h"
#import "ProductModel.h"

@implementation DatabaseTool


+(void)getProductUrlInfo:(void (^)(NSMutableArray *))completeBlock{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"application/json", nil];
    
    [manager GET:@"http://api2.hichao.com/banner?ga=%2Fbanner&gv=55&gi=864737011278738&access_token=&gos=5.1.5&p=Lenovo+K860&gc=qihu360&gn=mxycadr&gf=ios&gs=720x1200" parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        //NSLog(@"%@",[NSJSONSerialization JSONObjectWithData:responseObject options:NSUTF8StringEncoding error:nil]) ;
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSUTF8StringEncoding error:nil];
        //NSLog(@"%@",dic);
        NSDictionary *dataDic = dic[@"data"];
       // NSLog(@"===%@",dataDic);
        NSArray *arr = dataDic[@"items"];
       // NSLog(@"---%@",arr);
       
        NSMutableArray *array = [NSMutableArray array];
        
        for (NSDictionary *comdic in arr) {
            shopModel *obj = [shopModel createShopModelWithShopDic:comdic];
            [array addObject:obj];
            
            
        }
        if (completeBlock) {
            completeBlock(array);
        }
        
        } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
    NSLog(@"%@",error.localizedDescription);
            if (completeBlock) {
                completeBlock(nil);
            }
        }];
    
}

+(void)getShopingUrlInfo:(void (^)(NSMutableArray *shArrry))completeBlock{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"application/json", nil];
 
    [manager GET:@"http://api2.hichao.com/stars?category=%E5%85%A8%E9%83%A8&pin=79323&ga=%2Fstars&flag=&gv=55&gi=864737011278738&access_token=&gos=5.1.5&p=Lenovo+K860&gn=mxyc_adr&gc=qihu360&gs=720x1200&gf=ios&lts=1407641954" parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
       // NSLog(@"%@",[NSJSONSerialization JSONObjectWithData:responseObject options:NSUTF8StringEncoding error:nil]);
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSUTF8StringEncoding error:nil];
        //NSLog(@"%@",dic);
        NSDictionary *dataDic = dic[@"data"];
        // NSLog(@"===%@",dataDic);
        NSArray *arr = dataDic[@"items"];
         NSLog(@"---%@",arr);
        
        NSMutableArray *array = [NSMutableArray array];
        
        for (NSDictionary *comdic in arr) {
            ProductModel *obj = [ProductModel createShopModelWithShopDic:comdic];
            [array addObject:obj];
            
            
        }
        if (completeBlock) {
            completeBlock(array);
        }
     } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        NSLog(@"%@",error.localizedDescription);
         if (completeBlock) {
             completeBlock(nil);
         }
         
         
         
    }];
    
    
    
    
    
}




@end
