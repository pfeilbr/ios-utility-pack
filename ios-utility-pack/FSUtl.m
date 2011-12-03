//
//  FSUtl.m
//  ios-utility-pack
//
//  Created by Brian Pfeil on 12/2/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "FSUtl.h"

static FSUtl *FSUtlSharedInstance;

@implementation FSUtl

- init {
    if (self = [super init]) {
        // init code here
    }
    return self;
}

+ (FSUtl*)sharedInstance {
    if (FSUtlSharedInstance == nil) {
        FSUtlSharedInstance = [[FSUtl alloc] init];
    }
    return FSUtlSharedInstance;
}

+ (NSString*)test {
    return @"hello";
}

+ (NSString *)applicationDocumentsDirectory {
	return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

+ (BOOL)createDirectoryAtPath:(NSString*)path {
	if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
		[[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
	}
	return [[NSFileManager defaultManager] fileExistsAtPath:path];
}

+ (BOOL)deleteFile:(NSString*)path {
    NSError *err;
    return [[NSFileManager defaultManager] removeItemAtPath:path error:&err];
}

+ (BOOL)deleteDirectory:(NSString*)path {
    return [self deleteFile:path];
}

+(id)propertyListFromFile:(NSString*)path {
	id propertyListData = nil;
	BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:path];
	if (fileExists) {
		NSData *theData = [[NSData alloc] initWithContentsOfFile:path];
		NSString *errorDescription;
		propertyListData = [NSPropertyListSerialization propertyListFromData:theData mutabilityOption:NSPropertyListMutableContainers format:nil errorDescription:&errorDescription];
		[theData release];
	}
	return propertyListData;
}

@end
