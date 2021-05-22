//
//  NotionFilter.h
//  NotionClient
//
//  Created by David De Bels on 20/05/2021.
//

#import <Foundation/Foundation.h>
#import "NotionTypes.h"
#import "NotionHelper.h"
#import "NotionSerializable.h"

NS_ASSUME_NONNULL_BEGIN

/// MARK: - NotionFilter Interface

@interface NotionFilter : NSObject <NotionSerializable>

/// MARK: Properties

/// The filter type.
@property (nonatomic, assign, readonly) NotionFilterType type;

@end

NS_ASSUME_NONNULL_END
