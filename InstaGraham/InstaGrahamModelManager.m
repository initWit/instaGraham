//
//  InstaGrahamModelManager.m
//  InstaGraham
//
//  Created by Dennis Dixon on 6/10/14.
//
//

#import "InstaGrahamModelManager.h"


@interface InstaGrahamModelManager ()

@property (strong, nonatomic) NSArray *pulledPhotoSet;

@end


@implementation InstaGrahamModelManager

@synthesize delegate = _delegate;

-(id)init
{
    self = [super init];
    if (self)
    {
        
    }
    return self;
}


- (void)getPhotoSetOnUser:(PFUser *)user includingFollowings:(BOOL)includingFollowings completion:(void (^)(NSArray *photoSet))completion
{
    if (completion)
    {
        PFQuery *query = [PFQuery queryWithClassName:@"Photo"];
//        [query whereKey:@"user" equalTo:username];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            completion(objects);
        }];
    }
}


- (void)getPhotoSetOnUser:(PFUser *)user includingFollowings:(BOOL)includingFollowings
{
//    [self.delegate modelManager:self didPullPhotoSet:@[@"this",@"is",@"a",@"test"]];

    PFQuery *query = [PFQuery queryWithClassName:@"Photo"];
    [query whereKey:@"user" equalTo:user];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        [self.delegate modelManager:self didPullPhotoSet:objects];
    }];
}

@end
