//
//  NotionPhoneProperty.m
//  NotionClient
//
//  Created by David De Bels on 14/05/2021.
//

#import "NotionPhoneProperty.h"
#import "NotionProperty+Private.h"

/// MARK: - NotionPhoneProperty Implementation

@implementation NotionPhoneProperty

@synthesize type = _type;

/// MARK: Init

+ (NotionPhoneProperty *)phoneWithName:(NSString *)name phoneNumber:(NSString *)phoneNumber {
    NotionPhoneProperty *property = [[self alloc] init];
    property.name = name;
    property.phoneNumber = phoneNumber;
    
    return property;
}

- (instancetype)init {
    self  = [super init];
    if (self) {
        _type = NotionPropertyTypePhone;
    }
    
    return self;
}

- (instancetype)initWithName:(NSString *)name dictionary:(NSDictionary *)dictionary {
    self = [super initWithName:name dictionary:dictionary];
    if (self) {
        _phoneNumber = [dictionary stringForKeyOrNil:@"phone_number"];
    }
    
    return self;
}

/// MARK: Serialize

- (NSMutableDictionary *)serializedObject {
    NSMutableDictionary *dictionary = [super serializedObject];
    dictionary[@"phone_number"] = self.phoneNumber;
   
    return dictionary;
}

@end
