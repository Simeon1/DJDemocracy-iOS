//
//  DJDViewController.m
//  DJDemocracy
//
//  Created by Christopher Baltzer on 2014-06-07.
//  Copyright (c) 2014 DJ Democracy. All rights reserved.
//

#import "DJDViewController.h"


@interface DJDViewController ()

@end


@implementation DJDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.api = [[DJDAPIController alloc] init];

}


-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    DJDSong* song = [DJDSong songWithTitle:@"Turn Down for What"
                                 andArtist:@"DJ Snake & Lil Jon"];
    
    while(YES) {
        [self.api upvote:song];
    }
    
    
}




@end
