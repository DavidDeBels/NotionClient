//
//  NotionPersonProperty.m
//  NotionClient
//
//  Created by David De Bels on 14/05/2021.
//

#import "NotionPersonProperty.h"
#import "NotionUser.h"

/// MARK: - NotionPersonProperty Class Extension

@interface NotionPersonProperty ()

@property (nonatomic, copy, readwrite) NSString *name;

@end

/// MARK: - NotionPersonProperty Implementation

@implementation NotionPersonProperty

@synthesize name = _name;
@synthesize type = _type;

/// MARK: Init

+ (NotionPersonProperty *)personWithName:(NSString *)name people:(NSArray<NotionUser *> *)people {
    NotionPersonProperty *property = [[self alloc] init];
    property.name = name;
    property.people = people;
    
    return property;
}

- (instancetype)init {
    self  = [super init];
    if (self) {
        _type = NotionPropertyTypePerson;
    }
    
    return self;
}

- (instancetype)initWithName:(NSString *)name dictionary:(NSDictionary *)dictionary {
    self = [super initWithName:name dictionary:dictionary];
    if (self) {
        NSMutableArray *people = [NSMutableArray new];
        
        NSArray *persons = [dictionary arrayForKeyOrNil:@"people"];
        for (NSDictionary *person in persons) {
            NotionUser *user = [[NotionUser alloc] initWithDictionary:person];
            if (user) {
                [people addObject:user];
            }
        }
        _people = [people copy];
    }
    
    return self;
}

/// MARK: Serialize

- (NSMutableDictionary *)serializedObject {
    NSMutableDictionary *dictionary = [super serializedObject];
    
    NSMutableArray *people = [NSMutableArray new];
    for (NotionUser *user in self.people) {
        [people addObject:[user serializedObject]];
    }
    dictionary[@"people"] = people;

    return dictionary;
}

@end
