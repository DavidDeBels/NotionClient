//
//  NotionSort.h
//  NotionClient
//
//  Created by David De Bels on 20/05/2021.
//

#import <Foundation/Foundation.h>
#import "NotionTypes.h"
#import "NotionSerializable.h"

NS_ASSUME_NONNULL_BEGIN

/// MARK: - NotionSort Interface

@interface NotionSort : NSObject <NotionSerializable>

/// The sort type, either property, created time or last edited time. Default is property.
@property (nonatomic, assign, readonly) NotionSortType type;

/// The sort direction, either ascending or descending. Default is ascending.
@property (nonatomic, assign, readwrite) NotionSortDirection direction;

/// The name of the property on which to sort. Is nil if type is not property.
@property (nonatomic, copy, readonly, nullable) NSString *propertyName;

/// MARK: Convenience Init

+ (NotionSort *)ascendingOnProperty:(NSString *)propertyName NS_SWIFT_NAME(ascendingOnProperty(name:));

+ (NotionSort *)descendingOnProperty:(NSString *)propertyName NS_SWIFT_NAME(descendingOnProperty(name:));

+ (NotionSort *)ascendingOnCreatedTime NS_SWIFT_NAME(ascendingOnCreatedTime());

+ (NotionSort *)descendingOnCreatedTime NS_SWIFT_NAME(descendingOnCreatedTime());

+ (NotionSort *)ascendingOnLastEditedTime NS_SWIFT_NAME(ascendingOnLastEditedTime());

+ (NotionSort *)descendingOnLastEditedTime NS_SWIFT_NAME(descendingOnLastEditedTime());

/// MARK: Init

- (instancetype)init NS_UNAVAILABLE;

/// MARK: Serialize

- (NSMutableDictionary *)serializedObject;

@end

NS_ASSUME_NONNULL_END
