//
//  NLLocationController.h
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

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

// constants
extern const struct NLLocationControllerNotificationsStruct
{
	__unsafe_unretained NSString*	start;
	__unsafe_unretained NSString*	stop;
	__unsafe_unretained NSString*	update;
	__unsafe_unretained NSString*	error;
	
} NLLocationControllerNotifications;

extern const struct NLLocationControllerKeysStruct
{
	__unsafe_unretained NSString*	location;
	__unsafe_unretained NSString*	error;
	
} NLLocationControllerKeys;


#pragma mark -
@interface NLLocationController : NSObject
<CLLocationManagerDelegate>

@property (assign, nonatomic, getter=isActive)			BOOL	active;
@property (assign, nonatomic, getter=isHighResolution)	BOOL	highResolution;
@property (assign, nonatomic)							CGFloat	minimumAccuracy;		// meters,	default 1500
@property (assign, nonatomic)							CGFloat	maximumUpdateFrequency;	// seconds, default 15

+ (NLLocationController *)shared;

+ (BOOL)isAvailable;

@end
