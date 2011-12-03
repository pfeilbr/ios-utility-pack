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

+ (BOOL)deleteFile:(NSString*)path {
    NSError *err;
    return [[NSFileManager defaultManager] removeItemAtPath:path error:&err];
}

+ (BOOL)deleteDirectory:(NSString*)path {
    return [self deleteFile:path];
}


@end
