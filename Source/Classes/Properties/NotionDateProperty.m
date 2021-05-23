//
//  NotionDateProperty.m
//  NotionClient
//
//  Created by David De Bels on 14/05/2021.
//

#import "NotionDateProperty.h"
#import "NotionDate.h"

/// MARK: - NotionDateProperty Class Extension

@interface NotionDateProperty ()

@property (nonatomic, copy, readwrite) NSString *name;

@end

/// MARK: - NotionDateProperty Implementation

@implementation NotionDateProperty

@synthesize name = _name;
@synthesize type = _type;

/// MARK: Init

+ (NotionDateProperty *)dateWithName:(NSString *)name date:(NotionDate *)date {
    NotionDateProperty *property = [[self alloc] init];
    property.name = name;
    property.date = date;
    
    return property;
}

- (instancetype)init {
    self  = [super init];
    if (self) {
        _type = NotionPropertyTypeDate;
    }
    
    return self;
}

- (instancetype)initWithName:(NSString *)name dictionary:(NSDictionary *)dictionary {
    self = [super initWithName:name dictionary:dictionary];
    if (self) {
        _date = [[NotionDate alloc] initWithDictionary:[dictionary dictionaryForKeyOrNil:@"date"]];
    }
    
    return self;
}

/// MARK: Serialize

- (NSMutableDictionary *)serializedObject {
    NSMutableDictionary *dictionary = [super serializedObject];

    NSDictionary *serializedDate = self.date.serializedObject;
    dictionary[@"date"] = serializedDate.count > 0 ? serializedDate : NSNull.null;
    
    return dictionary;
}

@end
