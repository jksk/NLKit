//
//  AppDelegate.h
//  NLKit
//
//  Created by Jesper Skrufve on 6/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class
ViewController;

#pragma mark -
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow*					window;
@property (strong, nonatomic) UINavigationController*	navController;
@property (strong, nonatomic) ViewController*			rootViewController;

@end
