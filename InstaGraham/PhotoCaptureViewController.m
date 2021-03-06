//
//  PhotoCaptureViewController.m
//  InstaGraham
//
//  Created by Robert Figueras on 6/10/14.
//
//

#import "PhotoCaptureViewController.h"
#import "InstaGrahamModelManager.h"
#import "Photo.h"

@interface PhotoCaptureViewController () <UINavigationControllerDelegate,UIImagePickerControllerDelegate, UITextViewDelegate>
@property UIImagePickerController *imagePicker;
@property (strong, nonatomic) IBOutlet UIImageView *photoPreviewImageView;
@property (strong, nonatomic) IBOutlet UITextView *captionTextView;
@property (strong, nonatomic) IBOutlet UIButton *shareButton;
@property InstaGrahamModelManager *modelManager;
@property Photo *photoObjectToPost;
@end

@implementation PhotoCaptureViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.photoObjectToPost = [Photo objectWithClassName:@"Photo"];
    self.modelManager = [[InstaGrahamModelManager alloc]init];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self showImagePicker];
    if (!self.photoPreviewImageView.image) {
        [self.shareButton setEnabled:NO];
    }
}


#pragma mark - ImagePicker methods

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    self.photoPreviewImageView.image = [info objectForKey:UIImagePickerControllerOriginalImage];
    NSData *imageData = UIImageJPEGRepresentation(self.photoPreviewImageView.image, 0.0);
    PFFile *capturedImage = [PFFile fileWithData:imageData];

    self.photoObjectToPost.image = capturedImage;


    if (self.imagePicker.sourceType == UIImagePickerControllerSourceTypeCamera){
        UIImageWriteToSavedPhotosAlbum(self.photoPreviewImageView.image, nil, nil, nil);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.shareButton setEnabled:YES];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) showImagePicker
{
    self.imagePicker = [[UIImagePickerController alloc]init];
    self.imagePicker.delegate = self;
    self.imagePicker.allowsEditing = YES;
//    self.imagePicker.videoMaximumDuration = 10; // *** limit the lenghth of the videos (10 sec)

    // *** check to see if a camera source is available; if not, show the photo library instead ***/

    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        self.imagePicker.mediaTypes =[UIImagePickerController availableMediaTypesForSourceType:self.imagePicker.sourceType];
    }
    else
    {
        self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        self.imagePicker.mediaTypes =[UIImagePickerController availableMediaTypesForSourceType:self.imagePicker.sourceType];
    }

    [self presentViewController:self.imagePicker animated:NO completion:nil];
}

#pragma mark - TextView delegate methods

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    self.captionTextView.text = @"";
    self.captionTextView.textColor = [UIColor blackColor];
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    if (self.captionTextView.text.length == 0) {
        self.captionTextView.text = @"Write a caption...";
        self.captionTextView.textColor = [UIColor lightGrayColor];
    }
}

#pragma mark - helper methods

- (IBAction)shareButtonTapped:(id)sender
{
    [self.captionTextView resignFirstResponder];
    self.photoObjectToPost.caption = self.captionTextView.text;
    [self.modelManager postNewPhoto:self.photoObjectToPost byUser:[PFUser currentUser]];

}

- (IBAction)tappedBackgroundView:(id)sender
{
    [self.captionTextView resignFirstResponder];
}

- (IBAction)imageViewTapped:(id)sender
{
    [self showImagePicker];
}



@end
