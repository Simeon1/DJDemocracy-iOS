//
//  DJDRaveViewController.m
//  DJDemocracy
//
//  Created by Christopher Baltzer on 2014-06-08.
//  Copyright (c) 2014 DJ Democracy. All rights reserved.
//

#import "DJDRaveViewController.h"

@interface DJDRaveViewController ()

@property (nonatomic, strong) NSArray* frames;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation DJDRaveViewController

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

    
    UIImage *this = [UIImage imageNamed:@"This"];
    UIImage *my = [UIImage imageNamed:@"my"];
    UIImage *jam = [UIImage imageNamed:@"jam"];
    
    self.frames = [NSArray arrayWithObjects:this, my, jam, nil];
}


-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.imageView.image = [UIImage animatedImageWithImages:self.frames duration:1];
    
    
}


- (IBAction)dismiss:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
