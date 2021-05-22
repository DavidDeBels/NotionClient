//
//  NotionMultiSelectFilter.m
//  NotionClient
//
//  Created by David De Bels on 20/05/2021.
//

#import "NotionMultiSelectFilter.h"

/// MARK: - NotionMultiSelectFilter Implementation

@implementation NotionMultiSelectFilter

@synthesize type = _type;

/// MARK: Convenience Init

+ (NotionMultiSelectFilter *)property:(NSString *)propertyName contains:(NSString *)text {
    return [[self alloc] initWithPropertyName:propertyName type:NotionFilterTypeContains text:text];
}

+ (NotionMultiSelectFilter *)property:(NSString *)propertyName doesNotContain:(NSString *)text {
    return [[self alloc] initWithPropertyName:propertyName type:NotionFilterTypeDoesNotContain text:text];
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
        dictionary[@"multi_select"] = @{
            key: @YES
        };
    } else {
        dictionary[@"multi_select"] = @{
            key: self.text
        };
    }
    
    return dictionary;
}

@end
