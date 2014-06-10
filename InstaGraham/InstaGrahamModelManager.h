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

@interface InstaGrahamModelManager : NSObject

@property (strong, nonatomic) id<InstaGrahamModelManagerDelegate> delegate;

- (void)getPhotoSetOnUser:(PFUser *)user includingFollowings:(BOOL)includingFollowings completion:(void (^)(NSArray *photoSet))completion;

- (void)getPhotoSetOnUser:(PFUser *)user includingFollowings:(BOOL)includingFollowings;


@end
