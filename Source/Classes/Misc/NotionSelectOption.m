//
//  NotionSelectOption.m
//  NotionClient
//
//  Created by David De Bels on 14/05/2021.
//

#import "NotionSelectOption.h"
#import "NSDictionary+NotionClient.h"

/// MARK: - NotionSelectOption Implementation

@implementation NotionSelectOption

/// MARK: Init

+ (NotionSelectOption *)optionWithName:(NSString *)name {
    return [[self alloc] initWithName:name];
}

- (instancetype)init {
    self  = [super init];
    if (self) {
        _color = NotionColorDefault;
    }
    
    return self;
}

- (instancetype)initWithName:(NSString *)name {
    self  = [self init];
    if (self) {
        _name = name;
    }
    
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [self init];
    if (self) {
        _id = [dictionary stringForKeyOrNil:@"id"];
        _name = [dictionary stringForKeyOrNil:@"name"];
        _color = [NotionHelper colorForString:[dictionary stringForKeyOrNil:@"color"]];
    }
    
    return self;
}

/// MARK: Serialize

- (NSMutableDictionary *)serializedObject {
    NSMutableDictionary *dictionary = [NSMutableDictionary new];
    dictionary[@"id"] = self.id;
    dictionary[@"name"] = self.name;
    dictionary[@"color"] = [[NotionHelper stringForColor:self.color] stringByReplacingOccurrencesOfString:@"_background" withString:@""];
   
    return dictionary;
}

@end
