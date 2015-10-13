//
//  CollectionCellTestViewController.m
//  TestCode
//
//  Created by Encoder on 15/10/10.
//  Copyright © 2015年 Encoder. All rights reserved.
//

#import "CollectionCellTestViewController.h"

@interface CollectionCellTestViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionTestView;

@end

@implementation CollectionCellTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.collectionTestView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cidn"];
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

#pragma mark - Collection Delegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 30;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cidn" forIndexPath:indexPath];
    switch (indexPath.row%3) {
        case 0:
            cell.contentView.backgroundColor=[UIColor redColor];
            break;
        case 1:
            cell.contentView.backgroundColor=[UIColor blueColor];
            break;
        case 2:
            cell.contentView.backgroundColor=[UIColor yellowColor];
            break;
        default:
            cell.contentView.backgroundColor=[UIColor purpleColor];
            break;
    }
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.row%3) {
        case 0:
            return CGSizeMake(self.collectionTestView.frame.size.width, 140);
            break;
        default:
            return CGSizeMake(self.collectionTestView.frame.size.width/2, 140);
            break;
    }
}

@end
