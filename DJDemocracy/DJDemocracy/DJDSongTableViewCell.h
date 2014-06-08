//
//  DJDSongTableViewCell.h
//  DJDemocracy
//
//  Created by Christopher Baltzer on 2014-06-08.
//  Copyright (c) 2014 DJ Democracy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DJDSongTableViewCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UIImageView* artwork;

@property (nonatomic, strong) IBOutlet UILabel *votes;
@property (nonatomic, strong) IBOutlet UILabel *title;
@property (nonatomic, strong) IBOutlet UILabel *artist;

@property (nonatomic, strong) IBOutlet UIButton *upvote;
@property (nonatomic, strong) IBOutlet UIButton *downvote;

@end
