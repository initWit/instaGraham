//
//  ProfileViewController.m
//  InstaGraham
//
//  Created by Robert Figueras on 6/12/14.
//
//

#import "ProfileViewController.h"

@interface ProfileViewController ()
@property (strong, nonatomic) IBOutlet UIButton *followButton;
@property (strong, nonatomic) IBOutlet UIImageView *profileImageView;
@property (strong, nonatomic) IBOutlet UILabel *numberOfPhotosLabel;
@property (strong, nonatomic) IBOutlet UILabel *numberOfFollowersLabel;
@property (strong, nonatomic) IBOutlet UILabel *numberOfFollowingLabel;

@end

@implementation ProfileViewController


- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.followButton setEnabled:NO];

    self.currentUserForProfile = [PFUser currentUser];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    self.title = self.currentUserForProfile.username;

    PFFile *imageFile = [self.currentUserForProfile objectForKey:@"profilePic"];

    NSLog(@"imageFile is %@", imageFile);





}


@end
