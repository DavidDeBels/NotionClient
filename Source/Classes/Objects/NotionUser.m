//
//  NotionUser.m
//  NotionClient
//
//  Created by David De Bels on 14/05/2021.
//

#import "NotionUser.h"

/// MARK: NotionUser Implementation

@implementation NotionUser

@synthesize object = _object;

/// MARK: Init

- (instancetype)init {
    self  = [super init];
    if (self) {
        _object = NotionObjectTypeUser;
    }
    
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super initWithDictionary:dictionary];
    if (self) {
        _name = [dictionary stringForKeyOrNil:@"name"];
        _type = [NotionHelper userTypeForString:[dictionary stringForKeyOrNil:@"type"]];
        _email = [[dictionary dictionaryForKeyOrNil:@"person"] stringForKeyOrNil:@"email"];
    
        NSString *avatarUrl = [dictionary stringForKeyOrNil:@"avatar_url"];
        if (avatarUrl) {
            _avatarURL = [NSURL URLWithString:avatarUrl];
        }
    }
    
    return self;
}

/// MARK: Serialize

- (NSMutableDictionary *)serializedObject {
    NSMutableDictionary *dictionary = [super serializedObject];
    
    dictionary[@"name"] = self.name;
    dictionary[@"type"] = [NotionHelper stringForUserType:self.type];
    dictionary[@"avatar_url"] = self.avatarURL ? self.avatarURL.absoluteString : nil;
   
    if (self.type == NotionUserTypePerson) {
        dictionary[@"person"] = [NSMutableDictionary new];
        dictionary[@"person"][@"email"] = self.email;
    } else if (self.type == NotionUserTypeBot) {
        dictionary[@"bot"] = @{};
    }
    
    return dictionary;
}

@end
