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
//@synthesize comments = _comments;

+(NSString *)parseClassName
{
    return @"Photo";
}

@end
