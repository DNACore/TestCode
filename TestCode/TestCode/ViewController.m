//
//  ViewController.m
//  TestCode
//
//  Created by Encoder on 15/8/21.
//  Copyright (c) 2015年 Encoder. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
    NSArray *functionNameArray;
}
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    functionNameArray=[NSArray arrayWithObjects:
                   @"流量统计",
                   nil];
    [self.mainTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"reuseCellIdn"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"reuseCellIdn"];
    cell.textLabel.text=[functionNameArray objectAtIndex:indexPath.row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return functionNameArray.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}


@end
