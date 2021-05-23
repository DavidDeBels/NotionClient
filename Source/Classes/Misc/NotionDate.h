//
//  NotionDate.h
//  NotionClient
//
//  Created by David De Bels on 22/05/2021.
//

#import <Foundation/Foundation.h>
#import "NotionTypes.h"
#import "NotionHelper.h"
#import "NotionSerializable.h"
#import "NSDictionary+NotionClient.h"

NS_ASSUME_NONNULL_BEGIN

/// MARK: - NotionDate Interface

@interface NotionDate : NSObject <NotionSerializable>

/// MARK: Properties

/// Whether or not the dates have the time included.
@property (nonatomic, assign, readwrite) BOOL includeTime;

/// The start date. If used in a date range, this indicates the start of the date range. If not this is just the date.
@property (nonatomic, copy, readwrite, nullable) NSDate *start;

/// The end date. If used in a date range, this indicates the end of the date range. If not this  should be nil.
@property (nonatomic, copy, readwrite, nullable) NSDate *end;

/// MARK: Init

+ (NotionDate *)date:(nullable NSDate *)date includeTime:(BOOL)includeTime NS_SWIFT_NAME(date(_:includeTime:));

+ (NotionDate *)start:(nullable NSDate *)start end:(nullable NSDate *)end includeTime:(BOOL)includeTime NS_SWIFT_NAME(date(start:end:includeTime:));

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

- (instancetype)initWithDate:(nullable NSDate *)date includeTime:(BOOL)includeTime;

- (instancetype)initWithStart:(nullable NSDate *)start end:(nullable NSDate *)end includeTime:(BOOL)includeTime;

/// MARK: Serialize

- (NSMutableDictionary *)serializedObject;

@end

NS_ASSUME_NONNULL_END
