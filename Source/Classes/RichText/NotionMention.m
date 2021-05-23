//
//  NotionMention.m
//  NotionClient
//
//  Created by David De Bels on 15/05/2021.
//

#import "NotionMention.h"
#import "NotionUser.h"
#import "NotionPage.h"
#import "NotionDate.h"

/// MARK: NotionMention Class Extention

@interface NotionMention ()

@property (nonatomic, assign, readwrite) NotionMentionType mentionType;

@end

/// MARK: NotionMention Implementation

@implementation NotionMention

@synthesize type = _type;

/// MARK: Connnvenience Init

+ (NotionMention *)mentionWithUser:(NotionUser *)user {
    NotionMention *mention = [[NotionMention alloc] init];
    mention.mentionType = NotionMentionTypeUser;
    mention.user = user;
    
    return mention;
}

+ (NotionMention *)mentionWithDate:(NotionDate *)date {
    NotionMention *mention = [[NotionMention alloc] init];
    mention.mentionType = NotionMentionTypeDate;
    mention.date = date;
    
    return mention;
}

+ (NotionMention *)mentionWithPage:(NotionPage *)page {
    NotionMention *mention = [[NotionMention alloc] init];
    mention.mentionType = NotionMentionTypePage;
    mention.pageId = page.id;
    
    return mention;
}

+ (NotionMention *)mentionWithPageId:(NSString *)pageId {
    NotionMention *mention = [[NotionMention alloc] init];
    mention.mentionType = NotionMentionTypePage;
    mention.pageId = pageId;
    
    return mention;
}

+ (NotionMention *)mentionWithDatabaseId:(NSString *)databaseId {
    NotionMention *mention = [[NotionMention alloc] init];
    mention.mentionType = NotionMentionTypeDatabase;
    mention.databaseId = databaseId;
    
    return mention;
}

/// MARK: Init

- (instancetype)init {
    self  = [super init];
    if (self) {
        _type = NotionTextPartTypeMention;
        _mentionType = NotionMentionTypeUnknown;
    }
    
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super initWithDictionary:dictionary];
    if (self) {
        NSDictionary *mention = [dictionary dictionaryForKeyOrNil:@"mention"];
        
        _mentionType = [NotionHelper mentionTypeForString:[mention stringForKeyOrNil:@"type"]];
        
        if (_mentionType == NotionMentionTypeUser) {
            _user = [[NotionUser alloc] initWithDictionary:[mention dictionaryForKeyOrNil:@"user"]];
        } else if (_mentionType == NotionMentionTypePage) {
            _pageId = [NotionHelper idToUUID:[[mention dictionaryForKeyOrNil:@"page"] stringForKeyOrNil:@"id"]];
        } else if (_mentionType == NotionMentionTypeDatabase) {
            _databaseId = [NotionHelper idToUUID:[[mention dictionaryForKeyOrNil:@"database"] stringForKeyOrNil:@"id"]];
        } else if (_mentionType == NotionMentionTypeDate) {
            _date = [[NotionDate alloc] initWithDictionary:[mention dictionaryForKeyOrNil:@"date"]];
        }
    }
    
    return self;
}

/// MARK: Getters & Setters

- (void)setUser:(NotionUser *)user {
    _user = user;
    _mentionType = NotionMentionTypeUser;
    
    _pageId = nil;
    _databaseId = nil;
    _date = nil;
    
    self.color = NotionColorGray;
}

- (void)setDate:(NotionDate *)date {
    _date = date;
    _mentionType = NotionMentionTypeDate;
    
    _user = nil;
    _pageId = nil;
    _databaseId = nil;
    
    self.color = NotionColorGray;
}

- (void)setPageId:(NSString *)pageId {
    _pageId = [NotionHelper idToUUID:pageId];
    _mentionType = NotionMentionTypePage;
    
    _user = nil;
    _databaseId = nil;
    _date = nil;
    
    self.color = NotionColorDefault;
}

- (void)setDatabaseId:(NSString *)databaseId {
    _databaseId = [NotionHelper idToUUID:databaseId];
    _mentionType = NotionMentionTypeDatabase;
    
    _user = nil;
    _pageId = nil;
    _date = nil;
    
    self.color = NotionColorDefault;
}

/// MARK: Serialize

- (NSMutableDictionary *)serializedObject {
    NSMutableDictionary *dictionary = [super serializedObject];

    NSMutableDictionary *mention = [NSMutableDictionary new];
    if (self.mentionType == NotionMentionTypeUser) {
        [mention setObject:[self.user serializedObject] forKey:@"user"];
    } else if (self.mentionType == NotionMentionTypePage) {
        [mention setObject:@{ @"id": self.pageId } forKey:@"page"];
    } else if (self.mentionType == NotionMentionTypeDatabase) {
        [mention setObject:@{ @"id": self.databaseId } forKey:@"database"];
    } else if (self.mentionType == NotionMentionTypeDate) {
        [mention setObject:[self.date serializedObject] forKey:@"date"];
    }
    dictionary[@"mention"] = mention;
    
    return dictionary;
}

@end
