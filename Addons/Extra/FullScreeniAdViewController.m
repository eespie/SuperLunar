//
//  FullScreeniAdViewController.m
//  FullScreeniAdTest
//
//  Created by Nathan Flurry on 8/20/14.
//  Copyright (c) 2014 MyCompany. All rights reserved.
//

#import "FullScreeniAdAddOn.h"

@interface FullScreeniAdViewController ()

@end

@implementation FullScreeniAdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //NSLog(@"FullScreeniAdViewController viewDidLoad");
    self.isClosing = FALSE;

    self.view.backgroundColor = [UIColor clearColor];
    
    self.adView = [[UIView alloc] initWithFrame:self.view.bounds];
    [interstitial presentInView:self.adView];
    //self.adView.layer.zPosition = -10;

    self.closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.closeButton setCenter:CGPointMake(18.f, 18.f)];

    //self.closeButton = [UIButton new];
    [self.closeButton setTitle:@"X" forState:UIControlStateNormal];
    self.closeButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:20];
    self.closeButton.frame = CGRectMake(20, 20, 36, 36);

    self.closeButton.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.2];
    self.closeButton.layer.cornerRadius = self.closeButton.frame.size.width/2;

    [self.closeButton setBackgroundImage:[UIImage imageNamed:@"close.png"] forState:UIControlStateNormal];
    [self.closeButton addTarget:self action:@selector(closeButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.closeButton addTarget:self action:@selector(closeButtonDown) forControlEvents:UIControlEventTouchDown];
    [self.closeButton addTarget:self action:@selector(closeButtonOut) forControlEvents:UIControlEventTouchUpOutside];
    [self.view addSubview:self.adView];
    //[self.view addSubview:self.closeButton];
}

- (void)closeButtonTapped {
    //NSLog(@"FullScreeniAdViewController closeButtonTapped");
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)closeButtonDown {
    //self.closeButton.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.6];
}

- (void)closeButtonOut {
    [UIView animateWithDuration:0.5 animations:^{
        //self.closeButton.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.2];
    }];
}

- (void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion {
    //NSLog(@"FullScreeniAdViewController dismissViewControllerAnimated");
    [super dismissViewControllerAnimated:flag completion:completion];
    //self.closeButton.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.2];
    if (!self.isClosing) [FullScreeniAdAddOnInstance cycleInterstitial];
    self.isClosing = TRUE;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:true];
    //NSLog(@"FullScreeniAdViewController viewDidAppear");
    if (self.isClosing) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
