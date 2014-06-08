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
                                             selector:@selector(refreshUI)
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
    
    
    
    
    if (!self.pin) {
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



-(void)refreshUI {
    [self.tableView reloadData];
}


-(NSArray*)queryTopSongs {
    NSMutableArray *songs = [NSMutableArray array];
    
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
    }
    
    return [NSArray arrayWithArray:songs];
}








@end
