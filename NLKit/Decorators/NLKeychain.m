//
//  NLKeychain.m
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

#import <Security/Security.h>
#import "NLKeychain.h"
#import "NLMacros.h"

@implementation NLKeychain

#pragma mark - Helpers

+ (NSMutableDictionary *)searchDictionaryWithIdentifier:(NSString *)identifier
{
	NSMutableDictionary* search = [NSMutableDictionary dictionary];
	NSData* identifierData		= [identifier dataUsingEncoding:NSUTF8StringEncoding];
	NSString* bundleIdentifier	= [[NSBundle mainBundle]
								   objectForInfoDictionaryKey:(__bridge NSString *)kCFBundleIdentifierKey];
	
	[search setObject:(__bridge id)kSecClassGenericPassword forKey:(__bridge id)kSecClass];
	[search setObject:identifierData forKey:(__bridge id)kSecAttrGeneric];
	[search setObject:identifierData forKey:(__bridge id)kSecAttrAccount];
	[search setObject:bundleIdentifier forKey:(__bridge id)kSecAttrService];
	
	return search;
}

#pragma mark - Public

+ (NSData *)dataWithIdentifier:(NSString *)identifier
{
	NSMutableDictionary* search = [self searchDictionaryWithIdentifier:identifier];
	CFTypeRef type;
	
	[search setObject:(__bridge id)kSecMatchLimitOne forKey:(__bridge id)kSecMatchLimit];
	[search setObject:(__bridge id)kCFBooleanTrue forKey:(__bridge id)kSecReturnData];
	
	OSStatus status = SecItemCopyMatching((__bridge CFDictionaryRef)search, &type);
	
	if (status != errSecSuccess)
		return nil;
	
	return (__bridge NSData *)type;
}

+ (BOOL)storeData:(NSData *)data withIdentifier:(NSString *)identifier
{
	NSMutableDictionary* search = [self searchDictionaryWithIdentifier:identifier];
	OSStatus status;
	
	if ([self dataWithIdentifier:identifier]) {
		
		NSMutableDictionary* update = [NSMutableDictionary dictionary];
		
		[update setObject:data forKey:(__bridge id)kSecValueData];
		status = SecItemUpdate((__bridge CFDictionaryRef)search, (__bridge CFDictionaryRef)update);
	}
	else {
		
		[search setObject:data forKey:(__bridge id)kSecValueData];
		status = SecItemAdd((__bridge CFDictionaryRef)search, NULL);
	}
	
	return status == errSecSuccess;
}

+ (BOOL)deleteDataWithIdentifier:(NSString *)identifier
{
	NSMutableDictionary* search = [self searchDictionaryWithIdentifier:identifier];
	
	OSStatus status = SecItemDelete((__bridge CFDictionaryRef)search);
	return status == errSecSuccess;
}

@end
