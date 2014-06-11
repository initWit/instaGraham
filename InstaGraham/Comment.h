//
//  Comment.h
//  InstaGraham
//
//  Created by Dennis Dixon on 6/10/14.
//
//

#import <Parse/Parse.h>

@interface Comment : PFObject <PFSubclassing>

@property (strong, nonatomic) NSString *commentText;

+ (id)parseClassName;

@end
