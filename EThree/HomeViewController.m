//
//  HomeViewController.m
//  E3
//
//  Created by Kardas Veeresham on 11/21/18.
//  Copyright © 2018 lancius. All rights reserved.
//

#import "HomeViewController.h"
#import "OrdersViewController.h"
#import "AddMoneyViewController.h"
#import "QRScanner/ScannerViewController.h"
#import "TabBarViewController.h"
#import "SupportedFiles/Network.h"
#import "SupportedFiles/AsyncImageView.h"
#import "SupportedFiles/ProgressViewController.h"
#import "RestaurantItemsViewController.h"
#import "LogInViewController.h"
#import "EThreeCardViewController.h"
#import "TransactionsViewController.h"
#import "QRScanner/ScannerViewController.h"
#import "ProfileViewController.h"
#import "PlayZoneViewController.h"
#import "SupportedFiles/ForCoreDataMethods.h"
#import "OrdersViewController.h"

@implementation HomeRestaurantsCollectionViewCell @end
@implementation HomeBannerCollectionViewCell @end
@implementation FavoriteRestaurantsCollectionViewCell @end
@interface HomeViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property NSArray * venderListDataArray;
@property NSArray * bannerListDataArray;
@property int numberInBaner;
@end

@implementation HomeViewController
NSTimer * scrollingTimer1;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     [self.navigationController setNavigationBarHidden:YES];
    
    UITapGestureRecognizer*topper = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideSlidePlan:)];
    topper.numberOfTapsRequired=1;
    [self.transVc addGestureRecognizer:topper];
    
    self.homeBannerCollectionView.delegate = self;
    self.homeBannerCollectionView.dataSource = self;
    self.homeResturentCollectionView.delegate = self;
    self.homeResturentCollectionView.dataSource = self;
    [self.homeResturentCollectionView setShowsVerticalScrollIndicator:NO];
    [self.homeBannerCollectionView setShowsHorizontalScrollIndicator:NO];
    [self.mainScrollView setShowsVerticalScrollIndicator:NO];

    
    self.numberInBaner = 0;
    
   
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    NSDictionary * item = [[NSUserDefaults standardUserDefaults]valueForKey:@"USER"];
    if ([[NSUserDefaults standardUserDefaults]valueForKey:@"USER"] == nil) {
        LogInViewController*login = [self.storyboard instantiateViewControllerWithIdentifier:@"LogInViewControllerId"];
        [self presentViewController:login animated:YES completion:nil];
    }
    else
    {
        self.nameLabel.text = item[@"username"];
        self.nameInSlidemenu.text = item[@"username"];
        self.mailInSlideMenu.text = item[@"email"];
    [self.transVc setHidden:YES];
    [self.slideVc setHidden:YES];
    [self.tabBarController.tabBar setHidden:NO];
        
        [self Design];
        [self bannerData];
        [self vendorListData];
    }
}

-(void)Design
{
    self.playZoneButton.layer.cornerRadius = 5;
    self.foodCourtsButton.layer.cornerRadius = 5;
    self.culturalStageButton.layer.cornerRadius = 5;
    self.breweryButton.layer.cornerRadius = 5;
    self.exhibitionButton.layer.cornerRadius = 5;

}

-(void)hideSlidePlan:(UITapGestureRecognizer*)gusture
{
    if (gusture.state == UIGestureRecognizerStateEnded)
    {
        [self.transVc setHidden:YES];
        [UIView transitionWithView:self.slideVc duration:0.2 options:UIViewAnimationOptionCurveEaseIn animations:^{
            CGRect frame=self.slideVc.frame;
            frame.origin.x=-self.slideVc.frame.size.width;
            self.slideVc.frame=frame;
        } completion:nil];
    }
}
- (IBAction)slideBtnAction:(UIButton *)sender {
    [self.transVc setHidden:NO];
    [self.slideVc setHidden:NO];
    
    if (sender == self.slideMenuButton)
    {
        [UIView transitionWithView:self.slideVc duration:0.2 options:UIViewAnimationOptionCurveEaseIn animations:^{
            CGRect frame=self.slideVc.frame;
            frame.origin.x=0;
            self.slideVc.frame=frame;
        } completion:nil];
    }
}




-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView.tag == 1) {
        return self.bannerListDataArray.count;
    }
    else{
        return self.venderListDataArray.count;
    }
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView.tag == 1) {
        HomeBannerCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeBannerCollectionViewCellId" forIndexPath:indexPath];
        NSDictionary * items = self.bannerListDataArray[indexPath.row];
        cell.bannerimage.imageURLString = items[@"image"];
        return cell;
    }
    else{
        HomeRestaurantsCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeRestaurantsCollectionViewCellId" forIndexPath:indexPath];
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
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView.tag == 1) {
        return CGSizeMake(150, 200);
    }
    else{
        return CGSizeMake(self.homeResturentCollectionView.frame.size.width/3 - 14 ,100);
    }
    
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView.tag == 2) {
        RestaurantItemsViewController* view = [self.storyboard instantiateViewControllerWithIdentifier:@"RestaurantItemsViewControllerId"];
        NSDictionary * item = self.venderListDataArray[indexPath.row];
        view.venderCodeString = item[@"vendor_code"];
        view.imageURLString = item[@"vendor_logo"];
        [self.navigationController pushViewController:view animated:YES];
    }
}
-(void)strtTimer
{
    
    NSInteger section = [self numberOfSectionsInCollectionView:self.homeBannerCollectionView] - 1;
    NSInteger item = [self collectionView:self.homeBannerCollectionView numberOfItemsInSection:section] - 1;
    NSIndexPath *lastIndexPath = [NSIndexPath indexPathForItem:self.numberInBaner inSection:section];
    
    [self.homeBannerCollectionView scrollToItemAtIndexPath:lastIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    
    if (self.numberInBaner < self.bannerListDataArray.count-1) {
        self.numberInBaner = self.numberInBaner + 1;
    }
    else
    {
        self.numberInBaner = 0;
    }
}

- (IBAction)homeBtnAction:(UIButton *)sender {
    [self.transVc setHidden:YES];
    [UIView transitionWithView:self.slideVc duration:0.2 options:UIViewAnimationOptionCurveEaseIn animations:^{
        CGRect frame=self.slideVc.frame;
        frame.origin.x=-self.slideVc.frame.size.width;
        self.slideVc.frame=frame;
    } completion:nil];
}
- (IBAction)e3CardBtnAction:(UIButton *)sender {
    EThreeCardViewController * view = [self.storyboard instantiateViewControllerWithIdentifier:@"EThreeCardViewControllerId"];
    
    [self.navigationController pushViewController:view animated:YES];
}

- (IBAction)scannerBtnAction:(UIButton *)sender {
    ScannerViewController * view = [self.storyboard instantiateViewControllerWithIdentifier:@"ScannerViewControllerId"];
    
    [self.navigationController pushViewController:view animated:YES];
}
- (IBAction)transactionBtnAction:(UIButton *)sender {
    OrdersViewController * view = [self.storyboard instantiateViewControllerWithIdentifier:@"OrdersViewControllerId"];
    
    [self.navigationController pushViewController:view animated:YES];
}
- (IBAction)profileBtnAction:(UIButton *)sender {
    ProfileViewController * view = [self.storyboard instantiateViewControllerWithIdentifier:@"ProfileViewControllerId"];
    
    [self.navigationController pushViewController:view animated:YES];
}
- (IBAction)logoutBtnAction:(UIButton *)sender {
    LogInViewController * view  = [self.storyboard instantiateViewControllerWithIdentifier:@"LogInViewControllerId"];
    [[NSUserDefaults standardUserDefaults]setValue:nil forKey:@"USER"];
    if ([[ForCoreDataMethods networkManager]getDateFromCoreDate].count != 0) {
        [[ForCoreDataMethods networkManager]deleteData];
    }
    
    [self presentViewController:view animated:YES completion:nil];
}

- (IBAction)foodCourtBtnAction:(UIButton *)sender {
    PlayZoneViewController* view =[self.storyboard instantiateViewControllerWithIdentifier:@"PlayZoneViewControllerId"];
    
    [self.navigationController pushViewController:view animated:YES];
}


-(void)bannerData
{[self.view addSubview:[ProgressViewController sharedProgressVC].view];
    NSString * urlString = @"http://ethree.in/api/bannerList";
    [[Network networkManager]bannerList:urlString complete:^(NSDictionary *jsonDict, NSURLResponse *response, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (jsonDict[@"list"] != nil) {
                
            self.bannerListDataArray = jsonDict[@"list"];
            [self.homeBannerCollectionView reloadData];
             scrollingTimer1 = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(strtTimer) userInfo:nil repeats:YES];
            [ProgressViewController sharedProgressVC].view.hidden = YES;
            }
        });
    }];
}

-(void)vendorListData 
{
    [self.view addSubview:[ProgressViewController sharedProgressVC].view];
    NSString * urlString = @"http://ethree.in/api/vendorList";
    [[Network networkManager]vendorListData:urlString complete:^(NSDictionary *jsonDict, NSURLResponse *response, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.venderListDataArray = jsonDict[@"list"];
            [self.homeResturentCollectionView reloadData];
            [self setAutoLayOuts];
            [ProgressViewController sharedProgressVC].view.hidden = YES;
            
        });
    }];
}
-(void)setThirdView
{
    self.thirdViewOne.frame = CGRectMake(10, 8, self.view.frame.size.width, 20);
    self.thirdViewTwo.frame = CGRectMake(20, self.thirdViewOne.frame.origin.y + 40, self.view.frame.size.width - 40, 40);
    self.thirdViewThree.frame = CGRectMake(20, self.thirdViewTwo.frame.origin.y + 60, self.view.frame.size.width - 40, 40);
    self.exhibitionButton.frame = CGRectMake(20, self.thirdViewThree.frame.origin.y + 60, self.view.frame.size.width - 40, 40);
    self.playZoneButton.frame = CGRectMake(0, 0, self.thirdViewTwo.frame.size.width/2 - 5, 40);
     self.foodCourtsButton.frame = CGRectMake(self.thirdViewTwo.frame.size.width/2 + 5, 0, self.thirdViewTwo.frame.size.width/2 - 5, 40);
    self.culturalStageButton.frame = CGRectMake(0, 0, self.thirdViewThree.frame.size.width/2 - 5, 40);
    self.breweryButton.frame = CGRectMake(self.thirdViewThree.frame.size.width/2 + 5, 0, self.thirdViewThree.frame.size.width/2 - 5, 40);
}
-(void)setAutoLayOuts
{
    self.homeBannerCollectionView.frame = CGRectMake(0, 0, self.view.frame.size.width, 220);
    NSInteger count = self.venderListDataArray.count/3;
    if (self.venderListDataArray.count % 3 != 0) {
      self.homeResturentCollectionView.frame = CGRectMake(0, 240, self.view.frame.size.width, (count + 1) * 115);
         self.refurYourFriendBt.frame = CGRectMake(0, self.homeResturentCollectionView.frame.origin.y +(count + 1) * 115 , self.view.frame.size.width, 150);
    }
    else
    {
    self.homeResturentCollectionView.frame = CGRectMake(0, 170, self.view.frame.size.width, count * 115);
    self.refurYourFriendBt.frame = CGRectMake(0, self.homeResturentCollectionView.frame.origin.y + count * 115 , self.view.frame.size.width, 150);
    }
    self.refurYourFriendBt.backgroundColor = UIColor.redColor;
     self.thirdView.frame = CGRectMake(0, self.refurYourFriendBt.frame.origin.y + 160 , self.view.frame.size.width, 150);
    self.mainScrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.thirdView.frame.origin.y + 240);
    [self setThirdView];
}
@end
