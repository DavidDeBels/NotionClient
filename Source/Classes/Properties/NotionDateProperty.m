//
//  NotionDateProperty.m
//  NotionClient
//
//  Created by David De Bels on 14/05/2021.
//

#import "NotionDateProperty.h"

/// MARK: - NotionDateProperty Class Extension

@interface NotionDateProperty ()

@property (nonatomic, copy, readwrite) NSString *name;
@property (nonatomic, assign, readwrite) BOOL includeTime;

@end

/// MARK: - NotionDateProperty Implementation

@implementation NotionDateProperty

@synthesize name = _name;
@synthesize type = _type;

/// MARK: Init

+ (NotionDateProperty *)dateWithName:(NSString *)name date:(NSDate *)date includeTime:(BOOL)includeTime {
    return [self dateWithName:name start:date end:nil includeTime:includeTime];
}

+ (NotionDateProperty *)dateWithName:(NSString *)name start:(NSDate *)start end:(NSDate *)end includeTime:(BOOL)includeTime {
    NotionDateProperty *property = [[self alloc] init];
    property.name = name;
    property.includeTime = includeTime;
    property.start = start;
    property.end = end;
    
    return property;
}

- (instancetype)init {
    self  = [super init];
    if (self) {
        _type = NotionPropertyTypeDate;
        _includeTime = YES;
    }
    
    return self;
}

- (instancetype)initWithName:(NSString *)name dictionary:(NSDictionary *)dictionary {
    self = [super initWithName:name dictionary:dictionary];
    if (self) {
        NSDictionary *date = [dictionary dictionaryForKeyOrNil:@"date"];
        NSString *startTime = [date stringForKeyOrNil:@"start"];
        if (startTime) {
            _start = [NotionHelper dateFromString:startTime];
        }
        NSString *endTime = [date stringForKeyOrNil:@"end"];
        if (endTime) {
            _end = [NotionHelper dateFromString:endTime];
        }
    }
    
    return self;
}

/// MARK: Serialize

- (NSMutableDictionary *)serializedObject {
    NSMutableDictionary *dictionary = [super serializedObject];

    NSMutableDictionary *date = [NSMutableDictionary new];
    if (self.start) {
        date[@"start"] = [NotionHelper stringFromDate:self.start];
    }
    if (self.end) {
        date[@"end"] = [NotionHelper stringFromDate:self.end];
    }
    dictionary[@"date"] = date.count > 0 ? date : NSNull.null;
    
    return dictionary;
}

@end
