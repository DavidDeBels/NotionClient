//
//  NotionTitleProperty.m
//  NotionClient
//
//  Created by David De Bels on 14/05/2021.
//

#import "NotionTitleProperty.h"
#import "NotionProperty+Private.h"
#import "NotionTextPart.h"
#import "NotionRichText.h"

/// MARK: - NotionTitleProperty Implementation

@implementation NotionTitleProperty

@synthesize type = _type;

/// MARK: Init

+ (NotionTitleProperty *)titleWithName:(NSString *)name title:(NSString *)title {
    NotionRichText *richText = [NotionRichText textWithContent:title];
    return [self titleWithName:name parts:@[richText]];
}

+ (NotionTitleProperty *)titleWithName:(NSString *)name parts:(NSArray<NotionTextPart *> *)parts {
    NotionTitleProperty *property = [[self alloc] init];
    property.name = name;
    property.parts = parts;
    
    return property;
}

- (instancetype)init {
    self  = [super init];
    if (self) {
        _type = NotionPropertyTypeTitle;
    }
    
    return self;
}

- (instancetype)initWithName:(NSString *)name dictionary:(NSDictionary *)dictionary {
    self = [super initWithName:name dictionary:dictionary];
    if (self) {
        NSMutableArray *parts = [NSMutableArray new];
        
        NSArray *richTexts = [dictionary arrayForKeyOrNil:@"title"];
        for (NSDictionary *textPart in richTexts) {
            NSString *type = [textPart stringForKeyOrNil:@"type"];
            Class class = [NotionHelper classForTextPartType:type];
            if (class) {
                NotionTextPart *part = [[class alloc] initWithDictionary:textPart];
                [parts addObject:part];
            }
        }
        _parts = [parts copy];
    }
    
    return self;
}

// MARK: Title Convenience

- (NSString *)plainText {
    NSMutableString *plainText = [NSMutableString new];
    for (NotionTextPart *part in self.parts) {
        [plainText appendString:part.plainText];
    }
    
    return [plainText copy];
}

- (NSString *)title {
    return self.plainText;
}

- (void)setTitle:(NSString *)title {
    NotionRichText *richText = [NotionRichText textWithContent:title];
    self.parts = @[richText];
}

/// MARK: Serialize

- (NSMutableDictionary *)serializedObject {
    NSMutableDictionary *dictionary = [super serializedObject];
    
    NSMutableArray *richTexts = [NSMutableArray new];
    for (NotionTextPart *part in self.parts) {
        [richTexts addObject:[part serializedObject]];
    }
    dictionary[@"title"] = richTexts;
   
    return dictionary;
}

@end
