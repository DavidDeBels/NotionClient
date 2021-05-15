//
//  NotionNumberProperty.m
//  NotionClient
//
//  Created by David De Bels on 14/05/2021.
//

#import "NotionNumberProperty.h"

/// MARK: - NotionNumberProperty Class Extension

@interface NotionNumberProperty ()

@property (nonatomic, copy, readwrite) NSString *name;

@end

/// MARK: - NotionNumberProperty Implementation

@implementation NotionNumberProperty

@synthesize name = _name;
@synthesize type = _type;

/// MARK: Init

+ (NotionNumberProperty *)numberWithName:(NSString *)name number:(NSNumber *)number {
    NotionNumberProperty *property = [[self alloc] init];
    property.name = name;
    property.number = number;
    
    return property;
}

- (instancetype)init {
    self  = [super init];
    if (self) {
        _type = NotionPropertyTypeNumber;
        _format = NotionNumberFormatNumber;
    }
    
    return self;
}

- (instancetype)initWithName:(NSString *)name dictionary:(NSDictionary *)dictionary {
    self = [super initWithName:name dictionary:dictionary];
    if (self) {
        _number = [NotionHelper.numberFormatter numberFromString:[dictionary stringForKeyOrNil:@"number"]];
        _format = [NotionHelper numberFormatForString:[dictionary stringForKeyOrNil:@"format"]];
    }
    
    return self;
}

/// MARK: Serialize

- (NSMutableDictionary *)serializedObject {
    NSMutableDictionary *dictionary = [super serializedObject];
    dictionary[@"number"] = self.number ? self.number : NSNull.null;
   
    return dictionary;
}

@end
