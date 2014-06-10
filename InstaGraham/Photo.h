//
//  Photo.h
//  InstaGraham
//
//  Created by Robert Figueras on 6/10/14.
//
//

#import <Parse/Parse.h>

@interface Photo : PFObject <PFSubclassing>

+(id)parseClassName;
@property PFFile *image;

@end
