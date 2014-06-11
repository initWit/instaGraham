//
//  InstaGrahamModelManager.m
//  InstaGraham
//
//  Created by Dennis Dixon on 6/10/14.
//
//

#import "InstaGrahamModelManager.h"
#import "Photo.h"
#import "Comment.h"

@interface InstaGrahamModelManager ()

@property (strong, nonatomic) NSArray *pulledPhotoSet;

@end


@implementation InstaGrahamModelManager

//+ (id)sharedManager
//{
//    static InstaGrahamModelManager *sharedManager;
//    if (!sharedManager)
//    {
//        sharedManager = [[self alloc] initPrivate];
//    }
//    return sharedManager;
//}
//
//- (id)initPrivate
//{
//    self = [super init];
//    if (self)
//    {
//        // placeholder for any necessary property instantiations and initialization code
//    }
//    return self;
//}
//
//
//- (id)init
//{
//
//    [NSException raise:@"InstaGrahamModelManager is a Singleton."  format:@"Use [InstaGrahamModelManager sharedManager] to obtain a reference."];
//    return nil;
//}


- (void)getPhotoSetOnUser:(PFUser *)user includingFollowings:(BOOL)includingFollowings completion:(void (^)(NSArray *photoSet))completion
{
    if (completion)
    {
        PFQuery *photosQuery = [PFQuery queryWithClassName:@"Photo"];
//        [query whereKey:@"user" equalTo:username];
        [photosQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            completion(objects);
        }];
    }
}


- (void)getFollowSetOnUser:(PFUser *)user completion:(void (^)(NSArray *followSet))completion
{

}


- (void)getFollowerSetOnUser:(PFUser *)user completion:(void (^)(NSArray *followerSet))completion
{

}


- (void)editInfoForUser:(PFUser *)user;
{

}


- (void)removePhoto:(Photo *)photo;
{

}


- (void)postNewComment:(NSString *)comment onPhoto:(Photo *)photo byUser:(PFUser *)user
{

}


- (void)postNewLikeOnPhoto:(Photo *)photo byUser:(PFUser *)user
{

}


- (void)removeLikeOnPhoto:(Photo *)photo byUser:(PFUser *)user
{

}


- (void)addNewFollowerToUser:(PFUser *)followedUser fromUser:(PFUser *)followingUser
{

}


- (void)removeNewFollowerToUser:(PFUser *)formerFollowedUser fromUser:(PFUser *)formerFollowingUser
{

}




@end
