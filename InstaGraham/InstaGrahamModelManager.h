//
//  InstaGrahamModelManager.h
//  InstaGraham
//
//  Created by Dennis Dixon on 6/10/14.
//
//

#import <Parse/Parse.h>

@class InstaGrahamModelManager;

@protocol InstaGrahamModelManagerDelegate

- (void)modelManager:(InstaGrahamModelManager *)modelManager didPullPhotoSet:(NSArray *)photoSet;

@end

@interface InstaGrahamModelManager : PFObject

@property (strong, nonatomic) id<InstaGrahamModelManagerDelegate> delegate;

- (void)getPhotoSetOnUser:(PFUser *)username includingFollowings:(BOOL)includingFollowings completion:(void (^)(NSArray *photoSet))completion;

- (void)getPhotoSetOnUser:(PFUser *)username includingFollowings:(BOOL)includingFollowings;


@end
