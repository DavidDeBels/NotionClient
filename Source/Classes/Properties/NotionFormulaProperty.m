//
//  NotionFormulaProperty.m
//  NotionClient
//
//  Created by David De Bels on 14/05/2021.
//

#import "NotionFormulaProperty.h"

/// MARK: - NotionFormulaProperty Class Extension

@interface NotionFormulaProperty ()

@property (nonatomic, copy, readwrite) NSString *name;

@end

/// MARK: - NotionFormulaProperty Implementation

@implementation NotionFormulaProperty

@synthesize name = _name;
@synthesize type = _type;

/// MARK: Init

- (instancetype)init {
    self  = [super init];
    if (self) {
        _type = NotionPropertyTypeFormula;
    }
    
    return self;
}

- (instancetype)initWithName:(NSString *)name dictionary:(NSDictionary *)dictionary {
    self = [super initWithName:name dictionary:dictionary];
    if (self) {
        NSDictionary *formula = [dictionary dictionaryForKeyOrNil:@"formula"];
        _resultType = [NotionHelper formulaTypeForString:[formula stringForKeyOrNil:@"type"]];
        
        if (_resultType == NotionFormulaTypeText) {
            _textResult = [formula stringForKeyOrNil:@"string"];
        } else if (_resultType == NotionFormulaTypeNumber) {
            _numberResult = [formula numberForKeyOrNil:@"number"];
        } else if (_resultType == NotionFormulaTypeDate) {
            _startDateResult = [NotionHelper dateFromString:[[formula dictionaryForKeyOrNil:@"date"] stringForKeyOrNil:@"start"]];
            _endDateResult = [NotionHelper dateFromString:[[formula dictionaryForKeyOrNil:@"date"] stringForKeyOrNil:@"end"]];
        } else if (_resultType == NotionFormulaTypeBoolean) {
            _boolResult = [formula numberForKeyOrNil:@"boolean"].boolValue;
        }
    }
    
    return self;
}

/// MARK: Serialize

- (NSMutableDictionary *)serializedObject {
    NSMutableDictionary *dictionary = [super serializedObject];
    return dictionary;
}

@end
