//
//  AppDelegate.m
//  InstaGraham
//
//  Created by Robert Figueras and Dennis Dixon on 6/9/14.
//
//

#import "AppDelegate.h"
#import <Parse/Parse.h>
#import "Photo.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{

    [Photo registerSubclass];

// ROBERT'S PARSE ACCOUNT KEYS
//    [Parse setApplicationId:@"SJRRG39nyKcziy6A6oXb7puOtbWWDZfn5msM8JjN"
//                  clientKey:@"cynLrCjpyPkBi8sUxH3UuqnwiaZyOziz6frGgO4f"];

// INSTACLONE PARSE KEYS
    [Parse setApplicationId:@"iXbFVoUSFxuo7CL3lU9v4X1h70oPQ0o51g07X6y1"
                  clientKey:@"gtp2kNwZYjvIuSJbjX0m9idYqE95csUOim1C45Q8"];

    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
