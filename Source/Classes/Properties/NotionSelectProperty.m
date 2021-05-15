//
//  NotionSelectProperty.m
//  NotionClient
//
//  Created by David De Bels on 14/05/2021.
//

#import "NotionSelectProperty.h"
#import "NotionSelectOption.h"

/// MARK: - NotionSelectProperty Class Extension

@interface NotionSelectProperty ()

@property (nonatomic, copy, readwrite) NSString *name;

@end

/// MARK: - NotionSelectProperty Implementation

@implementation NotionSelectProperty

@synthesize name = _name;
@synthesize type = _type;

/// MARK: Init

+ (NotionSelectProperty *)selectWithName:(NSString *)name option:(NSString *)option {
    NotionSelectOption *selectOption = [NotionSelectOption optionWithName:option];
    return [self selectWithName:name selectOption:selectOption];
}

+ (NotionSelectProperty *)selectWithName:(NSString *)name selectOption:(NotionSelectOption *)selectOption {
    NotionSelectProperty *property = [[self alloc] init];
    property.name = name;
    property.option = selectOption;
    
    return property;
}

- (instancetype)init {
    self  = [super init];
    if (self) {
        _type = NotionPropertyTypeSelect;
    }
    
    return self;
}

- (instancetype)initWithName:(NSString *)name dictionary:(NSDictionary *)dictionary {
    self = [super initWithName:name dictionary:dictionary];
    if (self) {
        NSDictionary *selectOption = [dictionary dictionaryForKeyOrNil:@"select"];
        _option = [[NotionSelectOption alloc] initWithDictionary:selectOption];
    }
    
    return self;
}

/// MARK: Serialize

- (NSMutableDictionary *)serializedObject {
    NSMutableDictionary *dictionary = [super serializedObject];
    dictionary[@"select"] = [self.option serializedObject];
   
    return dictionary;
}

@end
