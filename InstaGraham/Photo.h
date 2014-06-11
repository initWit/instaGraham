//
//  Photo.h
//  InstaGraham
//
//  Created by Robert Figueras on 6/10/14.
//
//

#import <Parse/Parse.h>

@interface Photo : PFObject <PFSubclassing>

@property (strong, nonatomic) PFFile *image;
@property (strong, nonatomic) NSArray *likers;
@property (strong, nonatomic) NSArray *comments;
@property (strong, nonatomic) PFUser *user;
@property (strong, nonatomic) NSDate *createdAt;
@property (strong, nonatomic) NSString *caption;

+ (NSString *)parseClassName;

@end
