//
//  BPDataMgr.m
//  ScratchApp
//
//  Created by Brian Pfeil on 7/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DataMgr.h"

static NSMutableDictionary *_allDataMgrs;

@interface DataMgr()
- (DataMgr*)initWithWithName:(NSString*)name options:(NSDictionary*)options;
- (DataMgr*)initWithWithName:(NSString*)name;
- (BOOL)initStorage;
- (NSMutableDictionary*)getData;
- (BOOL)saveData:(id)data;
@end

@implementation DataMgr

@synthesize name=_name;

- (id)init {
    self = [super init];
    if (self) {
        
    }
    
    return self;
}

- (id)initWithWithName:(NSString*)name options:(NSDictionary*)options {
    self = [super init];
    if (self) {
        _name = [name copy];
        _options = [options copy];
        [self initStorage];
    }
    return self;
}

- (id)initWithWithName:(NSString*)name {
    NSString *applicationDocumentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *dataDirectory = [applicationDocumentsDirectory stringByAppendingPathComponent:@"data"];
    NSString *filePath = [dataDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.json", name]];
    NSDictionary *options = [NSDictionary dictionaryWithObject:filePath forKey:@"filePath"];
    return [self initWithWithName:name options:options];
}

- (BOOL)initStorage {
    NSString *filePath = [_options valueForKeyPath:@"filePath"];
    NSString *dataDirectory = [filePath stringByDeletingLastPathComponent];    
	if (![[NSFileManager defaultManager] fileExistsAtPath:dataDirectory]) {
		[[NSFileManager defaultManager] createDirectoryAtPath:dataDirectory withIntermediateDirectories:YES attributes:nil error:nil];
	}
    
    BOOL success = YES;
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        NSDictionary *emptyDict = [NSDictionary dictionary];
        success = [self saveData:emptyDict];
    }
    
    return success;
}

+ (DataMgr*)dataMgrWithName:(NSString*)name options:(NSDictionary*)options {
    if (!_allDataMgrs) {
        _allDataMgrs = [[NSMutableDictionary alloc] init];
    }
    
    DataMgr *dataMgr = [[DataMgr alloc] initWithWithName:name options:options];
    [_allDataMgrs setValue:dataMgr forKeyPath:name];
    return dataMgr;
}

+ (DataMgr*)dataMgrWithName:(NSString*)name {
    if (!_allDataMgrs) {
        _allDataMgrs = [[NSMutableDictionary alloc] init];
    }
    
    DataMgr *dataMgr = [[DataMgr alloc] initWithWithName:name];
    [_allDataMgrs setValue:dataMgr forKeyPath:name];
    return dataMgr;
}

+ (DataMgr*)get:(NSString*)name {
    return [_allDataMgrs valueForKeyPath:name];
}

+ (DataMgr*)app {
    if ([self get:@"application-data"] == nil) {
        [self dataMgrWithName:@"application-data"];
    }
    return [self get:@"application-data"];
}

- (id)getData {
    NSString *dataFilePath = [_options valueForKeyPath:@"filePath"];
    DLog(@"dataFilePath = %@", dataFilePath);
    NSString *jsonDataContents = [NSString stringWithContentsOfURL:[NSURL fileURLWithPath:dataFilePath] encoding:NSUTF8StringEncoding error:nil];
    return jsonDataContents ? [jsonDataContents JSONValue] : nil;
}

- (BOOL)saveData:(id)data {
    NSString *dataFilePath = [_options valueForKeyPath:@"filePath"];
    DLog(@"dataFilePath = %@", dataFilePath);
    return [[data JSONRepresentation] writeToFile:dataFilePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

- (id)valueForKeyPath:(NSString*)path {
    return [[self getData] valueForKeyPath:path];
}

- (void)setValue:(id)value forKeyPath:(NSString *)keyPath {
    id dict = [self getData];
    [dict setValue:value forKeyPath:keyPath];
    [self saveData:dict];
}

@end
