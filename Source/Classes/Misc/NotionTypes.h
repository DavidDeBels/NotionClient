//
//  NotionTypes.h
//  NotionClient
//
//  Created by David De Bels on 14/05/2021.
//

typedef NS_ENUM(NSUInteger, NotionParentType) {
    NotionParentTypeUnknown,
    NotionParentTypeWorkspace,
    NotionParentTypeDatabase,
    NotionParentTypePage
};

typedef NS_ENUM(NSUInteger, NotionObjectType) {
    NotionObjectTypeUnknown,
    NotionObjectTypeUser,
    NotionObjectTypePage,
    NotionObjectTypeDatabase
};

typedef NS_ENUM(NSUInteger, NotionUserType) {
    NotionUserTypeUnknown,
    NotionUserTypePerson,
    NotionUserTypeBot
};

typedef NS_ENUM(NSUInteger, NotionColor) {
    NotionColorDefault,
    NotionColorGray,
    NotionColorBrown,
    NotionColorOrange,
    NotionColorYellow,
    NotionColorGreen,
    NotionColorBlue,
    NotionColorPurple,
    NotionColorPink,
    NotionColorRed,
    NotionColorGrayBackground,
    NotionColorBrownBackground,
    NotionColorOrangeBackground,
    NotionColorYellowBackground,
    NotionColorGreenBackground,
    NotionColorBlueBackground,
    NotionColorPurpleBackground,
    NotionColorPinkBackground,
    NotionColorRedBackground
};

typedef NS_ENUM(NSUInteger, NotionTextPartType) {
    NotionTextPartTypeUnknown,
    NotionTextPartTypeText,
    NotionTextPartTypeMention,
    NotionTextPartTypeEquation
};

typedef NS_ENUM(NSUInteger, NotionPropertyType) {
    NotionPropertyTypeUnknown,
    NotionPropertyTypeTitle,
    NotionPropertyTypeText,
    NotionPropertyTypeNumber,
    NotionPropertyTypeSelect,
    NotionPropertyTypeMultiSelect,
    NotionPropertyTypeDate,
    NotionPropertyTypePerson,
    NotionPropertyTypeCheckbox,
    NotionPropertyTypeURL,
    NotionPropertyTypeEmail,
    NotionPropertyTypePhone,
    NotionPropertyTypeRelation
};

typedef NS_ENUM(NSUInteger, NotionNumberFormat) {
    NotionNumberFormatNumber,
    NotionNumberFormatNumberWithCommas,
    NotionNumberFormatPercent,
    NotionNumberFormatDollar,
    NotionNumberFormatEuro,
    NotionNumberFormatPound,
    NotionNumberFormatYen,
    NotionNumberFormatRuble,
    NotionNumberFormatRupee,
    NotionNumberFormatWon,
    NotionNumberFormatYuan
};

typedef NS_ENUM(NSUInteger, NotionSortDirection) {
    NotionSortDirectionAscending,
    NotionSortDirectionDescending
};

typedef NS_ENUM(NSUInteger, NotionSortType) {
    NotionSortTypeProperty,
    NotionSortTypeCreatedTime,
    NotionSortTypeLastEditedTime
};

typedef NS_ENUM(NSUInteger, NotionFilterType) {
    NotionFilterTypeIsEmpty,
    NotionFilterTypeIsNotEmpty,
    NotionFilterTypeEquals,
    NotionFilterTypeDoesNotEqual,
    NotionFilterTypeContains,
    NotionFilterTypeDoesNotContain,
    NotionFilterTypeStartsWith,
    NotionFilterTypeEndsWith,
    NotionFilterTypeGreaterThan,
    NotionFilterTypeGreaterThanOrEqualTo,
    NotionFilterTypeLessThan,
    NotionFilterTypeLessThanOrEqualTo,
    NotionFilterTypeGroupAnd,
    NotionFilterTypeGroupOr
};


