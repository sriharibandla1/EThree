//
//  RestaurantItemsViewController.m
//  E3
//
//  Created by Kardas Veeresham on 3/21/19.
//  Copyright © 2019 lancius. All rights reserved.
//

#import "RestaurantItemsViewController.h"
#import "SupportedFiles/Network.h"
#import "SupportedFiles/AsyncImageView.h"
#import "SupportedFiles/ForCoreDataMethods.h"
#import "CartViewController.h"
#import "SupportedFiles/ProgressViewController.h"

@implementation RecommendedCollectionViewCell
@end
@implementation RestaurantIteamTableViewCell @end

@interface RestaurantItemsViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDataSource,UITableViewDelegate,UICollectionViewDelegateFlowLayout,UIPickerViewDelegate,UIPickerViewDataSource>
@property NSArray * restaurantItemsListArray;
@property NSArray * recommendedArray;
@property  NSMutableArray * productWeightTypeArray;
@property  NSMutableArray * recommendedProductWeightTypeArray;
@property  NSMutableArray *pickerViewArray;
@property NSDictionary * pickerViewElementDic;
@property NSString * selectType;
@property NSInteger positionInCart;
@property NSArray * dataFromCoreData;
@end

@implementation RestaurantItemsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getDataFromSever];
    [self recommendedData];
    UITapGestureRecognizer*topper = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideSlidePlan:)];
    topper.numberOfTapsRequired=1;
    [self.transView addGestureRecognizer:topper];
    [self.transView setHidden:YES];
    self.cartNumberLabel.layer.cornerRadius = 12.5;
    self.cartNumberLabel.layer.masksToBounds = YES;
//    [UIView transitionWithView:self.mainPickerView duration:0.2 options:UIViewAnimationOptionCurveEaseIn animations:^{
//        CGRect frame=self.mainPickerView.frame;
//        frame.origin.y=self.view.frame.size.height;
//        self.mainPickerView.frame=frame;
//    } completion:nil];
    self.recommendedCollectionView.delegate = self;
    self.recommendedCollectionView.dataSource = self;
    self.restaurantItemsTableView.delegate = self;
    self.restaurantItemsTableView.dataSource = self;
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    self.restaurantImage.imageURLString = self.imageURLString;
    self.productWeightTypeArray = [[NSMutableArray alloc]init];
    self.recommendedProductWeightTypeArray = [[NSMutableArray alloc]init];
    self.pickerViewArray = [[NSMutableArray alloc]init];
    [self.restaurantItemsScrollView setShowsVerticalScrollIndicator:NO];
    self.positionInCart = 0;
    [self toReloadData];
}
-(void)hideSlidePlan:(UITapGestureRecognizer*)gusture
{
    
    if (gusture.state == UIGestureRecognizerStateEnded)
    {
        [self.transView setHidden:YES];
        [UIView transitionWithView:self.mainPickerView duration:0.2 options:UIViewAnimationOptionCurveEaseIn animations:^{
            CGRect frame=self.mainPickerView.frame;
            frame.origin.y=self.view.frame.size.height;
            self.mainPickerView.frame=frame;
        } completion:nil];
        
    }
}
-(void)viewWillAppear:(BOOL)animated
{
    [self toReloadData];
    [self.tabBarController.tabBar setHidden:YES];
}
-(void)setAutolayouts
{
    
    NSInteger itemCount = self.recommendedArray.count / 2;
    NSInteger arrayCount = self.restaurantItemsListArray.count;
    self.restaurantItemsScrollView.frame = CGRectMake(0, 180, self.view.frame.size.width,self.view.frame.size.height - 225 );
    
   
    self.recommendedView.layer.cornerRadius = 15;
   self.recommendedView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
   self.recommendedView.layer.shadowOpacity = 1;
    self.recommendedView.layer.shadowOffset = CGSizeMake(.5f,1);
   self.recommendedView.layer.shadowRadius = 2;
   self.recommendedView.layer.masksToBounds = false;
// recommended View Inner Autolayouts :-
    self.recommendedLabel.frame = CGRectMake(8, 8, 130, 25);
    self.seeAllButton.hidden = YES;
    self.seeAllButton.frame = CGRectMake(self.recommendedView.frame.size.width -88 ,8, 80, 25);
    if (self.recommendedArray.count % 2 == 0) {
     self.recommendedView.frame = CGRectMake(8, 10, self.view.frame.size.width - 16, itemCount * 210 + 50);
    self.recommendedCollectionView.frame = CGRectMake(8 ,self.recommendedLabel.frame.size.height + 12, self.recommendedView.frame.size.width - 16,  itemCount * 210);
    }
    else
    {
        itemCount = itemCount + 1;
        self.recommendedView.frame = CGRectMake(8, 10, self.view.frame.size.width - 16, itemCount  * 210 + 50);
        self.recommendedCollectionView.frame = CGRectMake(8 ,self.recommendedLabel.frame.size.height + 12, self.recommendedView.frame.size.width - 16,  itemCount * 210);
    }
    self.restaurantItemsTableView.frame = CGRectMake(0,self.recommendedView.frame.size.height +20 + 20, self.view.frame.size.width , arrayCount * 130);
   self.restaurantItemsScrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.recommendedView.frame.size.height + arrayCount * 130 + 100) ;

 
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
        return self.recommendedArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
   
        RecommendedCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RecommendedCollectionViewCellId" forIndexPath:indexPath];
        
    
//        cell.layer.shadowColor = [UIColor lightGrayColor].CGColor;
//        cell.layer.shadowOpacity = 1;
//        cell.layer.shadowOffset = CGSizeMake(.5f,1);
//        cell.layer.shadowRadius = 2;
//        cell.layer.masksToBounds = false;
    NSDictionary*item = self.recommendedArray[indexPath.row];
    cell.restaurantRecommendedIteamImage.imageURLString = item[@"image"];
    NSDictionary*weightTypeDic = self.recommendedProductWeightTypeArray[indexPath.row];
    NSDictionary * isInCartItem =  [self itemInCart:item];
    if ([self isInCart:item]) {
        cell.typeOfWeightLabel.text = isInCartItem[@"product_weight"];
        cell.priceLabel.text = [NSString stringWithFormat:@"Rs.%li",[isInCartItem[@"product_price"]integerValue]*[isInCartItem[@"qtyList"]integerValue]];
        cell.addNdSubView.hidden = NO;
        cell.addbtInRec.hidden = YES;
        cell.numberOfItemsLabel.text = isInCartItem[@"qtyList"];
    }
    else
    {
    cell.typeOfWeightLabel.text = weightTypeDic[@"product_weight"];
    cell.priceLabel.text = [NSString stringWithFormat:@"Rs.%@",weightTypeDic[@"product_price"]];
        cell.addNdSubView.hidden = YES;
        cell.addbtInRec.hidden = NO;
    }
    if (indexPath.row > 0) {
        cell.typeOfWeightBt.tag = indexPath.row;
        cell.addbtInRec.tag = indexPath.row;
        cell.subBtInRec.tag = indexPath.row;
        cell.plusBtInRec.tag = indexPath.row;
        //cell.plusBt.tag = indexPath.row;
       // cell.subBt.tag = indexPath.row;
    }
    else
    {
        cell.typeOfWeightBt.tag = 0;
        cell.addbtInRec.tag = 0;
        cell.subBtInRec.tag = 0;
        cell.plusBtInRec.tag = 0;
    }
    if ([item[@"productTypevalue"] isEqualToString:@"Veg"]) {
        cell.typeOfProductImage.image = [UIImage imageNamed:@"vegImage"];
    }
    else
    {
        cell.typeOfProductImage.image = [UIImage imageNamed:@"nonVegImage"];
    }
    cell.IteamNameLabel.text = item[@"product_name"];
   // cell.countryNameLabel.text = item[@"product_subtitle"];
    //cell.typeOfWeightBt.tag =
        cell.layer.cornerRadius = 10;
        cell.clipsToBounds = true;
        return cell;
    
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.view.frame.size.width/2 - 25 ,210);
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //restaurantItemsListArray
    return self.restaurantItemsListArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RestaurantIteamTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"RestaurantIteamTableViewCellId"];
     NSDictionary*item = self.restaurantItemsListArray[indexPath.row];
    cell.restaurantIteamNameLabel.text = item[@"product_name"];
    NSDictionary*weightTypeDic = self.productWeightTypeArray[indexPath.row];
    NSDictionary * isInCartItem = [self itemInCart:item];
    if ([self isInCart:item]) {
        cell.wiightLabel.text = isInCartItem[@"product_weight"];
        cell.restaurantIteamPriceLabel.text = [NSString stringWithFormat:@"Rs.%li",[isInCartItem[@"product_price"]integerValue]*[isInCartItem[@"qtyList"]integerValue]];
        cell.addNdSubView.hidden = NO;
        cell.addBt.hidden = YES;
        cell.numberOfItemsLabel.text = isInCartItem[@"qtyList"];
    }
    else
    {
        cell.wiightLabel.text = weightTypeDic[@"product_weight"];
        cell.restaurantIteamPriceLabel.text = [NSString stringWithFormat:@"Rs.%@",weightTypeDic[@"product_price"]];
        cell.addNdSubView.hidden = YES;
        cell.addBt.hidden = NO;
    }
//    cell.wiightLabel.text = weightTypeDic[@"product_weight"];
//    cell.restaurantIteamPriceLabel.text =[NSString stringWithFormat:@"Rs.%@",weightTypeDic[@"product_price"]];
    cell.restaurantIteamCellView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    cell.restaurantIteamCellView.layer.shadowOpacity = 1;
    cell.restaurantIteamCellView.layer.shadowOffset = CGSizeMake(.5f,1);
    cell.restaurantIteamCellView.layer.shadowRadius = 2;
    cell.restaurantIteamCellView.layer.masksToBounds = false;
    cell.restaurantIteamCellView.layer.cornerRadius = 10;
     if (indexPath.row > 0) {
    cell.typeOfWeightBt.tag = indexPath.row;
    cell.addBt.tag = indexPath.row;
    cell.plusBt.tag = indexPath.row;
    cell.subBt.tag = indexPath.row;
     }
    else
    {
        cell.typeOfWeightBt.tag = 0;
        cell.addBt.tag = 0;
        cell.plusBt.tag = 0;
        cell.subBt.tag = 0;
    }
    if ([item[@"productTypevalue"] isEqualToString:@"Veg"]) {
        cell.typeOfProductImage.image = [UIImage imageNamed:@"vegImage"];
    }
    else
    {
        cell.typeOfProductImage.image = [UIImage imageNamed:@"nonVegImage"];
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130;
}
- (IBAction)backBtnAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)viewCartBtnAction:(UIButton *)sender {
    CartViewController*view = [self.storyboard instantiateViewControllerWithIdentifier:@"CartViewControllerId"];
    [self.navigationController pushViewController:view animated:YES];
}


-(void)getDataFromSever
{
    NSDictionary*item = @{
        @"vendor_code": self.venderCodeString,@"notrecommended":@"1"
        };
    [[Network networkManager]vendorproductsData:item complete:^(NSDictionary *jsonDict, NSURLResponse *response, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"json data = %@",jsonDict);
            self.restaurantItemsListArray = jsonDict[@"list"];
            [self setAutolayouts];
            [self setDateProductWeightTypeArray];
            [self.restaurantItemsTableView reloadData];
        });
    }];
    
}
-(void)recommendedData
{
    NSDictionary*item = @{
                          @"vendor_code": self.venderCodeString,@"recommended":@"1"
                          };
    [[Network networkManager]vendorproductsData:item complete:^(NSDictionary *jsonDict, NSURLResponse *response, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"json data = %@",jsonDict);
            self.recommendedArray = jsonDict[@"list"];
            [self setDateRecommendedProductWeightTypeArray];
            [self setAutolayouts];
            [self.recommendedCollectionView reloadData];
            
        });
    }];
}
-(void)setDateProductWeightTypeArray
{
    for (int i = 0; i<self.self.restaurantItemsListArray.count; i++) {
        NSDictionary*item = [[[self.restaurantItemsListArray objectAtIndex:i]valueForKey:@"priceList"] objectAtIndex:0];
        [self.productWeightTypeArray addObject:item];
    }
}
-(void)setDateRecommendedProductWeightTypeArray
{
    for (int i = 0; i<self.self.recommendedArray.count; i++) {
        NSDictionary*item = [[[self.recommendedArray objectAtIndex:i]valueForKey:@"priceList"]objectAtIndex:0];
        [self.recommendedProductWeightTypeArray addObject:item];
    }
}
/*postData.put("vendor_code", vendorId);
 postData.put("recommended", "1");*/
- (IBAction)donePickerViewAction:(UIButton *)sender {
    [self.transView setHidden:YES];
    [UIView transitionWithView:self.mainPickerView duration:0.2 options:UIViewAnimationOptionCurveEaseIn animations:^{
        CGRect frame=self.mainPickerView.frame;
        frame.origin.y=self.view.frame.size.height;
        self.mainPickerView.frame=frame;
    } completion:nil];
    if ([self.selectType isEqualToString:@"collectionview"]) {
    for (int i = 0; i<self.recommendedProductWeightTypeArray.count; i++) {
        NSDictionary * item = self.recommendedProductWeightTypeArray[i];
        if ([self.pickerViewElementDic[@"product_code"] isEqualToString:item[@"product_code"]]) {
            [self.recommendedProductWeightTypeArray replaceObjectAtIndex:i withObject:self.pickerViewElementDic];
            [self updateItemBasedOnWeight:self.pickerViewElementDic];
          //  [self updateItemBasedOnWeight:];
           // [self.recommendedCollectionView reloadData];
            break;
        }
    }
    }
    else
    {
        for (int i = 0; i<self.productWeightTypeArray.count; i++) {
            NSDictionary * item = self.productWeightTypeArray[i];
            NSLog(@"%@",item[@"product_code"]);
            if ([self.pickerViewElementDic[@"product_code"] isEqualToString:item[@"product_code"]]) {
                [self.productWeightTypeArray replaceObjectAtIndex:i withObject:self.pickerViewElementDic];
                [self updateItemBasedOnWeight:self.pickerViewElementDic];
              //  [self.restaurantItemsTableView reloadData];
                break;
            }
        }
    }
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.pickerViewArray.count;
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSDictionary*items = self.pickerViewArray[row];
    self.pickerViewElementDic = self.pickerViewArray[0];
    return [NSString stringWithFormat:@"%@ - %@",items[@"product_weight"],items[@"product_price"]];
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
     self.pickerViewElementDic = self.pickerViewArray[row];
}
- (IBAction)recommendWeightAction:(UIButton *)sender {
    self.selectType = @"collectionview";
    self.pickerViewArray = [[self.recommendedArray objectAtIndex:sender.tag]valueForKey:@"priceList"];
    self.nameInPickerViewLabel.text = [[self.recommendedArray objectAtIndex:sender.tag]valueForKey:@"product_name"];
    [self.transView setHidden:NO];
    [UIView transitionWithView:self.mainPickerView duration:0.2 options:UIViewAnimationOptionCurveEaseIn animations:^{
        CGRect frame=self.mainPickerView.frame;
        frame.origin.y=self.view.frame.size.height - self.mainPickerView.frame.size.height;
        NSLog(@"%f - %f",self.view.frame.size.height,self.mainPickerView.frame.size.height);
        NSLog(@"%f",self.mainPickerView.frame.origin.y);
        self.mainPickerView.frame=frame;
         self.mainPickerView.hidden = NO;
    } completion:nil];
    [self.pickerView reloadAllComponents];
    
}
- (IBAction)resturentWeightAction:(UIButton *)sender {
    self.selectType = @"tableview";
    self.pickerViewArray = [[self.restaurantItemsListArray objectAtIndex:sender.tag]valueForKey:@"priceList"];
      self.nameInPickerViewLabel.text = [[self.restaurantItemsListArray objectAtIndex:sender.tag]valueForKey:@"product_name"];
    [self.transView setHidden:NO];
    [UIView transitionWithView:self.mainPickerView duration:0.2 options:UIViewAnimationOptionCurveEaseIn animations:^{
        CGRect frame=self.mainPickerView.frame;
        frame.origin.y=self.view.frame.size.height - self.mainPickerView.frame.size.height;
        NSLog(@"%f - %f",self.view.frame.size.height,self.mainPickerView.frame.size.height);
        NSLog(@"%f",self.mainPickerView.frame.origin.y);
        self.mainPickerView.frame=frame;
        self.mainPickerView.hidden = NO;
    } completion:nil];
    [self.pickerView reloadAllComponents];
}
- (IBAction)addAcctionInRec:(UIButton *)sender {
     NSLog(@"sender tag = %li",sender.tag);
    NSDictionary*item = self.recommendedArray[sender.tag];
    NSDictionary * weightItem = self.recommendedProductWeightTypeArray[sender.tag];
    [[ForCoreDataMethods networkManager]storeDataInCoreDataproduct_code:item[@"product_code"] product_price:weightItem[@"product_price"] qtyList:@"1" product_weight_id:weightItem[@"product_weight_id"] product_weight:weightItem[@"product_weight"] product_name:item[@"product_name"]];
//    [[ForCoreDataMethods networkManager]storeDataInCoreDataproduct_code:item[@"product_code"] product_price:weightItem[@"product_price"] qtyList:@"1" product_weight_id:weightItem[@"product_weight_id"] product_weight:weightItem[@"product_weight"]];
    [self toReloadData];
   // [[ForCoreDataMethods networkManager]storeDataInCoreDataproductList:item[@"product_code"] priceList:weightItem[@"product_price"] qtyList:@"1" weightList:weightItem[@"product_weight_id"]];
   NSLog(@"%@",[[ForCoreDataMethods networkManager]getDateFromCoreDate]);
}
- (IBAction)plusActionInRec:(UIButton *)sender {
    NSDictionary*item = [self itemInCart:self.recommendedArray[sender.tag]];
    [self addItemInCart:item];
     NSLog(@"sender tag = %li",sender.tag);
}
- (IBAction)subBtActionInRec:(UIButton *)sender {
    NSDictionary*item = [self itemInCart:self.recommendedArray[sender.tag]];
    [self subItemInCart:item];
     NSLog(@"sender tag = %li",sender.tag);
}
- (IBAction)addActionInRest:(UIButton *)sender {
     NSLog(@"sender tag = %li",sender.tag);
    NSDictionary*item = self.restaurantItemsListArray[sender.tag];
    NSDictionary * weightItem = self.productWeightTypeArray[sender.tag];
     [[ForCoreDataMethods networkManager]storeDataInCoreDataproduct_code:item[@"product_code"] product_price:weightItem[@"product_price"] qtyList:@"1" product_weight_id:weightItem[@"product_weight_id"] product_weight:weightItem[@"product_weight"] product_name:item[@"product_name"]];
    [self toReloadData];
   // [[ForCoreDataMethods networkManager]storeDataInCoreDataproductList:item[@"product_code"] priceList:weightItem[@"product_price"] qtyList:@"1" weightList:weightItem[@"product_weight_id"]];
    NSLog(@"%@",[[ForCoreDataMethods networkManager]getDateFromCoreDate]);
}
- (IBAction)plusActionInRest:(UIButton *)sender {
    NSDictionary*item = [self itemInCart:self.restaurantItemsListArray[sender.tag]];
    [self addItemInCart:item];}
- (IBAction)subActionInRest:(UIButton *)sender {
    NSDictionary*item = [self itemInCart:self.restaurantItemsListArray[sender.tag]];
    [self subItemInCart:item];
}
-(BOOL)isInCart:(NSDictionary*)item {
    NSArray * itemArray = [[ForCoreDataMethods networkManager]getDateFromCoreDate];
    
    for (int i = 0; i<itemArray.count; i++) {
        if ([item[@"product_code"] isEqualToString:[[itemArray objectAtIndex:i]valueForKey:@"product_code"]]) {
            self.positionInCart = i;
            return YES;
        }
    }
    return NO;
}
-(NSDictionary*)itemInCart:(NSDictionary*)item {
    NSArray * itemArray = [[ForCoreDataMethods networkManager]getDateFromCoreDate];
    
    for (int i = 0; i<itemArray.count; i++) {
        if ([item[@"product_code"] isEqualToString:[[itemArray objectAtIndex:i]valueForKey:@"product_code"]]) {
            self.positionInCart = i;
            return [itemArray objectAtIndex:i];
        }
    }
    return item;
}
-(void)addItemInCart:(NSDictionary*)item
{
    [self isInCart:item];
    NSInteger quantity = [item[@"qtyList"]integerValue];
    quantity = quantity + 1;
    [[ForCoreDataMethods networkManager]upDataInCoreData:self.positionInCart product_code:item[@"product_code"] product_price:item[@"product_price"] qtyList:[NSString stringWithFormat:@"%li",quantity] product_weight_id:item[@"product_weight_id"] product_weight:item[@"product_weight"] product_name:item[@"product_name"]];
    [self toReloadData];
}
-(void)subItemInCart:(NSDictionary*)item
{
    [self isInCart:item];
    NSInteger quantity = [item[@"qtyList"]integerValue];
    quantity = quantity - 1;
    if (quantity == 0) {
        [[ForCoreDataMethods networkManager]delectItemFromCoreData:item];
    }
    else
    {
[[ForCoreDataMethods networkManager]upDataInCoreData:self.positionInCart product_code:item[@"product_code"] product_price:item[@"product_price"] qtyList:[NSString stringWithFormat:@"%li",quantity] product_weight_id:item[@"product_weight_id"] product_weight:item[@"product_weight"] product_name:item[@"product_name"]];
    }
    [self toReloadData];
   
}
-(void)toReloadData
{
     self.dataFromCoreData = [[ForCoreDataMethods networkManager]getDateFromCoreDate];
    self.cartNumberLabel.text = [NSString stringWithFormat:@"%li",self.dataFromCoreData.count];
    [self.recommendedCollectionView reloadData];
    [self.restaurantItemsTableView reloadData];
}
-(void)updateItemBasedOnWeight:(NSDictionary*)item
{
    if ([self isInCart:item]) {
        NSDictionary * cartItem = [self itemInCart:item];
        [[ForCoreDataMethods networkManager]upDataInCoreData:self.positionInCart product_code:cartItem[@"product_code"] product_price:item[@"product_price"] qtyList:cartItem[@"qtyList"] product_weight_id:item[@"product_weight_id"] product_weight:item[@"product_weight"] product_name:cartItem[@"product_name"]];
        
    }
    NSLog(@"%@",[[ForCoreDataMethods networkManager]getDateFromCoreDate]);
    [self toReloadData];
}
- (IBAction)cartAction:(UIButton *)sender {
   // [self forCheckOutAction];
    CartViewController*view = [self.storyboard instantiateViewControllerWithIdentifier:@"CartViewControllerId"];
    [self.navigationController pushViewController:view animated:YES];
}


@end
