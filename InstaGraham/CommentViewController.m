//
//  CommentViewController.m
//  InstaGraham
//
//  Created by Robert Figueras on 6/10/14.
//
//

#import "CommentViewController.h"
#import "InstaGrahamModelManager.h"
#import <Parse/Parse.h>

@interface CommentViewController () <UITextViewDelegate>
@property (strong, nonatomic) IBOutlet UITextView *commentTextView;
@property InstaGrahamModelManager *modelManager;

@end

@implementation CommentViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.commentTextView becomeFirstResponder];
}

#pragma mark - TextView delegate methods

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    self.commentTextView.text = @"";
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    if (self.commentTextView.text.length == 0) {
        self.commentTextView.text = @"Add a caption...";
    }
}


#pragma mark - helper methods

- (IBAction)sendButtonTapped:(id)sender
{
    [self.commentTextView resignFirstResponder];
    [self.modelManager postNewComment:self.commentTextView.text onPhoto:self.photoObjectToBeCommentedOn byUser:[PFUser currentUser]];

}

- (IBAction)tappedBackgroundView:(id)sender
{
    [self.commentTextView resignFirstResponder];
}



@end
