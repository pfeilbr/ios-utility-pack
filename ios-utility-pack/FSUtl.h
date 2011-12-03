//
//  FSUtl.h
//  ios-utility-pack
//
//  Created by Brian Pfeil on 12/2/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FSUtl : NSObject

+ (FSUtl*)sharedInstance;

+ (NSString*)test;

+ (NSString *)applicationDocumentsDirectory;

+ (BOOL)createDirectoryAtPath:(NSString*)path;

+ (BOOL)deleteFile:(NSString*)path;
+ (BOOL)deleteDirectory:(NSString*)path;

+ (id)propertyListFromFile:(NSString*)path;

@end
