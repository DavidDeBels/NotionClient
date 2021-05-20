//
//  NotionProperty.m
//  NotionClient
//
//  Created by David De Bels on 14/05/2021.
//

#import "NotionProperty.h"

/// MARK: NotionProperty Implementation

@implementation NotionProperty

- (instancetype)initWithName:(NSString *)name dictionary:(NSDictionary *)dictionary {
    self = [self init];
    if (self) {
        _name = name;
        _type = [NotionHelper propertyTypeForString:[dictionary stringForKeyOrNil:@"type"]];
        _id = [dictionary stringForKeyOrNil:@"id"];
    }
    
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    NSMutableDictionary *serialized = self.serializedObject;
    //[serialized removeObjectForKey:@"id"];
    
    NotionProperty *property = [[self.class allocWithZone:zone] initWithName:self.name dictionary:serialized];
    return property;
}

/// MARK: Serialize

- (NSMutableDictionary *)serializedObject {
    NSMutableDictionary *dictionary = [NSMutableDictionary new];
    dictionary[@"type"] = [NotionHelper stringForPropertyType:self.type];
    dictionary[@"id"] = self.id;
    
    return dictionary;
}

/// MARK: Debug

- (NSString *)description {
    NSString *description = [super description];
    return description;
}

@end
