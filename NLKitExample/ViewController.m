//
//  ViewController.m
//  NLKit
//
//  Created by Jesper Skrufve on 13/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "NLActivityIndicatorView.h"
#import "NLDotActivityIndicatorView.h"
#import "NLEmbossedLabel.h"
#import "UIView+NLKit_Animations.h"

@interface ViewController ()

@end

#pragma mark -
@implementation ViewController

#pragma mark - Lifecycle

- (id)init
{
	if (!(self = [super init])) return nil;
	
	return self;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	UIView* view = [self view];
	
	CGRect frame = {20.f, 20.f, 100.f, 100.f};
	NLActivityIndicatorView* indicator = [[NLActivityIndicatorView alloc] initWithFrame:frame];
	[indicator setIndicatorWidth:10.f];
	[indicator setIndicatorColor:[UIColor darkGrayColor]];
	[indicator setAnimating:YES];
	
	frame.origin.x = 160.f;
	NLDotActivityIndicatorView* dot = [[NLDotActivityIndicatorView alloc] initWithFrame:frame];
	[dot setIndicatorColor:[UIColor darkGrayColor]];
	[dot setIndicatorWidth:10.f];
	[dot setAnimating:YES];
	
//	[view addSubview:indicator];
//	[view addSubview:dot];
	[view setBackgroundColor:[UIColor grayColor]];
	
	NLEmbossedLabel* label = [[NLEmbossedLabel alloc] initWithFrame:frame];
	[label setText:@"test-text"];
	[view addSubview:label];
}

- (void)viewDidUnload
{
	[super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	
	CGRect frame = {100.f, 100.f, 100.f, 40.f};
	UIButton* button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[button setFrame:frame];
	[button setTitle:@"button" forState:UIControlStateNormal];
//	[button rotateToAngle:90.f animationDuration:1.f];
	[button spinWithVelocity:1.f forInterval:3.5f];
	
//	[[self view] addSubview:button];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

@end
