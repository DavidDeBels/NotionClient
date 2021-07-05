//
//  NotionEmailProperty.m
//  NotionClient
//
//  Created by David De Bels on 14/05/2021.
//

#import "NotionEmailProperty.h"
#import "NotionProperty+Private.h"

/// MARK: - NotionEmailProperty Implementation

@implementation NotionEmailProperty

@synthesize type = _type;

/// MARK: Init

+ (NotionEmailProperty *)emailWithName:(NSString *)name email:(NSString *)email {
    NotionEmailProperty *property = [[self alloc] init];
    property.name = name;
    property.email = email;
    
    return property;
}

- (instancetype)init {
    self  = [super init];
    if (self) {
        _type = NotionPropertyTypeEmail;
    }
    
    return self;
}

- (instancetype)initWithName:(NSString *)name dictionary:(NSDictionary *)dictionary {
    self = [super initWithName:name dictionary:dictionary];
    if (self) {
        _email = [dictionary stringForKeyOrNil:@"email"];
    }
    
    return self;
}

/// MARK: Serialize

- (NSMutableDictionary *)serializedObject {
    NSMutableDictionary *dictionary = [super serializedObject];
    dictionary[@"email"] = self.email;
   
    return dictionary;
}

@end
