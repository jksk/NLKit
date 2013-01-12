//
//  NSUserDefaults+NLKit.h
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

@interface NSUserDefaults (NLKit)

+ (BOOL)synchronize;

+ (void)setBool:(BOOL)value forKey:(NSString *)key;
+ (void)setDouble:(double)value forKey:(NSString *)key;
+ (void)setFloat:(float)value forKey:(NSString *)key;
+ (void)setInteger:(NSInteger)value forKey:(NSString *)key;
+ (void)setLong:(long)value forKey:(NSString *)key;
+ (void)setLongLong:(long long)value forKey:(NSString *)key;
+ (void)setNilValueForKey:(NSString *)key;
+ (void)setObject:(id)value forKey:(NSString *)key;
+ (void)setURL:(NSURL *)url forKey:(NSString *)key;

+ (BOOL)boolForKey:(NSString *)key;
+ (double)doubleForKey:(NSString *)key;
+ (float)floatForKey:(NSString *)key;
+ (NSInteger)integerForKey:(NSString *)key;
+ (long)longForKey:(NSString *)key;
+ (long long)longLongForKey:(NSString *)key;
+ (id)objectForKey:(NSString *)key;
+ (NSURL *)URLForKey:(NSString *)key;

+ (void)setCGRect:(CGRect)rect forKey:(NSString *)key;
+ (void)setCGSize:(CGSize)size forKey:(NSString *)key;
+ (void)setCGPoint:(CGPoint)point forKey:(NSString *)key;
+ (void)setNSRange:(NSRange)range forKey:(NSString *)key;

+ (CGRect)rectForKey:(NSString *)key;
+ (CGSize)sizeForKey:(NSString *)key;
+ (CGPoint)pointForKey:(NSString *)key;
+ (NSRange)rangeForKey:(NSString *)key;

@end
