//
//  NLMacros.h
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

#ifndef NLKit_NLMacros_h
#define NLKit_NLMacros_h

#import <stdint.h>

////////////////////////////////////////////////////////////////////////////////////////////////
//	Universal macros
////////////////////////////////////////////////////////////////////////////////////////////////

#ifdef __GNUC__
#define UNUSED_VARIABLE							__attribute__ ((unused))
#else
#define UNUSED_VARIABLE
#endif

#define MIN3(x,y,z)								MIN(MIN(x,y),z)
#define MAX3(x,y,z)								MAX(MAX(x,y),z)
#define MID(min,x,max)							MAX(MIN(x, max), min)

#define CGRectGetCenter(rect)					CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect))
#define CLLocationCoordinate2DZero				CLLocationCoordinate2DMake(0.0, 0.0)
#define NSStringFromCLLocationCoordinate2D(c)	[NSString stringWithFormat:@"{%f, %f}", c.latitude, c.longitude]
#define NSStringFromNSIndexPath(ip)				[NSString stringWithFormat:@"{%i, %i}", ip.section, ip.row]

#define ARC4RANDOM_MAX							UINT32_MAX
#define IPHONE_KEYBOARD_HEIGHT					166.f

#define _radians(degrees)						(M_PI * (degrees) / 180.0)
#define _degrees(radians)						(180.0 * (radians) / M_PI)

//	Convenience objects, mostly from https://bitbucket.org/snej/myutilities and https://github.com/nevyn/SPSuccinct
#define _arr(...)								[NSArray arrayWithObjects:__VA_ARGS__, nil]
#define _marr(...)								[NSMutableArray arrayWithObjects:__VA_ARGS__, nil]
#define _dict(...)								[NSDictionary dictionaryWithObjectsAndKeys:__VA_ARGS__, nil]
#define _mdict(...)								[NSMutableDictionary dictionaryWithObjectsAndKeys:__VA_ARGS__, nil]
#define _set(...)								[NSSet setWithObjects:__VA_ARGS__, nil]
#define _mset(...)								[NSMutableSet setWithObjects:__VA_ARGS__, nil]
#define _oset(...)								[NSOrderedSet orderedSetWithObjects:__VA_ARGS__, nil]
#define _moset(...)								[NSMutableOrderedSet orderedSetWithObjects:__VA_ARGS__, nil]

#define _str(...)								[NSString stringWithFormat:__VA_ARGS__]
#define _mstr(...)								[NSMutableString stringWithFormat:__VA_ARGS__]
#define _lstr(...)								NSLocalizedString([NSString stringWithFormat:__VA_ARGS__], nil)
#define _num(i)									[NSNumber numberWithInteger:i]
#define _numf(f)								[NSNumber numberWithDouble:f]
#define _null									[NSNull null]
#define _err(domain, num)						[NSError errorWithDomain:domain code:num userInfo:nil]

////////////////////////////////////////////////////////////////////////////////////////////////
//	Debug macros
////////////////////////////////////////////////////////////////////////////////////////////////
#ifdef DEBUG

//	Loggers
#define dlog(f, ...)	NSLog((@"\n%s[%d]\n" f),__func__,__LINE__,##__VA_ARGS__)
#define slog(s)			dlog(@"%@", s)
#define flog(f)			dlog(@"%f", f)
#define ilog(i)			dlog(@"%i", i)

// Cast macro, from https://github.com/nevyn/SPSuccinct
#define _cast(cls, obj)	({ id obj2 = (obj); \
						   if (obj2 && ![obj2 isKindOfClass:[cls class]]) \
							   [NSException raise:@"Erronous cast" \
										   format:@"%@ is not a %@", obj, NSStringFromClass([cls class])]; \
						 (cls *)obj2; })

#define _notNil(val)	({ __typeof__(val) val2 = (val); NSAssert(val2 != nil, @"Must not be nil"); val2; })

////////////////////////////////////////////////////////////////////////////////////////////////
//	Production macros
////////////////////////////////////////////////////////////////////////////////////////////////
#else

// Logger dummies
#define dlog(...)		do { } while(0);
#define slog(...)		do { } while(0);
#define flog(...)		do { } while(0);
#define ilog(...)		do { } while(0);

// simple cast in production
#define _cast(cls, obj)	({ (cls *)obj })
#define _notNil(val)	({ val; })

#endif
#endif