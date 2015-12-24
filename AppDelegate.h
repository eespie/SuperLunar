//
//  AppDelegate.h
//  Super Lunaire
//
//  Created by Eric Espié on mardi 4 août 2015
//  Copyright (c) Eric Espié. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FullScreeniAdAddOn.h"

@class StandaloneCodeaViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) StandaloneCodeaViewController *viewController;

@property (strong, nonatomic) FullScreeniAdAddOn *fullScreenAd;

@end
