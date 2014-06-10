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
// #import "InstaGrahamModelManager.h"


@interface HomeViewController () <PFSignUpViewControllerDelegate,PFLogInViewControllerDelegate, UITableViewDataSource, UITableViewDelegate>

@property (strong,nonatomic) PFLogInViewController *logInViewController;
@property (strong,nonatomic) PFSignUpViewController *signUpViewController;
@property (strong, nonatomic) IBOutlet UITableView *photoStreamTableView;
//@property InstaGrahamModelManager *modelManager;
@property NSArray *photoObjectsArray;

@end


@implementation HomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];


    self.photoObjectsArray = [[NSArray alloc] init];

    // self.modelManager = [InstaGrahamModelManager alloc] init];
    // [self.modelManager getPhotoSetOnUser:[PFUser currentUser] includingFollings:YES];

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

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.photoObjectsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];

    Photo *currentPhotoObject = [self.photoObjectsArray objectAtIndex:indexPath.row];

//    cell.textLabel.text = currentPhotoObject.username;
//    cell.imageView.image = currentPhotoObject.image;

    return cell;
}


#pragma mark - InstaGrahamModelManager delegate method

// Completion Block
//- (void)getPhotoSetOnUser:(PFUser *)username includingFollowings:(BOOL)includingFollowings completion:(void (^)(NSArray *photoSet))completion;

// Delegate Method
//- (void) modelManager (InstaGrahamModelManager *)modelManager didPullPhotoSets:(NSArray *)photoSet
//{
//    // self.photoObjectsArray = photoSet;
//}


@end
