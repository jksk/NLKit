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
#define KEYBOARD_ANIMATION_DURATION				0.3f

#define _radians(degrees)						(M_PI * (degrees) / 180.0)
#define _degrees(radians)						(180.0 * (radians) / M_PI)

#define _bw										__block __weak

//	Convenience objects, mostly from https://bitbucket.org/snej/myutilities and https://github.com/nevyn/SPSuccinct
#define _marr(...)								[NSMutableArray arrayWithObjects:__VA_ARGS__, nil]
#define _mdict(...)								[NSMutableDictionary dictionaryWithObjectsAndKeys:__VA_ARGS__, nil]
#define _set(...)								[NSSet setWithObjects:__VA_ARGS__, nil]
#define _mset(...)								[NSMutableSet setWithObjects:__VA_ARGS__, nil]
#define _oset(...)								[NSOrderedSet orderedSetWithObjects:__VA_ARGS__, nil]
#define _moset(...)								[NSMutableOrderedSet orderedSetWithObjects:__VA_ARGS__, nil]

#define _str(...)								[NSString stringWithFormat:__VA_ARGS__]
#define _mstr(...)								[NSMutableString stringWithFormat:__VA_ARGS__]
#define _lstr(...)								NSLocalizedString([NSString stringWithFormat:__VA_ARGS__], nil)
#define _null									[NSNull null]
#define _err(domain, num)						[NSError errorWithDomain:domain code:num userInfo:nil]

// mostly from http://www.coranac.com/documents/working-with-bits-and-bitfields/
#define _bit(x)									(1 << (x))
#define _bit_set(x, mask)						(x |= (mask))
#define _bit_unset(x, mask)						(x &= ~(mask))
#define _bit_flip(x, mask)						(x ^= (mask))
#define _bit_is_set(x, mask)					((x & (mask)) != 0)

////////////////////////////////////////////////////////////////////////////////////////////////
//	Debug macros
////////////////////////////////////////////////////////////////////////////////////////////////
#ifdef DEBUG

//	Loggers
#define dlog(f, ...)	NSLog((@"\n%s[%d]\n" f),__func__,__LINE__,##__VA_ARGS__)
#define slog(string)	dlog(@"%@", string)
#define flog(float)		dlog(@"%f", float)
#define ilog(int)		dlog(@"%i", int)

////////////////////////////////////////////////////////////////////////////////////////////////
//	Production macros
////////////////////////////////////////////////////////////////////////////////////////////////
#else

// Logger dummies
#define dlog(...)		do { } while(0);
#define slog(...)		do { } while(0);
#define flog(...)		do { } while(0);
#define ilog(...)		do { } while(0);

#endif
#endif
