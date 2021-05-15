//
//  NotionTextPart.m
//  NotionClient
//
//  Created by David De Bels on 15/05/2021.
//

#import "NotionTextPart.h"
#import "NSDictionary+NotionClient.h"

/// MARK: NotionTextPart Implementation

@implementation NotionTextPart

/// MARK: Init

- (instancetype)init {
    self  = [super init];
    if (self) {
        _type = NotionTextPartTypeUnknown;
        _color = NotionColorDefault;
    }
    
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [self init];
    if (self) {
        _type = [NotionHelper textPartTypeForString:[dictionary stringForKeyOrNil:@"type"]];
        
        NSDictionary *annotations = [dictionary dictionaryForKeyOrNil:@"annotations"];
        if (annotations) {
            _bold = [annotations numberForKeyOrNil:@"bold"].boolValue;
            _italic = [annotations numberForKeyOrNil:@"italic"].boolValue;
            _strikethrough = [annotations numberForKeyOrNil:@"strikethrough"].boolValue;
            _underline = [annotations numberForKeyOrNil:@"underline"].boolValue;
            _code = [annotations numberForKeyOrNil:@"code"].boolValue;
            _color = [NotionHelper colorForString:[annotations stringForKeyOrNil:@"color"]];
        }
        
        NSString *urlString = [dictionary stringForKeyOrNil:@"href"];
        if (urlString) {
            _URL = [NSURL URLWithString:urlString];
        }
        
        _plainText = [dictionary stringForKeyOrNil:@"plain_text"];
    }
    
    return self;
}

/// MARK: Serialize

- (NSMutableDictionary *)serializedObject {
    NSMutableDictionary *dictionary = [NSMutableDictionary new];
    dictionary[@"type"] = [NotionHelper stringForTextPartType:self.type];
    dictionary[@"plain_text"] = self.plainText;
    dictionary[@"href"] = self.URL ? self.URL.absoluteString : NSNull.null;
    
    
    NSMutableDictionary *annotations = [NSMutableDictionary new];
    annotations[@"color"] = [NotionHelper stringForColor:self.color];
    if (self.bold) {
        annotations[@"bold"] = @YES;
    }
    if (self.italic) {
        annotations[@"italic"] = @YES;
    }
    if (self.strikethrough) {
        annotations[@"strikethrough"] = @YES;
    }
    if (self.underline) {
        annotations[@"underline"] = @YES;
    }
    if (self.code) {
        annotations[@"code"] = @YES;
    }
    dictionary[@"annotations"] = annotations;
    
    /*
    dictionary[@"annotations"] = @{
        @"bold": @(self.bold),
        @"italic": @(self.italic),
        @"strikethrough": @(self.strikethrough),
        @"underline": @(self.underline),
        @"code": @(self.code),
        @"color": [NotionHelper stringForColor:self.color]
    };
     */
   
    return dictionary;
}

@end
