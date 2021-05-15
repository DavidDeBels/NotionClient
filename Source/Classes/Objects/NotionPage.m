//
//  NotionPage.m
//  NotionClient
//
//  Created by David De Bels on 14/05/2021.
//

#import "NotionPage.h"
#import "NotionTitleProperty.h"

/// MARK: NotionPage Class Extension

@interface NotionPage ()

@end

/// MARK: NotionPage Implementation

@implementation NotionPage

@synthesize object = _object;

/// MARK: Init

- (instancetype)init {
    self  = [super init];
    if (self) {
        _object = NotionObjectTypePage;
        _parentType = NotionParentTypeUnknown;
    }
    
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super initWithDictionary:dictionary];
    if (self) {
        NSString *createdTime = [dictionary stringForKeyOrNil:@"created_time"];
        _createdTime = [NotionHelper dateFromString:createdTime];
        NSString *lastEditedTime = [dictionary stringForKeyOrNil:@"last_edited_time"];
        _lastEditedTime = [NotionHelper dateFromString:lastEditedTime];
        
        _archived = [dictionary numberForKeyOrNil:@"archived"].boolValue;
        
        // Parse parent
        NSDictionary *parent = [dictionary dictionaryForKeyOrNil:@"parent"];
        if (parent) {
            NSString *typeString = [parent stringForKeyOrNil:@"type"];
            NotionParentType type = [NotionHelper parentTypeForString:typeString];
            
            if (type == NotionParentTypePage || type == NotionParentTypeDatabase) {
                _parentId = [parent stringForKeyOrNil:typeString];
            } else {
                _parentId = nil;
            }
        }
        
        // Parse properties
        [self parseProperties:[dictionary dictionaryForKeyOrNil:@"properties"]];
    }
    
    return self;
}

- (void)parseProperties:(NSDictionary *)dictionary {
    NSMutableDictionary *properties = [NSMutableDictionary new];
    
    for (NSString *key in dictionary.allKeys) {
        NSDictionary *value = [dictionary dictionaryForKeyOrNil:key];
        
        NSString *type = [value stringForKeyOrNil:@"type"];
        Class class = [NotionHelper classForPropertyType:type];
        if (class) {
            NotionProperty *property = [[class alloc] initWithName:key dictionary:value];
            properties[key] = property;
            
            /*
            // Special case, if the property is the title, set the title of the page
            if (property.type == NotionPropertyTypeTitle) {
                _title = [((NSDictionary *)[[property.rawData arrayForKeyOrNil:@"title"] firstObject]) stringForKeyOrNil:@"plain_text"];
            }
             */
        }
    }
    
    _properties = [properties copy];
}

- (NSString *)title {
    for (NotionProperty *property in self.properties.allValues) {
        if (property.type == NotionPropertyTypeTitle) {
            return ((NotionTitleProperty *)property).title;
        }
    }
    
    return nil;
}

/// MARK: Debug

- (NSString *)description {
    NSDictionary *info = @{
        @"id": self.id,
        @"title": self.title ?: @"nil",
        @"createdTimeDate": self.createdTime ?: @"nil",
        @"lastEditedTimeDate": self.lastEditedTime ?: @"nil"
    };
    
    NSString *description = [super description];
    description = [description stringByAppendingFormat:@" %@", info];
    
    return description;
}

/// MARK: Serialize

- (NSMutableDictionary *)serializedObject {
    NSMutableDictionary *dictionary = [super serializedObject];
    dictionary[@"created_time"] = [NotionHelper stringFromDate:self.createdTime];
    dictionary[@"last_edited_time"] = [NotionHelper stringFromDate:self.lastEditedTime];
    dictionary[@"archived"] = @(self.archived);
    dictionary[@"parent"] = [NSMutableDictionary new];
    
    if (self.parentType != NotionParentTypeUnknown) {
        dictionary[@"parent"][@"type"] = [NotionHelper stringForParentType:self.parentType];
        if (self.parentType == NotionParentTypeWorkspace) {
            dictionary[@"parent"][@"workspace"] = @YES;
        } else if (self.parentType == NotionParentTypePage) {
            dictionary[@"parent"][@"page_id"] = self.parentId;
        } else if (self.parentType == NotionParentTypeDatabase) {
            dictionary[@"parent"][@"database_id"] = self.parentId;
        }
    }
    
    NSMutableDictionary *properties = [NSMutableDictionary new];
    for (NSString *propertyName in self.properties.allKeys) {
        NotionProperty *property = self.properties[propertyName];
        properties[propertyName] = property.serializedObject;
    }
    dictionary[@"properties"] = properties;
    
    return dictionary;
}

@end
