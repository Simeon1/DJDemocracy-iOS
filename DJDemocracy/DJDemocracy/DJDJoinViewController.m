//
//  DJDJoinViewController.m
//  DJDemocracy
//
//  Created by Christopher Baltzer on 2014-06-07.
//  Copyright (c) 2014 DJ Democracy. All rights reserved.
//

#import "DJDJoinViewController.h"

@interface DJDJoinViewController ()


@end



@implementation DJDJoinViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.pinField becomeFirstResponder];
}


-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}


- (IBAction)handleJoinButton:(UIButton *)sender {
    
    [[NSUserDefaults standardUserDefaults] setValue:self.pinField.text forKey:@"partyPin"];

}

@end
