//
//  Comment.h
//  InstaGraham
//
//  Created by Dennis Dixon on 6/10/14.
//
//

#import <Parse/Parse.h>

@interface Comment : PFObject <PFSubclassing>

@property (strong, nonatomic) NSString *commentText;
//@property (strong, nonatomic) ~~what type would a Parse pointer be???~~ *user;

+ (NSString *)parseClassName;

+ (instancetype)object;

/*!
 Creates a reference to an existing PFObject for use in creating associations between PFObjects.  Calling isDataAvailable on this
 object will return NO until fetchIfNeeded or refresh has been called.  No network request will be made.
 A default implementation is provided by PFObject which should always be sufficient.
 @param objectId The object id for the referenced object.
 @result A PFObject without data.
 */
+ (instancetype)objectWithoutDataWithObjectId:(NSString *)objectId;

/*!
 Create a query which returns objects of this type.
 A default implementation is provided by PFObject which should always be sufficient.
 */
+ (PFQuery *)query;

/*!
 Lets Parse know this class should be used to instantiate all objects with class type parseClassName.
 This method must be called before [Parse setApplicationId:clientKey:]
 */
+ (void)registerSubclass;
@end
