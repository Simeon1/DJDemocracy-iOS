//
//  DJDCreateViewController.m
//  DJDemocracy
//
//  Created by Christopher Baltzer on 2014-06-07.
//  Copyright (c) 2014 DJ Democracy. All rights reserved.
//

#import "DJDCreateViewController.h"

@interface DJDCreateViewController ()

@end

@implementation DJDCreateViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}



- (IBAction)handleButtonShare:(UIButton *)sender {
    
    NSString* message = @"I just created a playlist, come jam with me!";
    
    NSURL *url = [NSURL URLWithString:@"http://myjam.co"];
    
    NSMutableArray *share = [NSMutableArray arrayWithObjects:message, url, nil];
    
    NSArray *activitiesToHide = @[
                              UIActivityTypePostToWeibo,
                              UIActivityTypePrint,
                              UIActivityTypeCopyToPasteboard,
                              UIActivityTypeAssignToContact,
                              UIActivityTypeSaveToCameraRoll,
                              UIActivityTypeAddToReadingList,
                              UIActivityTypePostToFlickr,
                              UIActivityTypePostToVimeo,
                              UIActivityTypePostToTencentWeibo,
                              UIActivityTypeAirDrop
                              ];
    
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:share applicationActivities:nil];
    
    activityVC.excludedActivityTypes = activitiesToHide;
    
    
    [self presentViewController:activityVC animated:YES completion:nil];
    
}



- (IBAction)handleButtonBegin:(UIStoryboardSegue *)sender {
    NSLog(@"Button begin");
    [[NSUserDefaults standardUserDefaults] setValue:@"1234" forKey:@"partyPin"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}



@end
