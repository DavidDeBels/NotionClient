//
//  NotionTextFilter.m
//  NotionClient
//
//  Created by David De Bels on 20/05/2021.
//

#import "NotionTextFilter.h"

/// MARK: - NotionTextFilter Class Extension

@interface NotionTextFilter ()

@end

/// MARK: - NotionTextFilter Implementation

@implementation NotionTextFilter

@synthesize type = _type;

/// MARK: Convenience Init

+ (NotionTextFilter *)property:(NSString *)propertyName equals:(NSString *)text {
    return [[self alloc] initWithPropertyName:propertyName type:NotionFilterTypeEquals text:text];
}

+ (NotionTextFilter *)property:(NSString *)propertyName doesNotEqual:(NSString *)text {
    return [[self alloc] initWithPropertyName:propertyName type:NotionFilterTypeDoesNotEqual text:text];
}

+ (NotionTextFilter *)property:(NSString *)propertyName contains:(NSString *)text {
    return [[self alloc] initWithPropertyName:propertyName type:NotionFilterTypeContains text:text];
}

+ (NotionTextFilter *)property:(NSString *)propertyName doesNotContain:(NSString *)text {
    return [[self alloc] initWithPropertyName:propertyName type:NotionFilterTypeDoesNotContain text:text];
}

+ (NotionTextFilter *)property:(NSString *)propertyName startsWith:(NSString *)text {
    return [[self alloc] initWithPropertyName:propertyName type:NotionFilterTypeStartsWith text:text];
}

+ (NotionTextFilter *)property:(NSString *)propertyName endsWith:(NSString *)text {
    return [[self alloc] initWithPropertyName:propertyName type:NotionFilterTypeEndsWith text:text];
}

+ (NotionFilter *)propertyIsEmpty:(NSString *)propertyName {
    return [[self alloc] initWithPropertyName:propertyName type:NotionFilterTypeIsEmpty text:nil];
}

+ (NotionFilter *)propertyIsNotEmpty:(NSString *)propertyName {
    return [[self alloc] initWithPropertyName:propertyName type:NotionFilterTypeIsNotEmpty text:nil];
}

/// MARK: Init

- (instancetype)initWithPropertyName:(NSString *)propertyName type:(NotionFilterType)type text:(NSString *)text {
    if (!propertyName) {
        return nil;
    }
    
    self = [self init];
    if (self) {
        _type = type;
        _propertyName = propertyName;
        _text = text;
    }
    
    return self;
}

/// MARK: Serialize

- (NSMutableDictionary *)serializedObject {
    NSMutableDictionary *dictionary = [super serializedObject];
    dictionary[@"property"] = self.propertyName;
    
    NSString *key = [NotionHelper stringForFilterType:self.type];
    if (self.type == NotionFilterTypeIsEmpty || self.type == NotionFilterTypeIsNotEmpty) {
        dictionary[@"text"] = @{
            key: @YES
        };
    } else {
        dictionary[@"text"] = @{
            key: self.text
        };
    }
    
    return dictionary;
}

@end
