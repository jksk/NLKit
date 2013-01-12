//
//  NSString+NLKit_Hash.m
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

#import <CommonCrypto/CommonHMAC.h>
#import "NSString+NLKit_Hash.h"

@implementation NSString (NLKit_Hash)

- (NSData *)dataWithHash:(NLHashAlgorithm)algorithm
{
	int bLen;
	
	switch (algorithm) {
		case NLHashAlgorithmMD5:
			bLen = CC_MD5_DIGEST_LENGTH;
			break;
		case NLHashAlgorithmSHA1:
			bLen = CC_SHA1_DIGEST_LENGTH;
			break;
		case NLHashAlgorithmSHA224:
			bLen = CC_SHA224_DIGEST_LENGTH;
			break;
		case NLHashAlgorithmSHA256:
			bLen = CC_SHA256_DIGEST_LENGTH;
			break;
		case NLHashAlgorithmSHA384:
			bLen = CC_SHA384_DIGEST_LENGTH;
			break;
		case NLHashAlgorithmSHA512:
			bLen = CC_SHA512_DIGEST_LENGTH;
			break;
		default:
#ifdef DEBUG
			[NSException raise:@"Illegal NLHashAlgorithm value" format:@"value %i is out of bounds", algorithm];
#endif
			return nil;
	}
	
	unsigned char buffer[bLen];
	
	switch (algorithm) {
		case NLHashAlgorithmMD5:
			CC_MD5([self UTF8String], [self length], buffer);
			break;
		case NLHashAlgorithmSHA1:
			CC_SHA1([self UTF8String], [self length], buffer);
			break;
		case NLHashAlgorithmSHA224:
			CC_SHA224([self UTF8String], [self length], buffer);
			break;
		case NLHashAlgorithmSHA256:
			CC_SHA256([self UTF8String], [self length], buffer);
			break;
		case NLHashAlgorithmSHA384:
			CC_SHA384([self UTF8String], [self length], buffer);
			break;
		case NLHashAlgorithmSHA512:
			CC_SHA512([self UTF8String], [self length], buffer);
			break;
	}
	
	return [NSData dataWithBytes:buffer length:bLen];
}

- (NSData *)dataHMACSignedWithKey:(NSString *)key algorithm:(NLHashAlgorithm)algorithm
{
	CCHmacAlgorithm algo;
	int bLen;
	
	switch (algorithm) {
		case NLHashAlgorithmMD5:
			algo = kCCHmacAlgMD5;
			bLen = CC_MD5_DIGEST_LENGTH;
			break;
		case NLHashAlgorithmSHA1:
			algo = kCCHmacAlgSHA1;
			bLen = CC_SHA1_DIGEST_LENGTH;
			break;
		case NLHashAlgorithmSHA224:
			algo = kCCHmacAlgSHA224;
			bLen = CC_SHA224_DIGEST_LENGTH;
			break;
		case NLHashAlgorithmSHA256:
			algo = kCCHmacAlgSHA256;
			bLen = CC_SHA256_DIGEST_LENGTH;
			break;
		case NLHashAlgorithmSHA384:
			algo = kCCHmacAlgSHA384;
			bLen = CC_SHA384_DIGEST_LENGTH;
			break;
		case NLHashAlgorithmSHA512:
			algo = kCCHmacAlgSHA512;
			bLen = CC_SHA512_DIGEST_LENGTH;
			break;
		default:
#ifdef DEBUG
			[NSException raise:@"Illegal NLHashAlgorithm value" format:@"value %i is out of bounds", algorithm];
#endif
			return nil;
	}
	
	unsigned char buffer[bLen];
	CCHmac(algo, [key UTF8String], [key length], [self UTF8String], [self length], buffer);
	return [NSData dataWithBytes:buffer length:bLen];
}

@end
