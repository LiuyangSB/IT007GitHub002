//
//  ViewController.m
//  StarWardrodeDemo01
//
//  Created by Mac on 16/6/17.
//  Copyright © 2016年 LvShuai. All rights reserved.
//

#import "ViewController.h"
#import "MainViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    [self.view addSubview:scrollView];
    for (int i=0; i<4; i++) {
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(scrollView.frame.size.width*i, 0, scrollView.frame.size.width, scrollView.frame.size.height)];
        if (i == 0) {
            imageView.image = [UIImage imageNamed:@"splash_img1"];
           
            
            
        }else if (i==1){
            imageView.image = [UIImage imageNamed:@"splash_img2"];
        }else if(i==2){
            imageView.image = [UIImage imageNamed:@"splash_img3"];
        }else if(i==3){
            imageView.image = [UIImage imageNamed:@"splash_img4"];
            UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
            button.frame = CGRectMake(70, 652, 270, 50);
            // button.backgroundColor = [UIColor blackColor];
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            imageView.userInteractionEnabled = YES;
            [imageView addSubview:button];
            
            
        }
        
        [scrollView addSubview:imageView];
        
    }
    
    scrollView.contentSize = CGSizeMake(441* 4 , 414);
    scrollView.pagingEnabled = YES;
    
}

-(void)buttonClick:(UIButton *)sender{
    
    MainViewController *mainVC = [MainViewController new];
    UINavigationController *navVC = [[UINavigationController alloc]initWithRootViewController:mainVC];
    UIWindow *window = [[[UIApplication sharedApplication]delegate]window];
    [window setRootViewController:navVC];
    
    
    
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
