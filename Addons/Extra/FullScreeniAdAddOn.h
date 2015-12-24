//
//  FullScreeniAdAddOn.h
//  FullScreeniAdTest
//
//  Created by Nathan Flurry on 8/20/14.
//  Copyright (c) 2014 MyCompany. All rights reserved.
//

#import "CodeaAddon.h"
#import "FullScreeniAdViewController.h"
#import <Foundation/Foundation.h>
#import <iAd/iAd.h>

id FullScreeniAdAddOnInstance;
ADInterstitialAd *interstitial;

@interface FullScreeniAdAddOn : NSObject<CodeaAddon, ADInterstitialAdDelegate>
{
}

@property (weak, nonatomic) StandaloneCodeaViewController *codeaViewController;

@property FullScreeniAdViewController *adVC;

static int showAd(struct lua_State *state);
static int closeAd(struct lua_State *state);

- (void) cycleInterstitial;

@end