//
//  NotionEquation.m
//  NotionClient
//
//  Created by David De Bels on 15/05/2021.
//

#import "NotionEquation.h"

/// MARK: NotionEquation Implementation

@implementation NotionEquation

@synthesize type = _type;

/// MARK: Convenience Init

+(NotionEquation *)equationWithExpression:(NSString *)expression {
    NotionEquation *equation = [[self alloc] init];
    equation.expression = expression;
    
    return equation;
}

/// MARK: Init

- (instancetype)init {
    self  = [super init];
    if (self) {
        _type = NotionTextPartTypeEquation;
    }
    
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super initWithDictionary:dictionary];
    if (self) {
        _expression = [[dictionary dictionaryForKeyOrNil:@"equation"] stringForKeyOrNil:@"expression"];
    }
    
    return self;
}

/// MARK: Serialize

- (NSMutableDictionary *)serializedObject {
    NSMutableDictionary *dictionary = [super serializedObject];

    NSMutableDictionary *equation = [NSMutableDictionary new];
    equation[@"expression"] = self.expression ?: NSNull.null;
    dictionary[@"equation"] = equation;
    
    return dictionary;
}

@end
