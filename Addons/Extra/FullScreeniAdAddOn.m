//
//  FullScreeniAdAddOn.m
//  FullScreeniAdTest
//
//  Created by Nathan Flurry on 8/20/14.
//  Copyright (c) 2014 MyCompany. All rights reserved.
//

#import "lua.h"
#import "FullScreeniAdAddOn.h"


@implementation FullScreeniAdAddOn

#pragma mark - Initialisation

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        FullScreeniAdAddOnInstance = self;
        interstitial = [[ADInterstitialAd alloc] init];
        interstitial.delegate = self;
        self.adVC = nil;
    }
    return self;
}

#pragma mark - CodeaAddon Delegate

- (void) codea:(StandaloneCodeaViewController*)controller didCreateLuaState:(struct lua_State*)L
{
    //NSLog(@"FullScreeniAdAddOn Registering Functions");
    
    lua_register(L, "showAd", showAd); // Shows ad in view controller's view, calls cycle ad automatically
    lua_register(L, "canShowAd", canShowAd); // true if an AD is available to show
    lua_register(L, "initAd", initAd); // true if an AD is available to show
    lua_register(L, "closeAd", closeAd); // Dismisses the ad, will not pay you (as much) money as a full ad
    lua_register(L, "getLang", getLang); // Get the current language

    self.codeaViewController = controller;
}

#pragma mark - Show App

static int initAd (struct lua_State *state) {
    //NSLog(@"FullScreeniAdAddOn initAd");
    [FullScreeniAdAddOnInstance initAdAction];
    return 0;
}

static int showAd (struct lua_State *state) {
    //NSLog(@"FullScreeniAdAddOn showAd");
    [FullScreeniAdAddOnInstance showAdAction];
    return 0;
}

- (void)initAdAction {
    if (!interstitial.isLoaded) {
        [self cycleInterstitial];
    }
}

- (void)showAdAction {
    if (interstitial.isLoaded) {
        //NSLog(@"FullScreeniAdAddOn showAdAction");
        self.adVC = [FullScreeniAdViewController new];
        [self.codeaViewController presentViewController:self.adVC animated:YES completion:nil];
    }
}

static int canShowAd (struct lua_State *state) {
    //NSLog(@"FullScreeniAdAddOn canShowAd");
    lua_pushboolean(state, interstitial.isLoaded);
    return 0;
}

static int getLang (struct lua_State *state) {
    //NSString *language = [[[NSBundle mainBundle] preferredLocalizations] objectAtIndex:0];
    NSString *language = [[NSBundle mainBundle] preferredLocalizations].firstObject;
    //NSString * language = [[NSLocale preferredLanguages] objectAtIndex:0];
    lua_pushfstring(state, [language cStringUsingEncoding:NSUTF8StringEncoding]);
    return 1;
}

static int closeAd (struct lua_State *state) {
    [FullScreeniAdAddOnInstance closeAdAction];
    return 0;
}

- (void) closeAdAction {
    [self.adVC dismissViewControllerAnimated:YES completion:nil];
}

- (void) cycleInterstitial
{
    //NSLog(@"FullScreeniAdViewController cycleInterstitial");
    self.adVC = nil;
    // Clean up the old interstitial...
    interstitial.delegate = nil;
    //[interstitial release];
    // and create a new interstitial. We set the delegate so that we can be notified of when
    interstitial = [[ADInterstitialAd alloc] init];
    interstitial.delegate = FullScreeniAdAddOnInstance;
}


#pragma mark ADInterstitialViewDelegate methods

// When this method is invoked, the application should remove the view from the screen and tear it down.
// The content will be unloaded shortly after this method is called and no new content will be loaded in that view.
// This may occur either when the user dismisses the interstitial view via the dismiss button or
// if the content in the view has expired.

- (void)interstitialAdDidUnload:(ADInterstitialAd *)interstitialAd
{
    //NSLog(@"FullScreeniAdViewController interstitialAdDidUnload");
    if (nil == self.adVC) {
        //[self cycleInterstitial];
    } else {
        [self.adVC dismissViewControllerAnimated:YES completion:nil];
    }
}

// This method will be invoked when an error has occurred attempting to get advertisement content.
// The ADError enum lists the possible error codes.

- (void)interstitialAd:(ADInterstitialAd *)interstitialAd didFailWithError:(NSError *)error
{
    //NSLog(@"FullScreeniAdViewController didFailWithError");
    if (nil == self.adVC) {
        //[self cycleInterstitial];
    } else {
        [self.adVC dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)interstitialAdActionDidFinish:(ADInterstitialAd *)interstitialAd
{
    //NSLog(@"FullScreeniAdViewController interstitialAdActionDidFinish");
    if (nil == self.adVC) {
        //[self cycleInterstitial];
    } else {
        [self.adVC dismissViewControllerAnimated:YES completion:nil];
    }
}


@end