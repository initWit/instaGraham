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
#import "PhotoWrapper.h"


@interface InstaGrahamModelManager ()

@property (strong, nonatomic) NSArray *pulledPhotoSet;

@end


@implementation InstaGrahamModelManager

//+ (id)sharedManager
//{
//    static InstaGrahamModelManager *sharedManager;
//    static dispatch_once_t *onceToken;
//    if (!sharedManager)
//    {
//        dispatch_once(&onceToken, ^{
//            sharedManager = [[self alloc] initPrivate];
//        });
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


#pragma mark - PhotoSet Related Methods

- (void)getPhotoSetOnUser:(PFUser *)user includingFollowings:(BOOL)includingFollowings completion:(void (^)(NSArray *photoSet))completion
{
    if (completion)
    {
        PFQuery *photosQuery = [PFQuery queryWithClassName:@"Photo"];
//        [query whereKey:@"user" equalTo:user];
        [photosQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            NSMutableArray *photoWrappers = [[NSMutableArray alloc] init];
            NSInteger numberOfPhotos = objects.count;
            for (Photo *curPhoto in objects)
            {
                PFRelation *commentsRelation = [curPhoto relationForKey:@"comments"];
                PFQuery *commentsQuery = [commentsRelation query];
                PhotoWrapper *curPhotoWrapper = [[PhotoWrapper alloc] initWithParsePhotoObject:curPhoto];
                [commentsQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                    curPhotoWrapper.comments = objects;
//                    NSLog(@"photo: %@ - comments: %@", curPhoto, objects);
                    PFRelation *likersRelation = [curPhoto relationForKey:@"likers"];
                    PFQuery *likersQuery = [likersRelation query];

//                    [likersQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//                        curPhotoWrapper.likers = objects;
                        [photoWrappers addObject:curPhotoWrapper];
                        if (photoWrappers.count == numberOfPhotos)
                        {
                            NSArray *immutablePhotoWrappersArray = [NSArray arrayWithArray:photoWrappers];
                            completion(immutablePhotoWrappersArray);
                        }
//                    }];
                }];
            }
        }];
    }
}


- (void)getPhotoSetOfLikesOfUser:(PFUser *)user completion:(void (^)(NSArray *photoSet, NSError *error))completion
{

}


- (void)postNewPhoto:(Photo *)photo byUser:(PFUser *)user;
{

}


- (void)removePhoto:(Photo *)photo;
{

}


#pragma mark - User & Following Related Methods

- (void)getFollowSetOnUser:(PFUser *)user completion:(void (^)(NSArray *followSet))completion
{

}


- (void)getFollowerSetOnUser:(PFUser *)user completion:(void (^)(NSArray *followerSet))completion
{

}


- (void)editInfoForUser:(PFUser *)user;
{

}


#pragma mark - Comment and Like Related Methods

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

//- (void)getPhotoSetOnUser:(PFUser *)user includingFollowings:(BOOL)includingFollowings completion:(void (^)(NSArray *photoSet, NSError *error))completion
//{
//
//}
//
//
//- (void)getFollowSetOnUser:(PFUser *)user completion:(void (^)(NSArray *followSet, NSError *error))completion;
//{
//
//}
//
//
//- (void)getFollowerSetOnUser:(PFUser *)user completion:(void (^)(NSArray *followerSet, NSError *error))completion;
//{
//
//}
//
//



@end
