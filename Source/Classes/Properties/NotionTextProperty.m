//
//  NotionTextProperty.m
//  NotionClient
//
//  Created by David De Bels on 14/05/2021.
//

#import "NotionTextProperty.h"
#import "NotionProperty+Private.h"
#import "NotionTextPart.h"
#import "NotionRichText.h"

/// MARK: - NotionTextProperty Implementation

@implementation NotionTextProperty

@synthesize type = _type;

/// MARK: Init

+ (NotionTextProperty *)textWithName:(NSString *)name text:(NSString *)text {
    return [self textWithName:name text:text URL:nil color:NotionColorDefault bold:NO italic:NO underline:NO strikethrough:NO code:NO];
}

+ (NotionTextProperty *)textWithName:(NSString *)name text:(NSString *)text URL:(NSURL *)URL {
    return [self textWithName:name text:text URL:URL color:NotionColorDefault bold:NO italic:NO underline:NO strikethrough:NO code:NO];
}

+ (NotionTextProperty *)textWithName:(NSString *)name text:(NSString *)text color:(NotionColor)color {
    return [self textWithName:name text:text URL:nil color:color bold:NO italic:NO underline:NO strikethrough:NO code:NO];
}

+ (NotionTextProperty *)textWithName:(NSString *)name text:(NSString *)text URL:(NSURL *)URL color:(NotionColor)color {
    return [self textWithName:name text:text URL:URL color:color bold:NO italic:NO underline:NO strikethrough:NO code:NO];
}

+ (NotionTextProperty *)textWithName:(NSString *)name text:(NSString *)text URL:(NSURL *)URL color:(NotionColor)color bold:(BOOL)bold italic:(BOOL)italic underline:(BOOL)underline strikethrough:(BOOL)strikethrough code:(BOOL)code {
    NotionRichText *richText = [NotionRichText textWithContent:text URL:URL color:color bold:bold italic:italic underline:underline strikethrough:strikethrough code:code];
    return [self textWithName:name parts:@[richText]];
}

+ (NotionTextProperty *)textWithName:(NSString *)name parts:(NSArray<NotionTextPart *> *)parts {
    NotionTextProperty *property = [[self alloc] init];
    property.name = name;
    property.parts = parts;
    
    return property;
}

- (instancetype)init {
    self  = [super init];
    if (self) {
        _type = NotionPropertyTypeText;
    }
    
    return self;
}

- (instancetype)initWithName:(NSString *)name dictionary:(NSDictionary *)dictionary {
    self = [super initWithName:name dictionary:dictionary];
    if (self) {
        NSMutableArray *parts = [NSMutableArray new];
        
        NSArray *richTexts = [dictionary arrayForKeyOrNil:@"rich_text"];
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

// MARK: Title

- (NSString *)text {
    NSMutableString *title = [NSMutableString new];
    for (NotionTextPart *part in self.parts) {
        [title appendString:part.plainText];
    }
    
    return [title copy];
}

- (void)setText:(NSString *)text {
    NotionRichText *richText = [NotionRichText textWithContent:text];
    self.parts = @[richText];
}

/// MARK: Serialize

- (NSMutableDictionary *)serializedObject {
    NSMutableDictionary *dictionary = [super serializedObject];
    
    NSMutableArray *richTexts = [NSMutableArray new];
    for (NotionTextPart *part in self.parts) {
        [richTexts addObject:[part serializedObject]];
    }
    dictionary[@"rich_text"] = richTexts;
   
    return dictionary;
}

@end
