//
//  NSData+NLKit.m
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

#import "NSData+NLKit.h"

@interface NSData (NLKit_Private)

+ (NSString *)errorStringForZLibError:(NSInteger)error;

@end

@implementation NSData (NLKit)

#pragma mark - Public

- (NSString *)hexadecimalString
{
	const unsigned char* buffer = [self bytes];
	
	if (!buffer)
		return nil;
	
	NSUInteger len		 = [self length];
	NSMutableString* str = [NSMutableString stringWithCapacity:len*2];
	
	for (NSUInteger i = 0; i < len; i++)
		[str appendFormat:@"%02lx", (unsigned long)buffer[i]];
	
	return [NSString stringWithString:str];
}

- (NSData *)dataDeflatedWithCompressionLevel:(NLDataCompression)compression
{
	NSUInteger length = [self length];
	
	if (!length)
		return self;
	
	z_stream stream;
	stream.zalloc		= Z_NULL;
	stream.zfree		= Z_NULL;
	stream.opaque		= Z_NULL;
	stream.total_out	= 0;
	stream.next_in		= (Bytef *)[self bytes];
	stream.avail_in		= length;
	NSInteger status	= deflateInit2(&stream, compression, Z_DEFLATED, 31, 8, Z_DEFAULT_STRATEGY);
	
	if (status != Z_OK) {
#ifdef DEBUG
		[NSException raise:@"zlib init error" format:@"%i %@", status, [NSData errorStringForZLibError:status]];
#endif
		return nil;
	}
	
	NSMutableData* data = [NSMutableData dataWithLength:length * 1.01 + 12];
	
	do {
		stream.next_out		= [data mutableBytes] + stream.total_out;
		stream.avail_out	= [data length] - stream.total_out;
		status				= deflate(&stream, Z_FINISH);
		
	} while (status == Z_OK);
	
	if (status != Z_STREAM_END) {
#ifdef DEBUG
		[NSException raise:@"zlib compression error" format:@"%i %@", status, [NSData errorStringForZLibError:status]];
#endif
		deflateEnd(&stream);
		return nil;
	}
	
	status = deflateEnd(&stream);
	
	if (status != Z_OK) {
#ifdef DEBUG
		[NSException raise:@"zlib end error" format:@"%i %@", status, [NSData errorStringForZLibError:status]];
#endif
		return nil;
	}
	
	[data setLength:stream.total_out];
	
	return [NSData dataWithData:data];
}

- (NSData *)dataInflated
{
	NSUInteger length = [self length];
	
	if (!length)
		return self;
	
	z_stream stream;
	NSUInteger halfLen	= length / 2;
	NSMutableData* data = [NSMutableData dataWithLength:length + halfLen];
	stream.zalloc		= Z_NULL;
	stream.zfree		= Z_NULL;
	stream.total_out	= 0;
	stream.next_in		= (Bytef *)[self bytes];
	stream.avail_in		= length;
	NSInteger status	= inflateInit2(&stream, 47);
	
	if (status != Z_OK) {
#ifdef DEBUG
		[NSException raise:@"zlib init error" format:@"%i %@", status, [NSData errorStringForZLibError:status]];
#endif
		return nil;
	}
	
	do {
		
		if (stream.total_out >= [data length])
			[data increaseLengthBy:halfLen];
		
		stream.next_out		= [data mutableBytes] + stream.total_out;
		stream.avail_out	= [data length] - stream.total_out;
		
		status = inflate(&stream, Z_SYNC_FLUSH);
		
		if (status != Z_OK && status != Z_STREAM_END) {
#ifdef DEBUG
			[NSException raise:@"zlib inflate error" format:@"%i %@", status, [NSData errorStringForZLibError:status]];
#endif
			inflateEnd(&stream);
			return nil;
		}
		
	} while (status != Z_STREAM_END);
	
	status = inflateEnd(&stream);
	
	if (status != Z_OK) {
#ifdef DEBUG
		[NSException raise:@"zlib end error" format:@"%i %@", status, [NSData errorStringForZLibError:status]];
#endif
		return nil;
	}
	
	[data setLength:stream.total_out];
	
	return [NSData dataWithData:data];
}

#pragma mark - Helpers

+ (NSString *)errorStringForZLibError:(int)error
{
	switch (error) {
		case Z_STREAM_ERROR:
			return @"Invalid parameter or inconsistent state";
		case Z_MEM_ERROR:
			return @"Insufficient memory";
		case Z_VERSION_ERROR:
			return @"Header and library mismatch";
		case Z_ERRNO:
			return @"Read error";
		case Z_DATA_ERROR:
			return @"Invalid or incomplete deflate data";
		case Z_BUF_ERROR:
			return @"Insufficient write buffer";
		default:
			return @"Unknown error";
	}
}

@end
