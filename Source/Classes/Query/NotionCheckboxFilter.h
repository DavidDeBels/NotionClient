//
//  NotionCheckboxFilter.h
//  NotionClient
//
//  Created by David De Bels on 20/05/2021.
//

#import <Foundation/Foundation.h>
#import "NotionFilter.h"

NS_ASSUME_NONNULL_BEGIN

/// MARK: - NotionCheckboxFilter Interface

@interface NotionCheckboxFilter : NotionFilter

/// MARK: Properties

/// The name of the property on which to filter.
@property (nonatomic, copy, readonly) NSString *propertyName;

@property (nonatomic, assign, readonly) BOOL value;

/// MARK: Convenience Init

+ (NotionCheckboxFilter *)property:(NSString *)propertyName equals:(BOOL)value;

+ (NotionCheckboxFilter *)property:(NSString *)propertyName doesNotEqual:(BOOL)value;

@end

NS_ASSUME_NONNULL_END
