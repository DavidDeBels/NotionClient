//
//  NotionPersonFilter.m
//  NotionClient
//
//  Created by David De Bels on 20/05/2021.
//

#import "NotionPersonFilter.h"

/// MARK: - NotionPersonFilter Implementation

@implementation NotionPersonFilter

@synthesize type = _type;

/// MARK: Convenience Init

+ (NotionPersonFilter *)property:(NSString *)propertyName contains:(NSString *)userId {
    return [[self alloc] initWithPropertyName:propertyName type:NotionFilterTypeContains userId:userId];
}

+ (NotionPersonFilter *)property:(NSString *)propertyName doesNotContain:(NSString *)userId {
    return [[self alloc] initWithPropertyName:propertyName type:NotionFilterTypeDoesNotContain userId:userId];
}

+ (NotionFilter *)propertyIsEmpty:(NSString *)propertyName {
    return [[self alloc] initWithPropertyName:propertyName type:NotionFilterTypeIsEmpty userId:nil];
}

+ (NotionFilter *)propertyIsNotEmpty:(NSString *)propertyName {
    return [[self alloc] initWithPropertyName:propertyName type:NotionFilterTypeIsNotEmpty userId:nil];
}

/// MARK: Init

- (instancetype)initWithPropertyName:(NSString *)propertyName type:(NotionFilterType)type userId:(NSString *)userId {
    if (!propertyName) {
        return nil;
    }
    
    self = [self init];
    if (self) {
        _type = type;
        _propertyName = propertyName;
        _userId = userId;
    }
    
    return self;
}

/// MARK: Serialize

- (NSMutableDictionary *)serializedObject {
    NSMutableDictionary *dictionary = [super serializedObject];
    dictionary[@"property"] = self.propertyName;
    
    NSString *key = [NotionHelper stringForFilterType:self.type];
    if (self.type == NotionFilterTypeIsEmpty || self.type == NotionFilterTypeIsNotEmpty) {
        dictionary[@"people"] = @{
            key: @YES
        };
    } else {
        dictionary[@"people"] = @{
            key: self.userId
        };
    }
    
    return dictionary;
}

@end
