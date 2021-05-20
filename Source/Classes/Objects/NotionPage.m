//
//  NotionPage.m
//  NotionClient
//
//  Created by David De Bels on 14/05/2021.
//

#import "NotionPage.h"
#import "NotionTitleProperty.h"
#import "NotionRichText.h"

/// MARK: - NotionPage Class Extension

@interface NotionPage ()

@property (nonatomic, strong, readonly) NSMutableDictionary *internalProperties;

@end

/// MARK: - NotionPage Implementation

@implementation NotionPage

@synthesize object = _object;
@synthesize properties = _properties;

/// MARK: Init

+ (NotionPage *)pageWithTitle:(NSString *)title {
    NotionTitleProperty *titleProperty = [NotionTitleProperty titleWithName:@"title" title:title];
    return [self pageWithProperties:@[titleProperty]];
}

+ (NotionPage *)pageWithProperties:(NSArray<NotionProperty *> *)properties {
    NotionPage *page = [[self alloc] init];
    for (NotionProperty *property in properties) {
        [page addProperty:property];
    }
    
    return page;
}

- (instancetype)init {
    self  = [super init];
    if (self) {
        _object = NotionObjectTypePage;
        _parentType = NotionParentTypeUnknown;
        
        _createdTime = [NSDate date];
        _lastEditedTime = [NSDate date];
        _internalProperties = [NSMutableDictionary new];
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

- (id)copyWithZone:(NSZone *)zone {
    NSMutableDictionary *copiedProperties = [NSMutableDictionary new];
    for (NSString *name in self.properties.allKeys) {
        NotionProperty *property = self.properties[name];
        [copiedProperties setObject:[property copy] forKey:name];
    }
    
    NotionPage *copiedPage = [super copyWithZone:zone];
    copiedPage.properties = copiedProperties;
    
    return copiedPage;
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
        }
    }
    
    [_internalProperties removeAllObjects];
    [_internalProperties addEntriesFromDictionary:properties];
}

/// MARK: Page Properties

- (NSDictionary<NSString *,NotionProperty *> *)properties {
    return [self.internalProperties copy];
}

- (void)setProperties:(NSDictionary<NSString *,NotionProperty *> *)properties {
    [self.internalProperties removeAllObjects];
    if (properties) {
        [self.internalProperties addEntriesFromDictionary:properties];
    }
}

- (void)addProperty:(NotionProperty *)property {
    if (property && property.name) {
        [self.internalProperties setObject:property forKey:property.name];
    }
}

- (void)removePropertyWithName:(NSString *)name {
    if (name) {
        [self.internalProperties removeObjectForKey:name];
    }
}

/// MARK: Page Title Property

- (NSString *)titlePropertyName {
    for (NSString *name in self.properties.allKeys) {
        NotionProperty *property = self.properties[name];
        if (property.type == NotionPropertyTypeTitle) {
            return name;
        }
    }
    
    return nil;
}

- (NotionTitleProperty *)titleProperty {
    NSString *titlePropertyName = self.titlePropertyName;
    if (titlePropertyName) {
        return [self.internalProperties objectForKey:titlePropertyName];
    }
    
    return nil;
}

- (void)setTitleProperty:(NotionTitleProperty *)titleProperty {
    if (titleProperty && titleProperty.name) {
        NSString *titlePropertyName = self.titlePropertyName;
        if (titlePropertyName) {
            [self.internalProperties removeObjectForKey:titlePropertyName];
        }
        
        [self.internalProperties setObject:titleProperty forKey:titleProperty.name];
    }
}

- (NSString *)title {
    for (NotionProperty *property in self.properties.allValues) {
        if (property.type == NotionPropertyTypeTitle) {
            return ((NotionTitleProperty *)property).title;
        }
    }
    
    return nil;
}

- (void)setTitle:(NSString *)title {
    NotionTitleProperty *titleProperty = self.titleProperty;
    if (titleProperty) {
        titleProperty.parts = @[[NotionRichText textWithContent:title]];
    }
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

@end
