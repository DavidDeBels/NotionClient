//
//  NotionURLProperty.m
//  NotionClient
//
//  Created by David De Bels on 14/05/2021.
//

#import "NotionURLProperty.h"
#import "NotionProperty+Private.h"

/// MARK: - NotionURLProperty Implementation

@implementation NotionURLProperty

@synthesize type = _type;

/// MARK: Init

+ (NotionURLProperty *)urlWithName:(NSString *)name URL:(NSURL *)URL {
    NotionURLProperty *property = [[self alloc] init];
    property.name = name;
    property.URL = URL;
    
    return property;
}

- (instancetype)init {
    self  = [super init];
    if (self) {
        _type = NotionPropertyTypeURL;
    }
    
    return self;
}

- (instancetype)initWithName:(NSString *)name dictionary:(NSDictionary *)dictionary {
    self = [super initWithName:name dictionary:dictionary];
    if (self) {
        NSString *urlString = [dictionary stringForKeyOrNil:@"url"];
        if (urlString) {
            _URL = [NSURL URLWithString:urlString];
        }
    }
    
    return self;
}

/// MARK: Serialize

- (NSMutableDictionary *)serializedObject {
    NSMutableDictionary *dictionary = [super serializedObject];
    dictionary[@"url"] = self.URL ? self.URL.absoluteString : nil;
   
    return dictionary;
}

@end
