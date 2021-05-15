//
//  NotionDateProperty.h
//  NotionClient
//
//  Created by David De Bels on 14/05/2021.
//

#import "NotionProperty.h"

NS_ASSUME_NONNULL_BEGIN

/// MARK: - NotionDateProperty Interface

@interface NotionDateProperty : NotionProperty

/// MARK: Properties

@property (nonatomic, assign, readonly) BOOL includeTime;

@property (nonatomic, copy, readwrite, nullable) NSDate *start;
@property (nonatomic, copy, readwrite, nullable) NSDate *end;

/// MARK: Init

+ (NotionDateProperty *)dateWithName:(NSString *)name date:(nullable NSDate *)date includeTime:(BOOL)includeTime;

+ (NotionDateProperty *)dateWithName:(NSString *)name start:(nullable NSDate *)start end:(nullable NSDate *)end includeTime:(BOOL)includeTime;

@end

NS_ASSUME_NONNULL_END
