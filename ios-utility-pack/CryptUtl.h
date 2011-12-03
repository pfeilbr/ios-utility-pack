//
//  CryptUtl.h
//  ios-utility-pack
//
//  Created by Brian Pfeil on 12/3/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CryptUtl : NSObject

+ (NSString*)md5:(NSString*)str;
+ (NSString*)md5OfFileAtPath:(NSString*)path;

@end
