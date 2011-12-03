//
//  CryptUtl.m
//  ios-utility-pack
//
//  Created by Brian Pfeil on 12/3/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "CryptUtl.h"
#import <CommonCrypto/CommonDigest.h>

@implementation CryptUtl

+ (NSString*)md5OfFileAtPath:(NSString*)path
{
	NSFileHandle *handle = [NSFileHandle fileHandleForReadingAtPath:path];
	if( handle== nil ) return @"ERROR GETTING FILE MD5"; // file didnt exist
	
	CC_MD5_CTX md5;
	
	CC_MD5_Init(&md5);
	
	BOOL done = NO;
	while(!done)
	{
		NSData* fileData = [handle readDataOfLength: 1024];
		CC_MD5_Update(&md5, [fileData bytes], [fileData length]);
		if( [fileData length] == 0 ) {
			done = YES;
		}
		[fileData release];
	}
	[handle closeFile];
	[handle release];
	unsigned char digest[CC_MD5_DIGEST_LENGTH];
	CC_MD5_Final(digest, &md5);
	
	NSMutableString *hash = [NSMutableString stringWithCapacity: CC_MD5_DIGEST_LENGTH * 2];
	for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [hash appendFormat:@"%02x", digest[i]];
	}
	
	return hash;
	
	/*
     NSString* s = [NSString stringWithFormat: @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
     digest[0], digest[1], 
     digest[2], digest[3],
     digest[4], digest[5],
     digest[6], digest[7],
     digest[8], digest[9],
     digest[10], digest[11],
     digest[12], digest[13],
     digest[14], digest[15]];
	 return s;
	 */
}

+ (NSString *) md5:(NSString *)str {
	const char *cStr = [str UTF8String];
	unsigned char result[16];
	CC_MD5( cStr, strlen(cStr), result );
	return [NSString stringWithFormat:
			@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
			result[0], result[1], result[2], result[3], 
			result[4], result[5], result[6], result[7],
			result[8], result[9], result[10], result[11],
			result[12], result[13], result[14], result[15]
			];	
}

@end
