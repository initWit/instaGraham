//
//  Comment.m
//  InstaGraham
//
//  Created by Dennis Dixon on 6/10/14.
//
//

#import "Comment.h"

@implementation Comment

@synthesize commentText = _commentText;

+ (NSString *)parseClassName
{
    return @"Comment";
}


+ (instancetype)object
{
    return nil;
}


+ (instancetype)objectWithoutDataWithObjectId:(NSString *)objectId
{
    return nil;
}


+ (PFQuery *)query;
{
    return nil;
}


+ (void)registerSubclass;
{

}

@end
