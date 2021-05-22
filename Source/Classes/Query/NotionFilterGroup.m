//
//  NotionFilterGroup.m
//  NotionClient
//
//  Created by David De Bels on 21/05/2021.
//

#import "NotionFilterGroup.h"

/// MARK: - NotionFilterGroup Implementation

@implementation NotionFilterGroup

@synthesize type = _type;

/// MARK: Convenience Init

+ (NotionFilterGroup *)orGroupWithFilters:(NSArray<NotionFilter *> *)filters {
    return [[self alloc] initWithFilters:filters type:NotionFilterTypeGroupOr];
}

+ (NotionFilterGroup *)andGroupWithFilters:(NSArray<NotionFilter *> *)filters {
    return [[self alloc] initWithFilters:filters type:NotionFilterTypeGroupAnd];
}

/// MARK: Init

- (instancetype)initWithFilters:(NSArray<NotionFilter *> *)filters type:(NotionFilterType)type {
    self = [self init];
    if (self) {
        _type = type;
        _filters = filters;
    }
    
    return self;
}

/// MARK: Serialize

- (NSMutableDictionary *)serializedObject {
    NSMutableDictionary *dictionary = [NSMutableDictionary new];
    
    NSMutableArray *filters = [NSMutableArray new];
    for (NotionFilter *filter in self.filters) {
        [filters addObject:filter.serializedObject];
    }
    
    NSString *key = [NotionHelper stringForFilterType:self.type];
    [dictionary setObject:filters forKey:key];
    
    return dictionary;
}

@end
