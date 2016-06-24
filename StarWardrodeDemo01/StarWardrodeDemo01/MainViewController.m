//
//  MainViewController.m
//  StarWardrodeDemo01
//
//  Created by Mac on 16/6/17.
//  Copyright © 2016年 LvShuai. All rights reserved.
//

#import "MainViewController.h"
#import "DatabaseTool.h"
#import "UIImageView+WebCache.h"
#import "shopModel.h"
#import "ProductModel.h"

#define MYMAX(a,b)  (a) >= (b) ? (a) : (b)


@interface MainViewController ()
{
    UIScrollView *scrolView;
    UIPageControl *page;
    
    CGFloat  _colHeight[2];
    UIScrollView *_bgScrollView;
    CGFloat _width;
    
}
@property(nonatomic,retain)NSMutableArray *dataArr;


@property(nonatomic,strong)NSMutableArray *shopArr;

@property(nonatomic,retain)NSMutableArray *proArr;

@end

@implementation MainViewController

-(NSMutableArray *)shopArr{
    
    if (!_shopArr) {
        _shopArr = [NSMutableArray array];
    }
    return _shopArr;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIImageView *imageview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"top-logo"]];
    self.navigationItem.titleView =imageview;
   
    
    _dataArr = @[].mutableCopy;
    
   [DatabaseTool getProductUrlInfo:^(NSMutableArray *array) {
       [_dataArr addObjectsFromArray:array];
        [self creatScrollView];
      // NSLog(@"=======%ld",_dataArr.count);
   } ];
    
    [self  createButtonView];
    
    _colHeight[0] =0.0f;
    _colHeight[1] =0.0f;
    
    _width =([UIScreen mainScreen].bounds.size.width-30)/2;
    [self getShopArr];
    
    [self creatView];
    
    _proArr =@[].mutableCopy;
    [DatabaseTool getShopingUrlInfo:^(NSMutableArray *shArrry) {
        [_proArr addObjectsFromArray:shArrry];
        NSLog(@"====%ld",_proArr.count);
    }];
    
    
    
    
}
     
-(void)getShopArr{
         
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        for (NSInteger i=0; i<100; i++) {
            CGFloat height = arc4random()%100+180;
            [self.shopArr addObject:[NSNumber numberWithFloat:height]];
           // NSLog(@"%ld",self.shopArr.count);
            //不要在这里写代码
        }
        //刷新UI
        dispatch_async(dispatch_get_main_queue(), ^{
            [self  reloadView];
        });
        
    });

}
     
-(void)reloadView{
         if (self.proArr.count ==0) {
             return;
         }
         
         for (NSInteger i=0; i<self.proArr.count; i++) {
             //用一个index记录到底排左边还是右边
             NSInteger index = _colHeight[0]<=_colHeight[1] ? 0:1 ;
             //取出lable的高度
             CGFloat height =[self.shopArr[i] floatValue];
             
             //算出label的坐标
             CGFloat  x = 10 + index *(_width +10);
             
             CGFloat  y = _colHeight[index]+250;
             
             UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, _width, height)];
             imageView.backgroundColor = [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1];
             ProductModel *model = self.proArr[i];
             
             [imageView  sd_setImageWithURL:[NSURL URLWithString:model.picUrl]];
             
             [_bgScrollView addSubview:imageView];
             //更新高度
             _colHeight[index]+=height+10;
             
         }
         
         _bgScrollView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
         
         // CGFloat maxH =_colHeight[0]<=_colHeight[1]?_colHeight[1]:_colHeight[0];
         
         CGFloat maxH =MAX(_colHeight[0], _colHeight[1]);
         
         _bgScrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, maxH);
         
}
     
-(void)creatView{
         UIScrollView *scroll = [[UIScrollView alloc]initWithFrame:CGRectZero];
                  
         [self.view addSubview:scroll];
         
         _bgScrollView = scroll;
}
     

-(void)createButtonView{
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(57, 224, 300, 30)];
    
    UIButton *btn01 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn01.frame = CGRectMake(0, 0, 100, 30);
//    btn01.layer.borderWidth =5;
//    btn01.layer.borderColor = [UIColor redColor].CGColor;
    [btn01 setTitle:@"最新" forState:UIControlStateNormal];
    [btn01 setBackgroundImage:[UIImage imageNamed:@"input_style_button_bg.9"] forState:UIControlStateSelected];
    btn01.userInteractionEnabled=YES;
    [view addSubview:btn01];
    
    UIButton *btn02 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn02.frame = CGRectMake(100, 0, 100, 30);
//    btn02.layer.borderWidth =5;
//    btn02.layer.borderColor = [UIColor redColor].CGColor;

    [btn02 setTitle:@"热门" forState:UIControlStateNormal];
    [btn02 setBackgroundImage:[UIImage imageNamed:@"input_style_button_bg.9"] forState:UIControlStateSelected];
    btn02.userInteractionEnabled=YES;
    [view addSubview:btn02];

    UIButton *btn03 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn03.frame = CGRectMake(200, 0, 100, 30);
//    btn03.layer.borderWidth =5;
//    btn03.layer.borderColor = [UIColor redColor].CGColor;
    [btn03 setTitle:@"猜你喜欢" forState:UIControlStateNormal];
    [btn03 setBackgroundImage:[UIImage imageNamed:@"input_style_button_bg.9"] forState:UIControlStateSelected];
    btn03.userInteractionEnabled=YES;
    
    [view addSubview:btn03];
    view.userInteractionEnabled = YES;
    [self.view addSubview:view];
    
}

-(void)creatScrollView{
    scrolView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 160)];
    
    scrolView.backgroundColor = [UIColor redColor];
    [self.view addSubview:scrolView];
    
    for (int i=0; i<_dataArr.count; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(scrolView.frame.size.width*i, 0, scrolView.frame.size.width, scrolView.frame.size.height)];
        shopModel *model = self.dataArr[i];
        
        [imageView  sd_setImageWithURL:[NSURL URLWithString:model.picUrl]];
        
        [scrolView addSubview:imageView];
        
    }
    
    scrolView.contentSize =CGSizeMake(414*6, 0);
    scrolView.pagingEnabled = YES;
    scrolView.delegate = self;
    
    page = [[UIPageControl alloc]initWithFrame:CGRectMake(107, 200, 200, 30)];
    page.numberOfPages = self.dataArr.count;
    
    [page  addTarget:self action:@selector(changepage: ) forControlEvents:UIControlEventValueChanged];
    [scrolView bringSubviewToFront:page];
    [self.view addSubview:page];
    
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(move) userInfo:nil repeats:YES];
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    page.currentPage = scrolView.contentOffset.x/414;
}

-(void)changepage:(UIPageControl *)senter{
    scrolView.contentOffset=CGPointMake(page.currentPage*414, 0);
}

-(void)move{
    static int i= 1;
    
    page.currentPage+=i;
    if (page.currentPage==_dataArr.count-1||page.currentPage==0) {
        i=-i;
    }
    
    [scrolView  setContentOffset:CGPointMake(page.currentPage*414, 0) animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
