//
//  NotionRelationFilter.h
//  NotionClient
//
//  Created by David De Bels on 20/05/2021.
//

#import <Foundation/Foundation.h>
#import "NotionFilter.h"

NS_ASSUME_NONNULL_BEGIN

/// MARK: - NotionRelationFilter Interface

@interface NotionRelationFilter : NotionFilter

/// MARK: Properties

/// The name of the property on which to filter.
@property (nonatomic, copy, readonly) NSString *propertyName;

@property (nonatomic, copy, readonly, nullable) NSString *pageId;

/// MARK: Convenience Init

+ (NotionFilter *)propertyIsEmpty:(NSString *)propertyName;

+ (NotionFilter *)propertyIsNotEmpty:(NSString *)propertyName;

+ (NotionRelationFilter *)property:(NSString *)propertyName contains:(NSString *)pageId;

+ (NotionRelationFilter *)property:(NSString *)propertyName doesNotContain:(NSString *)pageId;

@end

NS_ASSUME_NONNULL_END
