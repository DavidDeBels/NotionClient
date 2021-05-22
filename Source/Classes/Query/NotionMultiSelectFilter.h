//
//  NotionMultiSelectFilter.h
//  NotionClient
//
//  Created by David De Bels on 20/05/2021.
//

#import <Foundation/Foundation.h>
#import "NotionFilter.h"

NS_ASSUME_NONNULL_BEGIN

/// MARK: - NotionMultiSelectFilter Interface

@interface NotionMultiSelectFilter : NotionFilter

/// MARK: Properties

/// The name of the property on which to filter.
@property (nonatomic, copy, readonly) NSString *propertyName;

@property (nonatomic, copy, readonly, nullable) NSString *text;

/// MARK: Convenience Init

+ (NotionMultiSelectFilter *)property:(NSString *)propertyName contains:(NSString *)text;

+ (NotionMultiSelectFilter *)property:(NSString *)propertyName doesNotContain:(NSString *)text;

+ (NotionFilter *)propertyIsEmpty:(NSString *)propertyName;

+ (NotionFilter *)propertyIsNotEmpty:(NSString *)propertyName;

@end

NS_ASSUME_NONNULL_END
