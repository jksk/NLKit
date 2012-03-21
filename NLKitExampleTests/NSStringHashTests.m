//
//  NSStringHashTests.m
//  NLKit
//
//  Created by Jesper Skrufve on 7/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NSStringHashTests.h"
#import "NSString+NLKit_Hash.h"
#import "NSData+NLKit.h"

@implementation NSStringHashTests

- (void)testHash
{
	NSString* hashString = @"This is a test string.";
	
	NSString* md5    = [[hashString dataWithHash:NLHashAlgorithmMD5] hexadecimalString];
	NSString* sha1   = [[hashString dataWithHash:NLHashAlgorithmSHA1] hexadecimalString];
	NSString* sha224 = [[hashString dataWithHash:NLHashAlgorithmSHA224] hexadecimalString];
	NSString* sha256 = [[hashString dataWithHash:NLHashAlgorithmSHA256] hexadecimalString];
	NSString* sha384 = [[hashString dataWithHash:NLHashAlgorithmSHA384] hexadecimalString];
	NSString* sha512 = [[hashString dataWithHash:NLHashAlgorithmSHA512] hexadecimalString];
	
	NSString* wantedMD5    = @"1620d7b066531f9dbad51eee623f7635";
	NSString* wantedSHA1   = @"3532499280b4e2f32f6417e556901a526d69143c";
	NSString* wantedSHA224 = @"21ddacbf62caf20c8d9c37c652a41f8618af4f3d4e096ef72b6b8e30";
	NSString* wantedSHA256 = @"3eec256a587cccf72f71d2342b6dfab0bbca01697c7e7014540bdd62b72120da";
	NSString* wantedSHA384 = @"0c408cc6ff9fe49292211f88a2bc5d31bfb2b865328411b15681edab107c424b8f8142a5019860cfff7583a6971fd5c6";
	NSString* wantedSHA512 = @"ffb7c56645ba2c24e63032b077d041aca560fa2dbc9b252507ab1862541c328df3f643add183fb637d11bcbab9b0d9c5971de67edc40316fa2fe31e51761fb4b";
	
	NSAssert([md5 isEqualToString:wantedMD5], @"unmatched MD5");
	NSAssert([sha1 isEqualToString:wantedSHA1], @"unmatched SHA1");
	NSAssert([sha224 isEqualToString:wantedSHA224], @"unmatched SHA224");
	NSAssert([sha256 isEqualToString:wantedSHA256], @"unmatched SHA256");
	NSAssert([sha384 isEqualToString:wantedSHA384], @"unmatched SHA384");
	NSAssert([sha512 isEqualToString:wantedSHA512], @"unmatched SHA512");
}

@end
