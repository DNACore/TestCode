//
//  ScrollViewTestViewController.m
//  TestCode
//
//  Created by Encoder on 15/9/21.
//  Copyright (c) 2015年 Encoder. All rights reserved.
//

#import "ScrollViewTestViewController.h"
#import "MJRefresh.h"
#import "FilteredWebCache.h"

@interface ScrollViewTestViewController ()
@property (weak, nonatomic) IBOutlet UITableView *ListView;
@property (weak, nonatomic) IBOutlet UIWebView *detailWebview;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *listViewTopC;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *listViewBottomC;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *detailViewTopC;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *detailViewBottomC;

@end

@implementation ScrollViewTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initWebCache];

    [self.ListView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
//添加上拉刷新控件

    __weak typeof(self) weakSelf=self;
    self.ListView.footer=[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        [weakSelf moveView];
    }];
    [self.detailWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]]];
    self.detailWebview.scrollView.header=[MJRefreshHeader headerWithRefreshingBlock:^{
        
        [weakSelf goBack];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    LogFuncPrint;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)initWebCache{//使用自建的缓存替代系统默认的
    NSString *cachePath=[NSString stringWithFormat:@"%@/selfCache/",[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) firstObject]];
    static NSUInteger discCapacity = 10*1024*1024;
    static NSUInteger memoryCapacity = 512*1024;
    FilteredWebCache *cache=[[FilteredWebCache alloc]initWithMemoryCapacity:memoryCapacity diskCapacity:discCapacity diskPath:cachePath];
    [NSURLCache setSharedURLCache:cache];
}

#pragma mark - UITableViewDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text=[NSString stringWithFormat:@"%lu",indexPath.row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

#pragma mark - 移动View
-(void)moveView{
    NSLog(@"%f",self.ListView.contentInset.top) ;
    self.detailWebview.scrollView.contentInset=self.ListView.contentInset;
    self.detailWebview.scrollView.contentOffset=CGPointMake(0, -64.f);
    
   [UIView animateWithDuration:0.5f delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
       self.listViewTopC.constant=-self.view.frame.size.height;
       self.listViewBottomC.constant=self.view.frame.size.height;
       self.detailViewBottomC.constant=0.f;
       self.ListView.frame=CGRectMake(0, self.ListView.frame.origin.y-self.ListView.frame.size.height, self.ListView.frame.size.width, self.ListView.frame.size.height);
       self.detailWebview.frame=CGRectMake(0, 0, self.detailWebview.frame.size.width, self.detailWebview.frame.size.height);
   } completion:^(BOOL finished) {
       [self.ListView.footer endRefreshing];
       self.ListView.contentOffset=CGPointMake(0.f, 0.f);
   }];
}

-(void)goBack{
    [UIView animateWithDuration:0.5f delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.listViewTopC.constant=0.f;
        self.listViewBottomC.constant=1.f;
        self.detailViewBottomC.constant=-self.view.frame.size.height;
        self.ListView.frame=CGRectMake(0, 0, self.ListView.frame.size.width, self.ListView.frame.size.height);
        self.detailWebview.frame=CGRectMake(0, self.view.frame.size.height, self.detailWebview.frame.size.width, self.detailWebview.frame.size.height);
    } completion:^(BOOL finished) {
        [self.detailWebview.scrollView.header endRefreshing];
    }];
}
@end
