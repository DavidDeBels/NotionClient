//
//  NotionRelationProperty.m
//  NotionClient
//
//  Created by David De Bels on 14/05/2021.
//

#import "NotionRelationProperty.h"

/// MARK: - NotionRelationProperty Class Extension

@interface NotionRelationProperty ()

@property (nonatomic, copy, readwrite) NSString *name;

@end

/// MARK: - NotionRelationProperty Implementation

@implementation NotionRelationProperty

@synthesize name = _name;
@synthesize type = _type;

/// MARK: Init

+ (NotionRelationProperty *)relationWithName:(NSString *)name pageIds:(NSArray<NSString *> *)pageIds {
    NotionRelationProperty *property = [[self alloc] init];
    property.name = name;
    property.pageIds = pageIds;
    
    return property;
}

- (instancetype)init {
    self  = [super init];
    if (self) {
        _type = NotionPropertyTypeRelation;
    }
    
    return self;
}

- (instancetype)initWithName:(NSString *)name dictionary:(NSDictionary *)dictionary {
    self = [super initWithName:name dictionary:dictionary];
    if (self) {
        NSMutableArray *pageIds = [NSMutableArray new];
        
        NSArray *relations = [dictionary arrayForKeyOrNil:@"relation"];
        for (NSDictionary *relation in relations) {
            [pageIds addObject:relation[@"id"]];
        }
        _pageIds = [pageIds copy];
    }
    
    return self;
}

/// MARK: Serialize

- (NSMutableDictionary *)serializedObject {
    NSMutableDictionary *dictionary = [super serializedObject];
    
    NSMutableArray *relations = [NSMutableArray new];
    for (NSString *pageId in self.pageIds) {
        [relations addObject:@{ @"id": pageId }];
    }
    dictionary[@"relation"] = relations;

    return dictionary;
}

@end
