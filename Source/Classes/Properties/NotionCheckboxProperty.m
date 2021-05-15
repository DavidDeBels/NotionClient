//
//  NotionCheckboxProperty.m
//  NotionClient
//
//  Created by David De Bels on 14/05/2021.
//

#import "NotionCheckboxProperty.h"

/// MARK: - NotionCheckboxProperty Class Extension

@interface NotionCheckboxProperty ()

@property (nonatomic, copy, readwrite) NSString *name;

@end

/// MARK: - NotionCheckboxProperty Implementation

@implementation NotionCheckboxProperty

@synthesize name = _name;
@synthesize type = _type;

/// MARK: Init

+ (NotionCheckboxProperty *)checkboxWithName:(NSString *)name checked:(BOOL)checked {
    NotionCheckboxProperty *property = [[self alloc] init];
    property.name = name;
    property.checked = checked;
    
    return property;
}

- (instancetype)init {
    self  = [super init];
    if (self) {
        _type = NotionPropertyTypeCheckbox;
    }
    
    return self;
}

- (instancetype)initWithName:(NSString *)name dictionary:(NSDictionary *)dictionary {
    self = [super initWithName:name dictionary:dictionary];
    if (self) {
        _checked = [dictionary numberForKeyOrNil:@"checkbox"].boolValue;
    }
    
    return self;
}

/// MARK: Serialize

- (NSMutableDictionary *)serializedObject {
    NSMutableDictionary *dictionary = [super serializedObject];
    dictionary[@"checkbox"] = @(self.checked);
   
    return dictionary;
}

@end
