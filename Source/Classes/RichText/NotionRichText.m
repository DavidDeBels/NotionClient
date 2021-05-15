//
//  NotionRichText.m
//  NotionClient
//
//  Created by David De Bels on 15/05/2021.
//

#import "NotionRichText.h"

/// MARK: NotionRichText Implementation

@implementation NotionRichText

@synthesize type = _type;
@synthesize URL = _URL;

/// MARK: Init

+ (NotionRichText *)textWithContent:(NSString *)content {
    return [self textWithContent:content URL:nil color:NotionColorDefault bold:NO italic:NO underline:NO strikethrough:NO code:NO];
}

+ (NotionRichText *)textWithContent:(NSString *)content URL:(NSURL *)URL {
    return [self textWithContent:content URL:URL color:NotionColorDefault bold:NO italic:NO underline:NO strikethrough:NO code:NO];
}

+ (NotionRichText *)textWithContent:(NSString *)content color:(NotionColor)color {
    return [self textWithContent:content URL:nil color:color bold:NO italic:NO underline:NO strikethrough:NO code:NO];
}

+ (NotionRichText *)textWithContent:(NSString *)content URL:(NSURL *)URL color:(NotionColor)color {
    return [self textWithContent:content URL:URL color:color bold:NO italic:NO underline:NO strikethrough:NO code:NO];
}

+ (NotionRichText *)textWithContent:(NSString *)content URL:(NSURL *)URL color:(NotionColor)color bold:(BOOL)bold italic:(BOOL)italic underline:(BOOL)underline strikethrough:(BOOL)strikethrough code:(BOOL)code {
    NotionRichText *richText = [[self alloc] init];
    richText.content = content;
    richText.plainText = content;
    richText.URL = URL;
    richText.color = color;
    richText.bold = bold;
    richText.italic = italic;
    richText.underline = underline;
    richText.strikethrough = strikethrough;
    richText.code = code;
    
    return richText;
}

- (instancetype)init {
    self  = [super init];
    if (self) {
        _type = NotionTextPartTypeText;
    }
    
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super initWithDictionary:dictionary];
    if (self) {
        _content = [[dictionary dictionaryForKeyOrNil:@"text"] stringForKeyOrNil:@"content"];
    }
    
    return self;
}

/// MARK: Serialize

- (NSMutableDictionary *)serializedObject {
    NSMutableDictionary *dictionary = [super serializedObject];

    NSMutableDictionary *text = [NSMutableDictionary new];
    text[@"content"] = self.content ?: NSNull.null;
    if (self.URL) {
        text[@"link"] = @{
            @"url": self.URL.absoluteString
        };
    }
    dictionary[@"text"] = text;
    
    return dictionary;
}

@end
