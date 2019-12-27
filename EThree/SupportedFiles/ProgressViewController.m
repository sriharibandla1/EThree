//
//  ProgressViewController.m
//  CarNeeds
//
//  Created by Gopal Gundaram on 28/12/18.
//  Copyright © 2018 Gundaram, Gopal. All rights reserved.
//

#import "ProgressViewController.h"



@interface ProgressViewController ()

@end

@implementation ProgressViewController


+ (instancetype)sharedProgressVC {
    static ProgressViewController *instance;
    static dispatch_once_t onceToken;
//    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    dispatch_once(&onceToken, ^{
        instance = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"progressContIdentifier"];
    });
    return instance;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

//+(ProgressViewController *)progressViewController
//{
//    ProgressViewController * progres = [self.storyboard instantiateViewControllerWithIdentifier:@"progressContIdentifier"];
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
