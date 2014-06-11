//
//  PhotoWrapper.m
//  InstaGraham
//
//  Created by Dennis Dixon on 6/11/14.
//
//

#import "PhotoWrapper.h"
#import "Photo.h"

@interface PhotoWrapper ()

@property (strong, nonatomic) Photo *parsePhotoObject;

@end


@implementation PhotoWrapper

- (id)init
{
    return [self initWithParsePhotoObject:nil];
}

- (id)initWithParsePhotoObject:(Photo *)parsePhotoObject;
{
    self = [super init];
    if (self)
    {
        self.parsePhotoObject = parsePhotoObject;
    }
    return self;
}


@end
