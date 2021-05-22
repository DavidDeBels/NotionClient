//
//  NotionRelationFilter.m
//  NotionClient
//
//  Created by David De Bels on 20/05/2021.
//

#import "NotionRelationFilter.h"

/// MARK: - NotionRelationFilter Class Extension

@interface NotionRelationFilter ()

@property (nonatomic, assign, readwrite) NotionFilterType type;

@end

/// MARK: - NotionRelationFilter Implementation

@implementation NotionRelationFilter

@synthesize type = _type;

/// MARK: Convenience Init

+ (NotionRelationFilter *)property:(NSString *)propertyName contains:(NSString *)pageId {
    return [[self alloc] initWithPropertyName:propertyName type:NotionFilterTypeContains pageId:pageId];
}

+ (NotionRelationFilter *)property:(NSString *)propertyName doesNotContain:(NSString *)pageId {
    return [[self alloc] initWithPropertyName:propertyName type:NotionFilterTypeDoesNotContain pageId:pageId];
}

+ (NotionFilter *)propertyIsEmpty:(NSString *)propertyName {
    return [[self alloc] initWithPropertyName:propertyName type:NotionFilterTypeIsEmpty pageId:nil];
}

+ (NotionFilter *)propertyIsNotEmpty:(NSString *)propertyName {
    return [[self alloc] initWithPropertyName:propertyName type:NotionFilterTypeIsNotEmpty pageId:nil];
}

/// MARK: Init

- (instancetype)initWithPropertyName:(NSString *)propertyName type:(NotionFilterType)type pageId:(NSString *)pageId {
    if (!propertyName) {
        return nil;
    }
    
    self = [self init];
    if (self) {
        _type = type;
        _propertyName = propertyName;
        _pageId = pageId;
    }
    
    return self;
}

/// MARK: Serialize

- (NSMutableDictionary *)serializedObject {
    NSMutableDictionary *dictionary = [super serializedObject];
    dictionary[@"property"] = self.propertyName;
    
    NSString *key = [NotionHelper stringForFilterType:self.type];
    if (self.type == NotionFilterTypeIsEmpty || self.type == NotionFilterTypeIsNotEmpty) {
        dictionary[@"relation"] = @{
            key: @YES
        };
    } else {
        dictionary[@"relation"] = @{
            key: self.pageId
        };
    }
    
    return dictionary;
}

@end
