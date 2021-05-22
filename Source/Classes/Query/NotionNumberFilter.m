//
//  NotionNumberFilter.m
//  NotionClient
//
//  Created by David De Bels on 20/05/2021.
//

#import "NotionNumberFilter.h"

/// MARK: - NotionNumberFilter Class Extension

@interface NotionNumberFilter ()

@property (nonatomic, assign, readwrite) NotionFilterType type;

@end

/// MARK: - NotionNumberFilter Implementation

@implementation NotionNumberFilter

@synthesize type = _type;

/// MARK: Convenience Init

+ (NotionNumberFilter *)property:(NSString *)propertyName equals:(NSNumber *)number {
    return [[self alloc] initWithPropertyName:propertyName type:NotionFilterTypeEquals number:number];
}

+ (NotionNumberFilter *)property:(NSString *)propertyName doesNotEqual:(NSNumber *)number {
    return [[self alloc] initWithPropertyName:propertyName type:NotionFilterTypeDoesNotEqual number:number];
}

+ (NotionNumberFilter *)property:(NSString *)propertyName greaterThan:(NSNumber *)number {
    return [[self alloc] initWithPropertyName:propertyName type:NotionFilterTypeGreaterThan number:number];
}

+ (NotionNumberFilter *)property:(NSString *)propertyName greaterThanOrEqualTo:(NSNumber *)number {
    return [[self alloc] initWithPropertyName:propertyName type:NotionFilterTypeGreaterThanOrEqualTo number:number];
}

+ (NotionNumberFilter *)property:(NSString *)propertyName lessThan:(NSNumber *)number {
    return [[self alloc] initWithPropertyName:propertyName type:NotionFilterTypeLessThan number:number];
}

+ (NotionNumberFilter *)property:(NSString *)propertyName lessThanOrEqualTo:(NSNumber *)number {
    return [[self alloc] initWithPropertyName:propertyName type:NotionFilterTypeLessThanOrEqualTo number:number];
}

+ (NotionFilter *)propertyIsEmpty:(NSString *)propertyName {
    return [[self alloc] initWithPropertyName:propertyName type:NotionFilterTypeIsEmpty number:nil];
}

+ (NotionFilter *)propertyIsNotEmpty:(NSString *)propertyName {
    return [[self alloc] initWithPropertyName:propertyName type:NotionFilterTypeIsNotEmpty number:nil];
}

/// MARK: Init

- (instancetype)initWithPropertyName:(NSString *)propertyName type:(NotionFilterType)type number:(NSNumber *)number {
    if (!propertyName) {
        return nil;
    }
    
    self = [self init];
    if (self) {
        _type = type;
        _propertyName = propertyName;
        _number = number;
    }
    
    return self;
}

/// MARK: Serialize

- (NSMutableDictionary *)serializedObject {
    NSMutableDictionary *dictionary = [super serializedObject];
    dictionary[@"property"] = self.propertyName;
    
    NSString *key = [NotionHelper stringForFilterType:self.type];
    if (self.type == NotionFilterTypeIsEmpty || self.type == NotionFilterTypeIsNotEmpty) {
        dictionary[@"number"] = @{
            key: @YES
        };
    } else {
        dictionary[@"number"] = @{
            key: self.number
        };
    }
    
    return dictionary;
}

@end
