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


@interface HomeViewController () <PFSignUpViewControllerDelegate,PFLogInViewControllerDelegate, UITableViewDataSource, UITableViewDelegate>

@property (strong,nonatomic) PFLogInViewController *logInViewController;
@property (strong,nonatomic) PFSignUpViewController *signUpViewController;
@property (strong, nonatomic) IBOutlet UITableView *photoStreamTableView;
@property InstaGrahamModelManager *modelManager;
@property NSArray *photoObjectsArray;

@end


@implementation HomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.photoObjectsArray = [[NSArray alloc] init];
    self.modelManager = [[InstaGrahamModelManager alloc] init];

//    self.modelManager.delegate = self;
//    [self.modelManager getPhotoSetOnUser:[PFUser currentUser] includingFollowings:YES];

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

    [self.modelManager getPhotoSetOnUser:[PFUser currentUser] includingFollowings:YES completion:^(NSArray *photoSet) {
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

    Photo *currentPhotoObject = [self.photoObjectsArray objectAtIndex:indexPath.section];
    PFFile *imageFile = [currentPhotoObject objectForKey:@"image"];

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

    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"SECTION HEADER";
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 200)];

    UIImage *profileImage = [UIImage imageNamed:@"1st.png"];
    UIImageView *profileImageView = [[UIImageView alloc] initWithFrame:CGRectMake(2, 5, 30, 30)];
    profileImageView.image = profileImage;

    UILabel *userNamelabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 5, tableView.frame.size.width, 40)];
    [userNamelabel setFont:[UIFont boldSystemFontOfSize:12]];
    userNamelabel.textColor = [UIColor blueColor];
    NSString *userNamestring = @"SECTION HEADER";

    UILabel *timeStampLabel = [[UILabel alloc] initWithFrame:CGRectMake(290, 5, tableView.frame.size.width, 40)];
    [timeStampLabel setFont:[UIFont systemFontOfSize:12]];
    timeStampLabel.textColor = [UIColor grayColor];
    NSString *timeStampString = @"3h";

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


@end
