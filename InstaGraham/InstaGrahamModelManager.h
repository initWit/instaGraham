//
//  InstaGrahamModelManager.h
//  InstaGraham
//
//  Created by Dennis Dixon on 6/10/14.
//
//

#import <Parse/Parse.h>
#import "Photo.h"
@class InstaGrahamModelManager;


@protocol InstaGrahamModelManagerDelegate


@end


@interface InstaGrahamModelManager : NSObject

//+ (id)sharedManager;

- (void)getPhotoSetOnUser:(PFUser *)user includingFollowings:(BOOL)includingFollowings completion:(void (^)(NSArray *photoSet))completion;
- (void)getFollowSetOnUser:(PFUser *)user completion:(void (^)(NSArray *followSet))completion;
- (void)getFollowerSetOnUser:(PFUser *)user completion:(void (^)(NSArray *followerSet))completion;
- (void)editInfoForUser:(PFUser *)user;
- (void)removePhoto:(Photo *)photo;
- (void)postNewComment:(NSString *)comment onPhoto:(Photo *)photo byUser:(PFUser *)user;
- (void)postNewLikeOnPhoto:(Photo *)photo byUser:(PFUser *)user;
- (void)removeLikeOnPhoto:(Photo *)photo byUser:(PFUser *)user;
- (void)addNewFollowerToUser:(PFUser *)followedUser fromUser:(PFUser *)followingUser;
- (void)removeNewFollowerToUser:(PFUser *)formerFollowedUser fromUser:(PFUser *)formerFollowingUser;

@end
