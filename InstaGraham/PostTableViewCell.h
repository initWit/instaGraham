//
//  PostTableViewCell.h
//  InstaGraham
//
//  Created by Dennis Dixonand Robert Figueras on 6/10/14.
//
//

#import <UIKit/UIKit.h>

@interface PostTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *imageViewCustom;
@property (strong, nonatomic) IBOutlet UIButton *likeButton;
@property (strong, nonatomic) IBOutlet UIButton *commentButton;
@property (strong, nonatomic) IBOutlet UILabel *captionLabel;
@end
