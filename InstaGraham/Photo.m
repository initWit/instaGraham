//
//  Photo.m
//  InstaGraham
//
//  Created by Robert Figueras on 6/10/14.
//
//

#import "Photo.h"


@implementation Photo

@dynamic image;
@dynamic likers;
@dynamic createdAt;
@dynamic caption;
@dynamic user;
@synthesize comments = _comments;


+(NSString *)parseClassName
{
    return @"Photo";
}


- (NSArray *)comments
{
    if (!_comments)
    {
        _comments = [[NSArray alloc] init];
    }
    return _comments;
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
