//
//  PhotoWrapper.h
//  InstaGraham
//
//  Created by Dennis Dixon on 6/11/14.
//
//

#import <Foundation/Foundation.h>
#import "Photo.h"


@interface PhotoWrapper : NSObject

@property (strong, nonatomic) NSArray *comments;
@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) NSArray *likers;
@property (strong, nonatomic) NSString *username;
@property (strong, nonatomic) NSDate *createdAt;
@property (strong, nonatomic) NSString *caption;
@property (strong, nonatomic) Photo *parsePhotoObject;

- (id)initWithParsePhotoObject:(Photo *)parsePhotoObject;

@end
