//
//  HomeViewController.m
//  InstaGraham
//
//  Created by Robert Figueras and Dennis Dixon on 6/9/14.
//
//

#import "HomeViewController.h"
#import <Parse/Parse.h>
#import "Photo.h"
#import "InstaGrahamModelManager.h"
#import "PostTableViewCell.h"
#import "CommentViewController.h"
#import "PhotoWrapper.h"


@interface HomeViewController () <PFSignUpViewControllerDelegate,PFLogInViewControllerDelegate, UITableViewDataSource, UITableViewDelegate>

@property (strong,nonatomic) PFLogInViewController *logInViewController;
@property (strong,nonatomic) PFSignUpViewController *signUpViewController;
@property (strong, nonatomic) IBOutlet UITableView *photoStreamTableView;
@property InstaGrahamModelManager *modelManager;
@property NSArray *photoObjectsArray;
@property BOOL isLiked;
@property (strong, nonatomic) IBOutlet UILabel *captionLabel;

@end


@implementation HomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.photoObjectsArray = [[NSArray alloc] init];
    self.modelManager = [[InstaGrahamModelManager alloc] init];

}


- (void)viewWillAppear:(BOOL)animated
{
    if (![PFUser currentUser])
    {
        self.logInViewController = [[PFLogInViewController alloc] init];
        self.signUpViewController = [[PFSignUpViewController alloc] init];
        self.logInViewController.signUpController = self.signUpViewController;
        self.logInViewController.delegate = self;
        self.signUpViewController.delegate = self;
        [self presentViewController:self.logInViewController animated:YES completion:nil];
    }

    [self.modelManager getPhotoSetOnUser:[PFUser currentUser] includingFollowings:NO completion:^(NSArray *photoSet) {
        self.photoObjectsArray = photoSet;
        [self.photoStreamTableView reloadData];
    }];
}


#pragma mark - PFLoginViewController Login / Signup delegate methods

- (BOOL)logInViewController:(PFLogInViewController *)logInController shouldBeginLogInWithUsername:(NSString *)username password:(NSString *)password
{
    return YES;
}

/*! @name Responding to Actions */
/// Sent to the delegate when a PFUser is logged in.
- (void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user
{
    NSLog(@"didLogInUser");
}

/// Sent to the delegate when the log in attempt fails.
- (void)logInViewController:(PFLogInViewController *)logInController didFailToLogInWithError:(NSError *)error
{

}

/// Sent to the delegate when the log in screen is dismissed.
- (void)logInViewControllerDidCancelLogIn:(PFLogInViewController *)logInController
{

}


- (BOOL)signUpViewController:(PFSignUpViewController *)signUpController shouldBeginSignUp:(NSDictionary *)info
{
    return YES;
}

/// Sent to the delegate when a PFUser is signed up.
- (void)signUpViewController:(PFSignUpViewController *)signUpController didSignUpUser:(PFUser *)user
{
    // Enter code here to complete the user setup process
}

/// Sent to the delegate when the sign up attempt fails.
- (void)signUpViewController:(PFSignUpViewController *)signUpController didFailToSignUpWithError:(NSError *)error
{

}

/// Sent to the delegate when the sign up screen is dismissed.
- (void)signUpViewControllerDidCancelSignUp:(PFSignUpViewController *)signUpController
{

}

#pragma mark - TableView Delegate Methods

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.photoObjectsArray.count;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PostTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];

    PhotoWrapper *currentPhotoWrapperObject = [self.photoObjectsArray objectAtIndex:indexPath.section];

    Photo *currentParsePhotoObject = [currentPhotoWrapperObject performSelector:@selector(parsePhotoObject)];

    PFFile *imageFile = [currentParsePhotoObject objectForKey:@"image"];


    dispatch_queue_t bkgndQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(bkgndQueue,^{
        NSData *dataOfFile = [imageFile getData];
        if (dataOfFile) {
            dispatch_async(dispatch_get_main_queue(),^{
                cell.imageViewCustom.image = [UIImage imageWithData:dataOfFile];
                [cell setNeedsLayout];
            });
        }
    });

    cell.captionLabel.text = currentParsePhotoObject.caption;

    NSString *currentUserName = [PFUser currentUser].username;
    BOOL currentUserLikeThePhoto = NO;

    for (PFUser *eachUser in currentPhotoWrapperObject.likers) {
        NSString *eachUserName = eachUser.username;
        if ([eachUserName isEqualToString:currentUserName]) {
            currentUserLikeThePhoto = YES;
        }
    }

    if (currentUserLikeThePhoto)
    {
        [cell.likeButton setTitle:@"Liked" forState:UIControlStateNormal];
        [cell.likeButton setBackgroundColor:[UIColor grayColor]];
        [cell.likeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    else
    {
        [cell.likeButton setTitle:@"Like" forState:UIControlStateNormal];
        [cell.likeButton setBackgroundColor:[UIColor whiteColor]];
        [cell.likeButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    }

    cell.likeButton.tag = indexPath.section;
    cell.commentButton.tag = indexPath.section;

    return cell;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{

//    Photo *currentPhotoObject = [self.photoObjectsArray objectAtIndex:section];

    PhotoWrapper *currentPhotoWrapperObject = [self.photoObjectsArray objectAtIndex:section];
    Photo *currentParsePhotoObject = [currentPhotoWrapperObject performSelector:@selector(parsePhotoObject)];

    PFUser *photoOwner = currentParsePhotoObject.user;

    NSString *timeStampString = [self calculateTimeStampString:currentParsePhotoObject];

    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 200)];

    UIImage *profileImage = [UIImage imageNamed:@"1st.png"];
    UIImageView *profileImageView = [[UIImageView alloc] initWithFrame:CGRectMake(2, 5, 30, 30)];
    profileImageView.image = profileImage;

    UILabel *userNamelabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 5, tableView.frame.size.width, 40)];
    [userNamelabel setFont:[UIFont boldSystemFontOfSize:12]];
    userNamelabel.textColor = [UIColor blueColor];
    NSString *userNamestring = @"username goes here";
//    NSLog(@"userNamestring is %@", userNamestring);

    UILabel *timeStampLabel = [[UILabel alloc] initWithFrame:CGRectMake(290, 5, tableView.frame.size.width, 40)];
    [timeStampLabel setFont:[UIFont systemFontOfSize:12]];
    timeStampLabel.textColor = [UIColor grayColor];

    [timeStampLabel setText:timeStampString];
    [userNamelabel setText:userNamestring];

    [view addSubview:userNamelabel];
    [view addSubview:timeStampLabel];
    [view addSubview:profileImageView];

    [view setBackgroundColor:[UIColor whiteColor]];

    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}


#pragma mark - helper calculation methods

- (NSString *) calculateTimeStampString:(Photo *)currentPhotoObject
{
    NSDate *createdAt = currentPhotoObject.createdAt;
    NSString *timeStampString  = @"";

    NSDate* date1 = [NSDate date];
    NSDate* date2 = createdAt;
    NSTimeInterval distanceBetweenDates = [date1 timeIntervalSinceDate:date2];
    double secondsInAnHour = 3600;
    NSInteger hoursBetweenDates = distanceBetweenDates / secondsInAnHour;
    timeStampString = [NSString stringWithFormat:@"%lih",(long)hoursBetweenDates];

    double daysBetweenDates = floor(hoursBetweenDates/24);

    if (daysBetweenDates>0.0) {
        timeStampString = [NSString stringWithFormat:@"%.0fd",daysBetweenDates];
    }

    double weeksBetweenDates = floor(daysBetweenDates/7);

    if (weeksBetweenDates>0.0) {
        timeStampString = [NSString stringWithFormat:@"%.0fw",weeksBetweenDates];
    }

    return timeStampString;
}

- (IBAction)likeButtonTapped:(UIButton *)sender
{
//    Photo *selectedPhotoObject = [self.photoObjectsArray objectAtIndex:sender.tag];

    PhotoWrapper *currentPhotoWrapperObject = [self.photoObjectsArray objectAtIndex:sender.tag];

    Photo *currentParsePhotoObject = [currentPhotoWrapperObject performSelector:@selector(parsePhotoObject)];

    self.isLiked =! self.isLiked;

    if (self.isLiked)
    {
        [sender setTitle:@"Liked" forState:UIControlStateNormal];
        [sender setBackgroundColor:[UIColor grayColor]];
        [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.modelManager postNewLikeOnPhoto:currentParsePhotoObject byUser:[PFUser currentUser]];
    }
    else
    {
        [sender setTitle:@"Like" forState:UIControlStateNormal];
        [sender setBackgroundColor:[UIColor whiteColor]];
        [sender setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [self.modelManager removeLikeOnPhoto:currentParsePhotoObject byUser:[PFUser currentUser]];
    }

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(UIButton *)sender
{
    if ([segue.identifier isEqualToString:@"CommentSegue"])
    {
        PhotoWrapper *currentPhotoWrapperObject = [self.photoObjectsArray objectAtIndex:sender.tag];

        Photo *selectedPhotoObject = [currentPhotoWrapperObject performSelector:@selector(parsePhotoObject)];

        CommentViewController *destinationVC = segue.destinationViewController;
        destinationVC.photoObjectToBeCommentedOn = selectedPhotoObject;
    }
}

@end
