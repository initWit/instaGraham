//
//  InstaGrahamTests.m
//  InstaGrahamTests
//
//  Created by Robert Figueras on 6/9/14.
//  Modified with InstaGraham model testing
//

#import <XCTest/XCTest.h>
#import <Parse/Parse.h>
#import "InstaGrahamModelManager.h"
#import "PhotoWrapper.h"

@interface InstaGrahamTests : XCTestCase

@end

@implementation InstaGrahamTests

+ (void)initialize {
    [Parse setApplicationId:@"iXbFVoUSFxuo7CL3lU9v4X1h70oPQ0o51g07X6y1"
                  clientKey:@"gtp2kNwZYjvIuSJbjX0m9idYqE95csUOim1C45Q8"];
}

- (void)testModel
{
    NSLog(@"in testModel (beginning)");
    __block BOOL done = NO;

    InstaGrahamModelManager *iGModelManager = [[InstaGrahamModelManager alloc] init];
    __block PFUser *chuckNorrisUser = nil;
    [PFUser logInWithUsernameInBackground:@"Chuck" password:@"Norris" block:^(PFUser *user, NSError *error) {
        chuckNorrisUser = user;

        [iGModelManager getPhotoSetOnUser:user includingFollowings:YES completion:^(NSArray *photoSet) {
            NSLog(@"in completion block of getPhotoSetOnUser in XCTest photoSet contains: %@",photoSet);
//            for (Photo *curPhoto in photoSet)
//            {
//                NSLog(@"user: %@ - photo: %@ - comments: %@", user, curPhoto, [curPhoto objectForKey:@"comments"]);
//            }
            for (PhotoWrapper *curPhoto in photoSet)
            {
                if ([curPhoto.comments count] > 0)
                {
                    NSLog(@"Photo: %@\n\n\n...has these comments:\n%@\n\n\n...has these likers:\n%@",curPhoto,curPhoto.comments,curPhoto.likers);
                }
            }
            done = YES;
        }];

    }];

    NSLog(@"in testModel after and outside login and getPhotoSet completion blocks in XCTest");

    while (!done) {
        [[NSRunLoop mainRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:2]];
    }

    XCTAssertEqualObjects(@"Chuck", [chuckNorrisUser objectForKey:@"username"]);

//    XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
}

@end
