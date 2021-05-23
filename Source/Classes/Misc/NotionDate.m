//
//  NotionDate.m
//  NotionClient
//
//  Created by David De Bels on 22/05/2021.
//

#import "NotionDate.h"

/// MARK: - NotionDate Implementation

@implementation NotionDate

/// MARK: Convenience Init

+ (NotionDate *)date:(NSDate *)date includeTime:(BOOL)includeTime {
    return [self start:date end:nil includeTime:includeTime];
}

+ (NotionDate *)start:(NSDate *)start end:(NSDate *)end includeTime:(BOOL)includeTime {
    return [[self alloc] initWithStart:start end:end includeTime:includeTime];
}

/// MARK: Init

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [self init];
    if (self) {
        _includeTime = YES;
        
        NSString *startTime = [dictionary stringForKeyOrNil:@"start"];
        if (startTime) {
            _start = [NotionHelper dateFromString:startTime];
        }
        NSString *endTime = [dictionary stringForKeyOrNil:@"end"];
        if (endTime) {
            _end = [NotionHelper dateFromString:endTime];
        }
    }
    
    return self;
}

- (instancetype)initWithStart:(NSDate *)start end:(NSDate *)end includeTime:(BOOL)includeTime {
    self = [self init];
    if (self) {
        _start = start;
        _end = end;
        _includeTime = includeTime;
    }
    
    return self;
}

/// MARK: Serialize

- (NSMutableDictionary *)serializedObject {
    NSMutableDictionary *dictionary = [NSMutableDictionary new];

    if (self.start) {
        dictionary[@"start"] = [NotionHelper stringFromDate:self.start includeTime:self.includeTime];
    }
    if (self.end) {
        dictionary[@"end"] = [NotionHelper stringFromDate:self.end includeTime:self.includeTime];
    }
    
    return dictionary;
}

@end
