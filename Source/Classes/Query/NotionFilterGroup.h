//
//  NotionFilterGroup.h
//  NotionClient
//
//  Created by David De Bels on 21/05/2021.
//

#import <Foundation/Foundation.h>
#import "NotionFilter.h"

NS_ASSUME_NONNULL_BEGIN

/// MARK: - NotionFilterGroup Interface

@interface NotionFilterGroup : NotionFilter

/// The filters for this group.
@property (nonatomic, copy, readonly, nullable) NSArray<NotionFilter *> *filters;

/// MARK: Convenience Init

/// Create an OR database filter group. When using an OR group, the database query will return only results that match with at least 1 one of filters within the group.
/// @param filters The filters used in the group.
+ (NotionFilterGroup *)orGroupWithFilters:(NSArray<NotionFilter *> *)filters;

/// Create an AND database filter group. When using an AND group, the database query will return only results that match with all of the filters within the group.
/// @param filters The filters used in the group.
+ (NotionFilterGroup *)andGroupWithFilters:(NSArray<NotionFilter *> *)filters;

@end

NS_ASSUME_NONNULL_END
