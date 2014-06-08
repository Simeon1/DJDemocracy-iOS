//
//  DJDViewController.m
//  DJDemocracy
//
//  Created by Christopher Baltzer on 2014-06-07.
//  Copyright (c) 2014 DJ Democracy. All rights reserved.
//

#import "DJDViewController.h"
#import "DJDLoginViewController.h"

@interface DJDViewController () <UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *logoImage;

@property (nonatomic, assign) BOOL canVoteUp;
@property (nonatomic, assign) BOOL canVoteDown;


@property (nonatomic, strong) NSArray* topSongs;

@end


@implementation DJDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.playlist = [[DJDPlaylist alloc] init];
    self.api = [[DJDAPIController alloc] init];
    self.api.playlist = self.playlist;

    
    self.tableView.dataSource = self.playlist;
    self.tableView.delegate = self;
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(refreshPlaylist)
                                                 name:@"DJDPlaylistUpdatedNotification"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(refreshNowPlaying)
                                                 name:@"DJDPlaylistUpdatedNotification"
                                               object:nil];
}


-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    UIImage *logo = [UIImage imageNamed:@"MyJamLogo"];
    logo = [logo imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.logoImage.image = logo;
    self.logoImage.tintColor = [UIColor blackColor];
    
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        typeof(weakSelf) strongSelf = weakSelf;
        
        if (!strongSelf.topSongs) {
            strongSelf.topSongs = [strongSelf queryTopSongs];
        }
    });
    
    
    self.canVoteUp = YES;
    self.canVoteDown = YES;
    
    if (!self.pin) {
        NSLog(@"No pin?");
        [self performSegueWithIdentifier:@"LoginSegue" sender:self];
    } else {
        NSLog(@"Logging in..");
        if (self.topSongs) {
            [self.api updatePlaylist:self.topSongs withPin:self.pin];
        } else {
            [self.api updatePlaylist:@[] withPin:self.pin];
        }
    }
    
}

-(IBAction)handleButtonBegin:(id)sender {
    NSLog(@"Getting pin");
    self.pin = [[NSUserDefaults standardUserDefaults] valueForKey:@"partyPin"];
}

-(BOOL)canPerformUnwindSegueAction:(SEL)action fromViewController:(UIViewController *)fromViewController withSender:(id)sender {
    
    return YES;
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //DJDLoginViewController* login = [segue destinationViewController];
    //login.parent = sender;
}



-(void)refreshPlaylist {
    [self.tableView reloadData];
}

-(void)refreshNowPlaying {
    
}

-(NSArray*)queryTopSongs {
    NSMutableArray *songs = [NSMutableArray array];
    
    /*
    NSTimeInterval start  = [[NSDate date] timeIntervalSince1970];
    
    MPMediaQuery *songsQuery = [MPMediaQuery songsQuery];
    NSArray *songsArray = [songsQuery items];
    
    if (![songsArray count]) {
        NSLog(@"No songs found");
        return nil;
    }
    
    NSSortDescriptor *sorter = [NSSortDescriptor sortDescriptorWithKey:MPMediaItemPropertyLastPlayedDate
                                                             ascending:NO];
    NSArray *sortedSongsArray = [songsArray sortedArrayUsingDescriptors:@[sorter]];
    
    NSTimeInterval finish = [[NSDate date] timeIntervalSince1970];
    NSLog(@"Execution took %f seconds.", finish - start);
    
    for (int i = 0; i < [sortedSongsArray count] && i < 25; i++) {
        
        MPMediaItem *itunesSong = sortedSongsArray[i];
        NSString *title = [itunesSong valueForProperty:MPMediaItemPropertyTitle];
        if (!title) {
            title = @"";
        }
        
        NSString *artist = [itunesSong valueForProperty:MPMediaItemPropertyAlbumArtist];
        if (!artist) {
            artist = [itunesSong valueForProperty:MPMediaItemPropertyArtist];
        }
        if (!artist) {
            artist = @"";
        }
        
        DJDSong *song = [DJDSong songWithTitle:title andArtist:artist];
        NSLog(@"%@", song);
        [songs addObject:song];
    }*/
    
    
    DJDSong *turnDown = [DJDSong songWithTitle:@"Turn Down for What" andArtist:@"DJ Snake & Lil Jon"];
    [songs addObject:turnDown];
    
    DJDSong *dirtVide = [DJDSong songWithTitle:@"Dirty Vibe" andArtist:@"Skrillex"];
    [songs addObject:dirtVide];
    
    DJDSong *pompeii = [DJDSong songWithTitle:@"Pompeii" andArtist:@"Bastille"];
    [songs addObject:pompeii];

    
    return [NSArray arrayWithArray:songs];
}


- (IBAction)upvote:(UIButton *)sender {
    if (!self.canVoteUp) return;
    self.canVoteUp = NO;
    
    UITableViewCell* cell = (UITableViewCell*)[[[sender superview] superview] superview];
    NSIndexPath* indexPath = [self.tableView indexPathForCell:cell];
    
    
    DJDSong* song = [self.playlist getSong:indexPath.row];
    
    [self.api upvoteSong:song withPin:self.pin];

    cell.backgroundColor = [self colorFromRed:105 green:206 blue:87];
}


- (IBAction)downvote:(UIButton *)sender {
    if (!self.canVoteDown) return;
    self.canVoteDown = NO;
    
    
    UITableViewCell* cell = (UITableViewCell*)[[[sender superview] superview] superview];
    NSIndexPath* indexPath = [self.tableView indexPathForCell:cell];
    
    
    DJDSong* song = [self.playlist getSong:indexPath.row];
    
    [self.api downvoteSong:song withPin:self.pin];
    
    cell.backgroundColor = [self colorFromRed:208 green:103 blue:93];
}



- (IBAction)handleShareButton:(UIButton *)sender {
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


- (IBAction)handleLogoutButton:(UIButton *)sender {
    NSLog(@"Logging out");
    self.pin = nil;
    self.topSongs = nil;

    [self clearVoteSelections];

    [self.playlist clearPlaylist];
    [self.tableView reloadData];
}


-(void)clearVoteSelections {
    for (int section = 0; section < [self.tableView numberOfSections]; section++) {
        for (int row = 0; row < [self.tableView numberOfRowsInSection:section]; row++) {
            NSIndexPath* cellPath = [NSIndexPath indexPathForRow:row inSection:section];
            UITableViewCell* cell = [self.tableView cellForRowAtIndexPath:cellPath];
            NSLog(@"test");
            cell.backgroundColor = [UIColor whiteColor];
        }
    }
    
    //[self.tableView reloadData];
}


-(UIColor*)colorFromRed:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue {
    CGFloat r = red / 255.0f;
    CGFloat g = green / 255.0f;
    CGFloat b = blue / 255.0f;
    
    return [UIColor colorWithRed:r green:g blue:b alpha:1.0];
}


@end
