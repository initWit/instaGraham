//
//  InstaGrahamModelManager.m
//  InstaGraham
//
//  Created by Dennis Dixon on 6/10/14.
//
//

#import "InstaGrahamModelManager.h"

@implementation InstaGrahamModelManager

@synthesize delegate = _delegate;

- (void)getPhotoSetOnUser:(PFUser *)username includingFollowings:(BOOL)includingFollowings completion:(void (^)(NSArray *photoSet))completion
{
    if (completion)
    {
        completion(@[@"this",@"is",@"a",@"test"]);
    }
}


- (void)getPhotoSetOnUser:(PFUser *)username includingFollowings:(BOOL)includingFollowings
{
    [self.delegate modelManager:self didPullPhotoSet:@[@"this",@"is",@"a",@"test"]];
}

@end
