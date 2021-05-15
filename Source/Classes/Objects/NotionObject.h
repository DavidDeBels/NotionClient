//
//  NotionObject.h
//  NotionClient
//
//  Created by David De Bels on 14/05/2021.
//

#import <Foundation/Foundation.h>
#import "NotionTypes.h"
#import "NotionHelper.h"
#import "NSDictionary+NotionClient.h"

NS_ASSUME_NONNULL_BEGIN

/// MARK: - NotionObject Interface

@interface NotionObject : NSObject

/// MARK: Properties

@property (nonatomic, copy, readonly) NSString *id;
@property (nonatomic, assign, readonly) NotionObjectType object;

/// MARK: Init

- (nullable instancetype)initWithDictionary:(NSDictionary *)dictionary;

/// MARK: Serialize

- (NSMutableDictionary *)serializedObject;

@end

NS_ASSUME_NONNULL_END
