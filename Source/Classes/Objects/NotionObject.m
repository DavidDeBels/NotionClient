//
//  NotionObject.m
//  NotionClient
//
//  Created by David De Bels on 14/05/2021.
//

#import "NotionObject.h"

/// MARK: NotionObject Class Extension

@interface NotionObject ()

@property (nonatomic, copy, readwrite) NSString *id;

@end

/// MARK: NotionObject Implementation

@implementation NotionObject

/// MARK: Init

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [self init];
    if (self) {
        _id = [dictionary stringForKeyOrNil:@"id"];
    }
    
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    NSMutableDictionary *serialized = self.serializedObject;
    //[serialized removeObjectForKey:@"id"];
    
    NotionObject *object = [[self.class allocWithZone:zone] initWithDictionary:serialized];
    return object;
}

/// MARK: Serialize

- (NSMutableDictionary *)serializedObject {
    NSMutableDictionary *dictionary = [NSMutableDictionary new];
    dictionary[@"object"] = [NotionHelper stringForObjectType:self.object];
    dictionary[@"id"] = self.id;
    
    return dictionary;
}

@end
