//
//  ProfileViewController.h
//  E3
//
//  Created by Kardas Veeresham on 11/22/18.
//  Copyright © 2018 lancius. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SupportedFiles/BaseViewController.h"

@interface ProfileViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UILabel *profileNameLabel;

@property (weak, nonatomic) IBOutlet UIView *segmentView;
@property (weak, nonatomic) IBOutlet UIView *E3CardView;
@property (weak, nonatomic) IBOutlet UILabel *mobailNuLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UILabel *cardNumberlabel;

@property (weak, nonatomic) IBOutlet UIButton *imageBtn;
- (IBAction)imageBtnAction:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *myDetailsLabel;
@property (weak, nonatomic) IBOutlet UILabel *e3CardLabel;


@end
