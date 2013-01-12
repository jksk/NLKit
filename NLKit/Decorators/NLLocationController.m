//
//  NLLocationController.m
//
//  Created by Jesper Skrufve <jesper@neolo.gy>
//  
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to
//  deal in the Software without restriction, including without limitation the
//  rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
//  sell copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//  
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//  
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
//  IN THE SOFTWARE.
//  

#import "NLLocationController.h"

const struct NLLocationControllerNotificationsStruct NLLocationControllerNotifications = {
	
	.start		= @"NLLocationControllerNotificationStart",
	.stop		= @"NLLocationControllerNotificationStop",
	.update		= @"NLLocationControllerNotificationUpdate",
	.error		= @"NLLocationControllerNotificationError"
};

const struct NLLocationControllerKeysStruct NLLocationControllerKeys = {
	
	.location	= @"NLLocationControllerNotificationLocationKey",
	.error		= @"NLLocationControllerNotificationErrorKey"
};

#pragma mark -
@interface NLLocationController ()

@property (strong, nonatomic) CLLocationManager*	locationManager;
@property (strong, nonatomic) NSDate*				lastUpdate;

@end

#pragma mark -
@implementation NLLocationController

#pragma mark - Lifecycle

- (id)init
{
	if (self = [super init]) {
		
		[self setMinimumAccuracy:1500.f];
		[self setMaximumUpdateFrequency:15.f];
		[self setLastUpdate:[NSDate dateWithTimeIntervalSince1970:0.f]];
	}
	
	return self;
}

- (void)dealloc
{
	[self setActive:NO];
	[_locationManager setDelegate:nil];
}

static NLLocationController* NLLocationControllerSingleton_ = nil;

+ (NLLocationController *)shared
{
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		
		NLLocationControllerSingleton_ = [[self alloc] init];
	});
	
	return NLLocationControllerSingleton_;
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
	if (![self isActive])
		return;
	
	// not long enough since last update, skip
	NSTimeInterval diff = [[NSDate date] timeIntervalSinceDate:[self lastUpdate]];
	
	if (diff < _maximumUpdateFrequency)
		return;
	
	if (![locations count])
		return;
	
	CLLocation* newLocation = [locations lastObject];
	
	// too erronous, skip
	if ([newLocation horizontalAccuracy] > _minimumAccuracy)
		return;
	
	[self setLastUpdate:[newLocation timestamp]];
	
	NSDictionary* userInfo = [NSDictionary dictionaryWithObject:newLocation forKey:NLLocationControllerKeys.location];
	[[NSNotificationCenter defaultCenter] postNotificationName:NLLocationControllerNotifications.update object:self userInfo:userInfo];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
	NSDictionary* userInfo = [NSDictionary dictionaryWithObject:error forKey:NLLocationControllerKeys.error];
	[[NSNotificationCenter defaultCenter] postNotificationName:NLLocationControllerNotifications.error object:self userInfo:userInfo];
	
	if ([error code] == kCLErrorDenied)
		[self setActive:NO];
}

#pragma mark - Public

+ (BOOL)isAvailable
{
	CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
	
	return ([CLLocationManager locationServicesEnabled] && (status == kCLAuthorizationStatusAuthorized || status == kCLAuthorizationStatusNotDetermined));
}

#pragma mark - Property Accessors

- (void)setActive:(BOOL)active
{
	if (active && ![[self class] isAvailable])
		return;
	
	CLLocationManager* lm = [self locationManager];
	
	if (active && !_active) {
		
		if (_highResolution)
			[lm startUpdatingLocation];
		else
			[lm startMonitoringSignificantLocationChanges];
		
		[[NSNotificationCenter defaultCenter] postNotificationName:NLLocationControllerNotifications.start object:self];
	}
	else if (!active && _active) {
		
		if (_highResolution)
			[lm stopUpdatingLocation];
		else
			[lm stopMonitoringSignificantLocationChanges];
		
		[[NSNotificationCenter defaultCenter] postNotificationName:NLLocationControllerNotifications.stop object:self];
	}
	
	_active = active;
}

- (void)setHighResolution:(BOOL)highResolution
{
	if (_active) {
		
		CLLocationManager* lm = [self locationManager];
		
		if (highResolution && !_highResolution) {
			
			[lm stopMonitoringSignificantLocationChanges];
			[lm startUpdatingLocation];
		}
		else if (!highResolution && _highResolution) {
			
			[lm stopUpdatingLocation];
			[lm startMonitoringSignificantLocationChanges];
		}
	}
	
	_highResolution = highResolution;
}

- (CLLocationManager *)locationManager
{
	if (_locationManager)
		return _locationManager;
	
	_locationManager = [[CLLocationManager alloc] init];
	
	[_locationManager setDelegate:self];
	[_locationManager setDistanceFilter:0.f];
	[_locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
	
	return _locationManager;
}

@end
