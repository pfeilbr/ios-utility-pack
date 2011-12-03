//
//  BPDataMgr.h
//  ScratchApp
//
//  Created by Brian Pfeil on 7/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataMgr : NSObject {
    NSString *_name;
    NSDictionary *_options;
}

@property (nonatomic, readonly) NSString *name;

+ (DataMgr*)dataMgrWithName:(NSString*)name options:(NSDictionary*)options;
+ (DataMgr*)dataMgrWithName:(NSString*)name;
+ (DataMgr*)get:(NSString*)name;
+ (DataMgr*)app;

- (id)valueForKeyPath:(NSString*)path;
- (void)setValue:(id)value forKeyPath:(NSString*)keyPath;

@end
