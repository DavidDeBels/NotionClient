//
//  NotionMultiSelectProperty.m
//  NotionClient
//
//  Created by David De Bels on 14/05/2021.
//

#import "NotionMultiSelectProperty.h"
#import "NotionSelectOption.h"

/// MARK: - NotionMultiSelectProperty Class Extension

@interface NotionMultiSelectProperty ()

@property (nonatomic, copy, readwrite) NSString *name;

@end

/// MARK: - NotionMultiSelectProperty Implementation

@implementation NotionMultiSelectProperty

@synthesize name = _name;
@synthesize type = _type;

/// MARK: Init

+ (NotionMultiSelectProperty *)multiSelectWithName:(NSString *)name options:(NSArray<NSString *> *)options {
    NSMutableArray *selectOptions = [NSMutableArray new];
    for (NSString *option in options) {
        [selectOptions addObject:[NotionSelectOption optionWithName:option]];
    }
    
    return [self multiSelectWithName:name selectOptions:selectOptions];
}

+ (NotionMultiSelectProperty *)multiSelectWithName:(NSString *)name selectOptions:(NSArray<NotionSelectOption *> *)selectOptions {
    NotionMultiSelectProperty *property = [[self alloc] init];
    property.name = name;
    property.options = selectOptions;
    
    return property;
}

- (instancetype)init {
    self  = [super init];
    if (self) {
        _type = NotionPropertyTypeMultiSelect;
        _options = @[];
    }
    
    return self;
}

- (instancetype)initWithName:(NSString *)name dictionary:(NSDictionary *)dictionary {
    self = [super initWithName:name dictionary:dictionary];
    if (self) {
        NSMutableArray *options = [NSMutableArray new];
        
        NSArray *multiSelectOptions = [dictionary arrayForKeyOrNil:@"multi_select"];
        for (NSDictionary *multiSelectOption in multiSelectOptions) {
            NotionSelectOption *option = [[NotionSelectOption alloc] initWithDictionary:multiSelectOption];
            [options addObject:option];
        }
        _options = [options copy];
    }
    
    return self;
}

/// MARK: Serialize

- (NSMutableDictionary *)serializedObject {
    NSMutableDictionary *dictionary = [super serializedObject];
    
    NSMutableArray *options = [NSMutableArray new];
    for (NotionSelectOption *option in self.options) {
        [options addObject:[option serializedObject]];
    }
    dictionary[@"multi_select"] = options;
   
    return dictionary;
}

@end
