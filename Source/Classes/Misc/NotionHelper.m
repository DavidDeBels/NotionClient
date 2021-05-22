//
//  NotionHelper.m
//  NotionClient
//
//  Created by David De Bels on 14/05/2021.
//

#import "NotionHelper.h"

#import "NotionUser.h"
#import "NotionPage.h"

#import "NotionTitleProperty.h"
#import "NotionTextProperty.h"
#import "NotionNumberProperty.h"
#import "NotionCheckboxProperty.h"
#import "NotionDateProperty.h"
#import "NotionPersonProperty.h"
#import "NotionSelectProperty.h"
#import "NotionMultiSelectProperty.h"
#import "NotionURLProperty.h"
#import "NotionEmailProperty.h"
#import "NotionPhoneProperty.h"
#import "NotionRelationProperty.h"
#import "NotionFormulaProperty.h"

/// MARK: - NotionHelper Implementation

@implementation NotionHelper

/// MARK: Parent Types

+ (NotionParentType)parentTypeForString:(NSString *)string {
    if ([string isEqualToString:@"workspace"]) {
        return NotionParentTypeWorkspace;
    } else if ([string isEqualToString:@"database_id"]) {
        return NotionParentTypeDatabase;
    } else if ([string isEqualToString:@"page_id"]) {
        return NotionParentTypePage;
    }
    
    return NotionParentTypeUnknown;
}

+ (NSString *)stringForParentType:(NotionParentType)parentType {
    switch (parentType) {
        case NotionParentTypeWorkspace:
            return @"workspace";
        case NotionParentTypeDatabase:
            return @"database_id";
        case NotionParentTypePage:
            return @"page_id";
        default:
            return nil;
    }
}

/// MARK: Object Types

+ (NotionObjectType)objectTypeForString:(NSString *)string {
    if ([string isEqualToString:@"user"]) {
        return NotionObjectTypeUser;
    } else if ([string isEqualToString:@"page"]) {
        return NotionObjectTypePage;
    }
    
    return NotionObjectTypeUnknown;
}

+ (NSString *)stringForObjectType:(NotionObjectType)objectType {
    switch (objectType) {
        case NotionObjectTypeUser:
            return @"user";
        case NotionObjectTypePage:
            return @"page";
        default:
            return nil;
    }
}

+ (Class)classForObjectType:(NSString *)objectType {
    if ([objectType isEqualToString:@"user"]) {
        return NotionUser.class;
    } else if ([objectType isEqualToString:@"page"]) {
        return NotionPage.class;
    } else if ([objectType isEqualToString:@"database"]) {
        
    }
    
    return nil;
}

/// MARK: User Types

+ (NotionUserType)userTypeForString:(NSString *)string {
    if ([string isEqualToString:@"person"]) {
        return NotionUserTypePerson;
    } else if ([string isEqualToString:@"bot"]) {
        return NotionUserTypeBot;
    }
    
    return NotionUserTypeUnknown;
}

+ (NSString *)stringForUserType:(NotionUserType)userType {
    switch (userType) {
        case NotionUserTypePerson:
            return @"person";
        case NotionUserTypeBot:
            return @"bot";
        default:
            return nil;
    }
}

/// MARK: Property Types

+ (NotionPropertyType)propertyTypeForString:(NSString *)string {
    if ([string isEqualToString:@"title"]) {
        return NotionPropertyTypeTitle;
    } else if ([string isEqualToString:@"rich_text"]) {
        return NotionPropertyTypeText;
    } else if ([string isEqualToString:@"number"]) {
        return NotionPropertyTypeNumber;
    } else if ([string isEqualToString:@"select"]) {
        return NotionPropertyTypeSelect;
    } else if ([string isEqualToString:@"multi_select"]) {
        return NotionPropertyTypeMultiSelect;
    } else if ([string isEqualToString:@"date"]) {
        return NotionPropertyTypeDate;
    } else if ([string isEqualToString:@"people"]) {
        return NotionPropertyTypePerson;
    } else if ([string isEqualToString:@"url"]) {
        return NotionPropertyTypeURL;
    } else if ([string isEqualToString:@"email"]) {
        return NotionPropertyTypeEmail;
    } else if ([string isEqualToString:@"phone_number"]) {
        return NotionPropertyTypePhone;
    } else if ([string isEqualToString:@"relation"]) {
        return NotionPropertyTypeRelation;
    } else if ([string isEqualToString:@"formula"]) {
        return NotionPropertyTypeFormula;
    } else if ([string isEqualToString:@"rollup"]) {
        return NotionPropertyTypeRollup;
    }
    
    return NotionPropertyTypeUnknown;
}

+ (NSString *)stringForPropertyType:(NotionPropertyType)propertyType {
    switch (propertyType) {
        case NotionPropertyTypeTitle:
            return @"title";
        case NotionPropertyTypeText:
            return @"rich_text";
        case NotionPropertyTypeNumber:
            return @"number";
        case NotionPropertyTypeSelect:
            return @"select";
        case NotionPropertyTypeMultiSelect:
            return @"multi_select";
        case NotionPropertyTypeDate:
            return @"date";
        case NotionPropertyTypePerson:
            return @"people";
        case NotionPropertyTypeURL:
            return @"url";
        case NotionPropertyTypeEmail:
            return @"email";
        case NotionPropertyTypePhone:
            return @"phone_number";
        case NotionPropertyTypeRelation:
            return @"relation";
        case NotionPropertyTypeFormula:
            return @"formula";
        case NotionPropertyTypeRollup:
            return @"rollup";
        default:
            return nil;
    }
    
    // Options "title", "rich_text", "number", "select", "multi_select", "date", "people", "file", "checkbox", "url", "email", "phone_number", "formula", "relation", "rollup", "created_time", "created_by", "last_edited_time", "last_edited_by"
}

+ (Class)classForPropertyType:(NSString *)propertyType {
    if ([propertyType isEqualToString:@"title"]) {
        return NotionTitleProperty.class;
    } else if ([propertyType isEqualToString:@"rich_text"]) {
        return NotionTextProperty.class;
    } else if ([propertyType isEqualToString:@"number"]) {
        return NotionNumberProperty.class;
    } else if ([propertyType isEqualToString:@"select"]) {
        return NotionSelectProperty.class;
    } else if ([propertyType isEqualToString:@"multi_select"]) {
        return NotionMultiSelectProperty.class;
    } else if ([propertyType isEqualToString:@"date"]) {
        return NotionDateProperty.class;
    } else if ([propertyType isEqualToString:@"people"]) {
        return NotionPersonProperty.class;
    } else if ([propertyType isEqualToString:@"checkbox"]) {
        return NotionCheckboxProperty.class;
    } else if ([propertyType isEqualToString:@"url"]) {
        return NotionURLProperty.class;
    } else if ([propertyType isEqualToString:@"email"]) {
        return NotionEmailProperty.class;
    } else if ([propertyType isEqualToString:@"phone_number"]) {
        return NotionPhoneProperty.class;
    } else if ([propertyType isEqualToString:@"relation"]) {
        return NotionRelationProperty.class;
    } else if ([propertyType isEqualToString:@"formula"]) {
        return NotionFormulaProperty.class;
    }

    return nil;
}

/// MARK: Number Format

+ (NotionNumberFormat)numberFormatForString:(NSString *)string {
    if ([string isEqualToString:@"number"]) {
        return NotionNumberFormatNumber;
    } else if ([string isEqualToString:@"number_with_commas"]) {
        return NotionNumberFormatNumberWithCommas;
    } else if ([string isEqualToString:@"percent"]) {
        return NotionNumberFormatPercent;
    } else if ([string isEqualToString:@"dollar"]) {
        return NotionNumberFormatDollar;
    } else if ([string isEqualToString:@"euro"]) {
        return NotionNumberFormatEuro;
    } else if ([string isEqualToString:@"pound"]) {
        return NotionNumberFormatPound;
    } else if ([string isEqualToString:@"yen"]) {
        return NotionNumberFormatYen;
    } else if ([string isEqualToString:@"ruble"]) {
        return NotionNumberFormatRuble;
    } else if ([string isEqualToString:@"rupee"]) {
        return NotionNumberFormatRupee;
    } else if ([string isEqualToString:@"won"]) {
        return NotionNumberFormatWon;
    } else if ([string isEqualToString:@"yuan"]) {
        return NotionNumberFormatYuan;
    }
    
    return NotionNumberFormatNumber;
}

+ (NSString *)stringForNumberFormat:(NotionNumberFormat)numberFormat {
    switch (numberFormat) {
        case NotionNumberFormatNumber:
            return @"number";
        case NotionNumberFormatNumberWithCommas:
            return @"number_with_commas";
        case NotionNumberFormatPercent:
            return @"percent";
        case NotionNumberFormatDollar:
            return @"dollar";
        case NotionNumberFormatEuro:
            return @"euro";
        case NotionNumberFormatPound:
            return @"pound";
        case NotionNumberFormatYen:
            return @"yen";
        case NotionNumberFormatRuble:
            return @"ruble";
        case NotionNumberFormatRupee:
            return @"rupee";
        case NotionNumberFormatWon:
            return @"won";
        case NotionNumberFormatYuan:
            return @"yuan";
        default:
            return @"number";
    }
}

/// MARK:Color

+ (NotionColor)colorForString:(NSString *)string {
    string = string.lowercaseString;
    
    if ([string isEqualToString:@"gray"]) {
        return NotionColorGray;
    } else if ([string isEqualToString:@"brown"]) {
        return NotionColorBrown;
    } else if ([string isEqualToString:@"orange"]) {
        return NotionColorOrange;
    } else if ([string isEqualToString:@"yellow"]) {
        return NotionColorYellow;
    } else if ([string isEqualToString:@"green"]) {
        return NotionColorGreen;
    } else if ([string isEqualToString:@"blue"]) {
        return NotionColorBlue;
    } else if ([string isEqualToString:@"purple"]) {
        return NotionColorPurple;
    } else if ([string isEqualToString:@"pink"]) {
        return NotionColorPink;
    } else if ([string isEqualToString:@"red"]) {
        return NotionColorRed;
    } else if ([string isEqualToString:@"gray_background"]) {
        return NotionColorGrayBackground;
    } else if ([string isEqualToString:@"brown_background"]) {
        return NotionColorBrownBackground;
    } else if ([string isEqualToString:@"orange_background"]) {
        return NotionColorOrangeBackground;
    } else if ([string isEqualToString:@"yellow_background"]) {
        return NotionColorYellowBackground;
    } else if ([string isEqualToString:@"green_background"]) {
        return NotionColorGreenBackground;
    } else if ([string isEqualToString:@"blue_background"]) {
        return NotionColorBlueBackground;
    } else if ([string isEqualToString:@"purple_background"]) {
        return NotionColorPurpleBackground;
    } else if ([string isEqualToString:@"pink_background"]) {
        return NotionColorPinkBackground;
    } else if ([string isEqualToString:@"red_background"]) {
        return NotionColorRedBackground;
    }
    
    return NotionColorDefault;
}

+ (NSString *)stringForColor:(NotionColor)notionColor {
    switch (notionColor) {
        case NotionColorGray:
            return @"gray";
        case NotionColorBrown:
            return @"brown";
        case NotionColorOrange:
            return @"orange";
        case NotionColorYellow:
            return @"yellow";
        case NotionColorGreen:
            return @"green";
        case NotionColorBlue:
            return @"blue";
        case NotionColorPurple:
            return @"purple";
        case NotionColorPink:
            return @"pink";
        case NotionColorRed:
            return @"red";
        case NotionColorBrownBackground:
            return @"brown_background";
        case NotionColorOrangeBackground:
            return @"orange_background";
        case NotionColorYellowBackground:
            return @"yellow_background";
        case NotionColorGreenBackground:
            return @"green_background";
        case NotionColorBlueBackground:
            return @"blue_background";
        case NotionColorPurpleBackground:
            return @"purple_background";
        case NotionColorPinkBackground:
            return @"pink_background";
        case NotionColorRedBackground:
            return @"red_background";
        default:
            return @"default";
    }
}

/// MARK: Rich Text Type

+ (NotionTextPartType)textPartTypeForString:(NSString *)string {
    if ([string isEqualToString:@"mention"]) {
        return NotionTextPartTypeMention;
    } else if ([string isEqualToString:@"equation"]) {
        return NotionTextPartTypeEquation;
    }
    
    return NotionTextPartTypeText;
}

+ (NSString *)stringForTextPartType:(NotionTextPartType)richTextType {
    switch (richTextType) {
        case NotionTextPartTypeMention:
            return @"mention";
        case NotionTextPartTypeEquation:
            return @"equation";
        default:
            return @"text";
    }
}

/// MARK: Formula Type

+ (NotionFormulaType)formulaTypeForString:(NSString *)string {
    if ([string isEqualToString:@"string"]) {
        return NotionFormulaTypeText;
    } else if ([string isEqualToString:@"number"]) {
        return NotionFormulaTypeNumber;
    } else if ([string isEqualToString:@"date"]) {
        return NotionFormulaTypeDate;
    } else if ([string isEqualToString:@"boolean"]) {
        return NotionFormulaTypeBoolean;
    }
    
    return NotionFormulaTypeText;
}

+ (NSString *)stringForFormulaType:(NotionFormulaType)formulaType {
    switch (formulaType) {
        case NotionFormulaTypeText:
            return @"string";
        case NotionFormulaTypeNumber:
            return @"number";
        case NotionFormulaTypeDate:
            return @"date";
        case NotionFormulaTypeBoolean:
            return @"boolean";
        default:
            return @"string";
    }
}

/// MARK: Filter Type

+ (NSString *)stringForFilterType:(NotionFilterType)filterType {
    switch (filterType) {
        case NotionFilterTypeIsEmpty:
            return @"is_empty";
        case NotionFilterTypeIsNotEmpty:
            return @"is_not_empty";
        case NotionFilterTypeGroupOr:
            return @"or";
        case NotionFilterTypeGroupAnd:
            return @"and";
        case NotionFilterTypeEquals:
            return @"equals";
        case NotionFilterTypeDoesNotEqual:
            return @"does_not_equal";
        case NotionFilterTypeContains:
            return @"contains";
        case NotionFilterTypeDoesNotContain:
            return @"does_not_contain";
        case NotionFilterTypeStartsWith:
            return @"starts_with";
        case NotionFilterTypeEndsWith:
            return @"ends_with";
        case NotionFilterTypeGreaterThan:
            return @"greater_than";
        case NotionFilterTypeGreaterThanOrEqualTo:
            return @"greater_than_or_equal_to";
        case NotionFilterTypeLessThan:
            return @"less_than";
        case NotionFilterTypeLessThanOrEqualTo:
            return @"less_than_or_equal_to";
        default:
            return nil;
    }
}

/// MARK: Cached Formatters

static NSISO8601DateFormatter *_dateFormatter = nil;
+ (NSISO8601DateFormatter *)dateFormatter {
    if (!_dateFormatter) {
        _dateFormatter = [[NSISO8601DateFormatter alloc] init];
        _dateFormatter.formatOptions = NSISO8601DateFormatWithInternetDateTime | NSISO8601DateFormatWithFractionalSeconds;
    }
    
    return _dateFormatter;
}

static NSISO8601DateFormatter *_shortDateFormatter = nil;
+ (NSISO8601DateFormatter *)shortDateFormatter {
    if (!_shortDateFormatter) {
        _shortDateFormatter = [[NSISO8601DateFormatter alloc] init];
        _shortDateFormatter.formatOptions = NSISO8601DateFormatWithInternetDateTime;
    }
    
    return _shortDateFormatter;
}

+ (NSDate *)dateFromString:(NSString *)string {
    if (string) {
        if (string.length > 10) {
            return [[self dateFormatter] dateFromString:string];
        } else {
            return [[self shortDateFormatter] dateFromString:string];
        }
    }
    
    return nil;
}

+ (NSString *)stringFromDate:(NSDate *)date {
    return [[self dateFormatter] stringFromDate:date];
}

static NSNumberFormatter *_numberFormatter = nil;
+ (NSNumberFormatter *)numberFormatter {
    if (!_numberFormatter) {
        _numberFormatter = [[NSNumberFormatter alloc] init];
        _numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
    }
    
    return _numberFormatter;
}

@end
