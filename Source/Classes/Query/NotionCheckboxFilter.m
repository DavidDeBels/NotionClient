//
//  NotionCheckboxFilter.m
//  NotionClient
//
//  Created by David De Bels on 20/05/2021.
//

#import "NotionCheckboxFilter.h"

/// MARK: - NotionCheckboxFilter Class Extension

@interface NotionCheckboxFilter ()

@property (nonatomic, assign, readwrite) NotionFilterType type;
@property (nonatomic, copy, readwrite) NSString *text;

@end

/// MARK: - NotionCheckboxFilter Implementation

@implementation NotionCheckboxFilter

@synthesize type = _type;

/// MARK: Convenience Init

+ (NotionCheckboxFilter *)property:(NSString *)propertyName equals:(BOOL)value {
    return [[self alloc] initWithPropertyName:propertyName type:NotionFilterTypeEquals value:value];
}

+ (NotionCheckboxFilter *)property:(NSString *)propertyName doesNotEqual:(BOOL)value {
    return [[self alloc] initWithPropertyName:propertyName type:NotionFilterTypeDoesNotEqual value:value];
}

/// MARK: Init

- (instancetype)initWithPropertyName:(NSString *)propertyName type:(NotionFilterType)type value:(BOOL)value {
    if (!propertyName) {
        return nil;
    }
    
    self = [self init];
    if (self) {
        _propertyName = propertyName;
        _value = value;
    }
    
    return self;
}

/// MARK: Serialize

- (NSMutableDictionary *)serializedObject {
    NSMutableDictionary *dictionary = [super serializedObject];
    dictionary[@"property"] = self.propertyName;
    
    NSString *key = [NotionHelper stringForFilterType:self.type];
    dictionary[@"checkbox"] = @{
        key: @(self.value)
    };
    
    return dictionary;
}

@end
