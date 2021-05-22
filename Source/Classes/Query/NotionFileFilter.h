//
//  NotionFileFilter.h
//  NotionClient
//
//  Created by David De Bels on 20/05/2021.
//

#import <Foundation/Foundation.h>
#import "NotionFilter.h"

NS_ASSUME_NONNULL_BEGIN

/// MARK: - NotionFileFilter Interface

@interface NotionFileFilter : NotionFilter

/// MARK: Properties

/// The name of the property on which to filter.
@property (nonatomic, copy, readonly) NSString *propertyName;

/// MARK: Convenience Init

+ (NotionFilter *)propertyIsEmpty:(NSString *)propertyName;

+ (NotionFilter *)propertyIsNotEmpty:(NSString *)propertyName;

@end

NS_ASSUME_NONNULL_END
