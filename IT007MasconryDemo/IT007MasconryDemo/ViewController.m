//
//  ViewController.m
//  IT007MasconryDemo
//
//  Created by Mac on 16/6/20.
//  Copyright © 2016年 LvShuai. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //[self testOne];
    //[self testTwo];
    [self testShree];
    
    
    
}

- (void)testShree{
    
    UIScrollView *scrollView = [UIScrollView new];
    [self.view addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(20, 0, 20, 0));
        
        
    }];
    
    UILabel *lastLable = nil;
    for (NSInteger i = 0; i < 20; i++) {
        
        UILabel *lable = [[UILabel alloc]init];
        lable.backgroundColor = [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1];
        lable.text = [NSString stringWithFormat:@"%ld",i];
        [scrollView addSubview:lable];
        
        [lable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(scrollView);
            make.width.equalTo(scrollView);
     //     make.right.equalTo(scrollView.mas_right);
            
     //除了第一次增加约束的时候，scrollView的right和bottom不能使用，因为再次使用时这两个属性表示scrollView的contentSize
            
         if (!lastLable) {
                make.top.equalTo(scrollView);
            }else {
                make.top.equalTo(lastLable.mas_bottom);
            }
            
            CGFloat height = arc4random()%100 +100;
            make.height.mas_equalTo(height);
            
        }];
        lastLable = lable;
        
    }
    
  [scrollView mas_updateConstraints:^(MASConstraintMaker *make) {
      
      make.bottom.equalTo(lastLable);
      
  }];
    
    
    
    //scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(lastLable.frame));
    
}

-(void)testTwo{
    //1.约束center和size
    UIView *centerView = [UIView new];
    centerView.backgroundColor = [UIColor redColor];
    [self.view addSubview:centerView];
    
    
    [centerView mas_makeConstraints:^(MASConstraintMaker *make) {
      
       // make.center.equalTo(self.view).with.centerOffset(CGPointMake(0, 0));
        
        make.center.equalTo(self.view);
                                                   
      //make.size.equalTo(self.view).with.sizeOffset(CGSizeMake(-100, -200));
        
       // make.size.equalTo([NSValue valueWithCGSize:CGSizeMake(200, 200)]);
        
        make.size.mas_equalTo(CGSizeMake(200, 200));
        
        
     
    }];
    
    //2.约束偏移量
    UIView *topView = [UIView new];
    topView.backgroundColor = [UIColor brownColor];
    [self.view addSubview:topView];
    
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        //and 和 with 可以不写。
        
        
        make.top.and.left.and.right.equalTo(self.view).with.insets(UIEdgeInsetsMake(10, 20, 100000, 40));
        make.bottom.equalTo(centerView.mas_top).with.offset(-30);
        
        }];

    //3.单独约束宽高
    UIView *bottomView = [UIView new];
    bottomView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:bottomView];
    
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(topView);
        
        make.width.equalTo(bottomView.mas_height);
        
        make.height.equalTo(topView);
        
        make.bottom.equalTo(self.view).with.offset(-20);
    }];
    
}

-(void)testOne{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor redColor];
    [self.view addSubview:view];
    UIEdgeInsets  padding = UIEdgeInsetsMake(20, 20,30, 40);
    
    //给视图添加约束，对同一个对象只能调用一次该方法，make 参数是我们用来添加约束的
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        //1.make:所有的适配条件都需要通过该参数来添加
        //2.top...:表示对view的某一个条件进行约束
        //3.equalTo:与哪个视图做比较
        //4.ottset:偏移量，其值是CGFloat
        //5.注意：bottom 和right值得正负；
        
        
       //链式语法，糖衣语法：语法简单易读。
//        make.top.equalTo(self.view.mas_top).with.offset(padding.top);
//        
//        make.left.equalTo(self.view.mas_left).with.offset(padding.left);
//        
//        make.bottom.equalTo(self.view.mas_bottom).with.offset(-padding.bottom);
//        
//        make.right.equalTo(self.view.mas_right).with.offset(-padding.right);

        make.edges.equalTo(self.view).with.insets(padding);
    
    }];
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
