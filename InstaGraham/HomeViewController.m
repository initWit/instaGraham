//
//  HomeViewController.m
//  InstaGraham
//
//  Created by Robert Figueras and Dennis Dixon on 6/9/14.
//
//

#import "HomeViewController.h"
#import <Parse/Parse.h>


@interface HomeViewController () <PFSignUpViewControllerDelegate,PFLogInViewControllerDelegate>

@property (strong,nonatomic) PFLogInViewController *logInViewController;
@property (strong,nonatomic) PFSignUpViewController *signUpViewController;

@end


@implementation HomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
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


@end
