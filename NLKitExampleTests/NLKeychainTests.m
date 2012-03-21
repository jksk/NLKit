//
//  NLKeychainTests.m
//  NLKit
//
//  Created by Jesper Skrufve on 19/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NLKeychainTests.h"
#import "NLKeychain.h"

@implementation NLKeychainTests

- (void)testKeychain
{
	NSString* identifier = @"ident";
	NSData* data		 = [@"my_passwd" dataUsingEncoding:NSUTF8StringEncoding];
	
	BOOL store			 = [NLKeychain storeData:data withIdentifier:identifier];
	NSData* retrieve	 = [NLKeychain dataWithIdentifier:identifier];
	BOOL update			 = [NLKeychain storeData:data withIdentifier:identifier];
	BOOL delete			 = [NLKeychain deleteDataWithIdentifier:identifier];
	
	NSAssert(store, @"error storing value");
	NSAssert([retrieve isEqualToData:data], @"error retrieving value");
	NSAssert(update, @"error updating value");
	NSAssert(delete, @"error deleting value");
}

@end
