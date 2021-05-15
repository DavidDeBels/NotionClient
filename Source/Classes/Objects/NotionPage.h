//
//  NotionPage.h
//  NotionClient
//
//  Created by David De Bels on 14/05/2021.
//

#import "NotionObject.h"
#import "NotionProperty.h"

NS_ASSUME_NONNULL_BEGIN

/// MARK: - NotionPage Interface

@interface NotionPage : NotionObject

/// MARK: Properties

@property (nonatomic, copy, readonly) NSDate *createdTime;
@property (nonatomic, copy, readonly) NSDate *lastEditedTime;
@property (nonatomic, assign, readonly) BOOL archived;

@property (nonatomic, copy, readonly) NSString *parentId;
@property (nonatomic, assign, readonly) NotionParentType parentType;

@property (nonatomic, copy, readonly, nullable) NSString *title;
@property (nonatomic, copy, readonly) NSDictionary<NSString *, NotionProperty *> *properties;

/// MARK: Serialize

- (NSMutableDictionary *)serializedObject;

@end

NS_ASSUME_NONNULL_END
