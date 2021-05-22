//
//  NotionPersonFilter.h
//  NotionClient
//
//  Created by David De Bels on 20/05/2021.
//

#import <Foundation/Foundation.h>
#import "NotionFilter.h"

NS_ASSUME_NONNULL_BEGIN

/// MARK: - NotionPersonFilter Interface

@interface NotionPersonFilter : NotionFilter

/// MARK: Properties

/// The name of the property on which to filter.
@property (nonatomic, copy, readonly) NSString *propertyName;

@property (nonatomic, copy, readonly, nullable) NSString *userId;

/// MARK: Convenience Init

+ (NotionFilter *)propertyIsEmpty:(NSString *)propertyName;

+ (NotionFilter *)propertyIsNotEmpty:(NSString *)propertyName;

+ (NotionPersonFilter *)property:(NSString *)propertyName contains:(NSString *)userId;

+ (NotionPersonFilter *)property:(NSString *)propertyName doesNotContain:(NSString *)userId;

@end

NS_ASSUME_NONNULL_END
