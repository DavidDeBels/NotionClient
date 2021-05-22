//
//  NotionTextFilter.h
//  NotionClient
//
//  Created by David De Bels on 20/05/2021.
//

#import <Foundation/Foundation.h>
#import "NotionFilter.h"

NS_ASSUME_NONNULL_BEGIN

/// MARK: - NotionTextFilter Interface

@interface NotionTextFilter : NotionFilter

/// MARK: Properties

/// The name of the property on which to filter.
@property (nonatomic, copy, readonly) NSString *propertyName;

@property (nonatomic, copy, readonly, nullable) NSString *text;

/// MARK: Convenience Init

+ (NotionTextFilter *)property:(NSString *)propertyName equals:(NSString *)text;

+ (NotionTextFilter *)property:(NSString *)propertyName doesNotEqual:(NSString *)text;

+ (NotionTextFilter *)property:(NSString *)propertyName contains:(NSString *)text;

+ (NotionTextFilter *)property:(NSString *)propertyName doesNotContain:(NSString *)text;

+ (NotionTextFilter *)property:(NSString *)propertyName startsWith:(NSString *)text;

+ (NotionTextFilter *)property:(NSString *)propertyName endsWith:(NSString *)text;

+ (NotionFilter *)propertyIsEmpty:(NSString *)propertyName;

+ (NotionFilter *)propertyIsNotEmpty:(NSString *)propertyName;

@end

NS_ASSUME_NONNULL_END
