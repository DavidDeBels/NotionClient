//
//  NotionNumberFilter.h
//  NotionClient
//
//  Created by David De Bels on 20/05/2021.
//

#import <Foundation/Foundation.h>
#import "NotionFilter.h"

NS_ASSUME_NONNULL_BEGIN

/// MARK: - NotionNumberFilter Interface

@interface NotionNumberFilter : NotionFilter

/// MARK: Properties

/// The name of the property on which to filter.
@property (nonatomic, copy, readonly) NSString *propertyName;

@property (nonatomic, copy, readonly, nullable) NSNumber *number;

/// MARK: Convenience Init

+ (NotionNumberFilter *)property:(NSString *)propertyName equals:(NSNumber *)number;

+ (NotionNumberFilter *)property:(NSString *)propertyName doesNotEqual:(NSNumber *)number;

+ (NotionNumberFilter *)property:(NSString *)propertyName greaterThan:(NSNumber *)number;

+ (NotionNumberFilter *)property:(NSString *)propertyName greaterThanOrEqualTo:(NSNumber *)number;

+ (NotionNumberFilter *)property:(NSString *)propertyName lessThan:(NSNumber *)number;

+ (NotionNumberFilter *)property:(NSString *)propertyName lessThanOrEqualTo:(NSNumber *)number;

+ (NotionFilter *)propertyIsEmpty:(NSString *)propertyName;

+ (NotionFilter *)propertyIsNotEmpty:(NSString *)propertyName;

@end

NS_ASSUME_NONNULL_END
