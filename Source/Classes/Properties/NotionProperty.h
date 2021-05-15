//
//  NotionProperty.h
//  NotionClient
//
//  Created by David De Bels on 14/05/2021.
//

#import <Foundation/Foundation.h>
#import "NotionTypes.h"
#import "NotionHelper.h"
#import "NSDictionary+NotionClient.h"

NS_ASSUME_NONNULL_BEGIN

/// MARK: - NotionProperty Interface

@interface NotionProperty : NSObject

/// MARK: Properties

@property (nonatomic, assign, readonly) NotionPropertyType type;
@property (nonatomic, copy, readonly) NSString *name;

@property (nonatomic, copy, readonly, nullable) NSString *id;

/// MARK: Init

- (instancetype)initWithName:(NSString *)name dictionary:(NSDictionary *)dictionary;

/// MARK: Serialize

- (NSMutableDictionary *)serializedObject;

@end

NS_ASSUME_NONNULL_END
