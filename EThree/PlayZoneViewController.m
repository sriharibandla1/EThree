//
//  PlayZoneViewController.m
//  E3
//
//  Created by Kardas Veeresham on 3/20/19.
//  Copyright © 2019 lancius. All rights reserved.
//

#import "PlayZoneViewController.h"
#import "SupportedFiles/Network.h"
#import "SupportedFiles/AsyncImageView.h"
#import "SupportedFiles/ProgressViewController.h"
#import "RestaurantItemsViewController.h"


@implementation RestaurantCollectionViewCell @end
@interface PlayZoneViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property NSArray * venderListDataArray;
@property NSArray * bannerListDataArray;
@property int numberInBaner;

@end

@implementation PlayZoneViewController
NSTimer * scrollingTimer;
- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.restaurantCollectionView.delegate = self;
    self.restaurantCollectionView.dataSource = self;
    [self.restaurantCollectionView setShowsVerticalScrollIndicator:NO];

    [self vendorListData];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
        return self.venderListDataArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
        RestaurantCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RestaurantCollectionViewCellId" forIndexPath:indexPath];
        NSDictionary * item = self.venderListDataArray[indexPath.row];
        cell.restaurantImage.imageURLString = item[@"vendor_logo"];

        
//        cell.cellView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
//        cell.cellView.layer.shadowOpacity = 1;
//        cell.cellView.layer.shadowOffset = CGSizeMake(.5f,1);
//        cell.cellView.layer.shadowRadius = 2;
//        cell.cellView.layer.masksToBounds = false;
        cell.cellView.layer.borderWidth = 1;
        cell.cellView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        cell.cellView.layer.cornerRadius = 10;
        cell.cellView.clipsToBounds = true;
        return cell;
    
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
        return CGSizeMake(self.restaurantCollectionView.frame.size.width/3 - 10 ,100);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    RestaurantItemsViewController* view = [self.storyboard instantiateViewControllerWithIdentifier:@"RestaurantItemsViewControllerId"];
    NSDictionary * item = self.venderListDataArray[indexPath.row];
    view.venderCodeString = item[@"vendor_code"];
    view.imageURLString = item[@"vendor_logo"];
    [self.navigationController pushViewController:view animated:YES];
}

- (IBAction)backBtnAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)vendorListData
{
    [self.view addSubview:[ProgressViewController sharedProgressVC].view];
    NSString * urlString = @"http://ethree.in/api/vendorList";
    [[Network networkManager]vendorListData:urlString complete:^(NSDictionary *jsonDict, NSURLResponse *response, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.venderListDataArray = jsonDict[@"list"];
            [self.restaurantCollectionView reloadData];
            [ProgressViewController sharedProgressVC].view.hidden = YES;

        });
    }];
}

@end
