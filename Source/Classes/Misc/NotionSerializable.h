//
//  NotionSerializable.h
//  NotionClient
//
//  Created by David De Bels on 20/05/2021.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// MARK: - NotionSerializable Protocol

@protocol NotionSerializable <NSObject>

@required

- (NSMutableDictionary *)serializedObject;

@end

NS_ASSUME_NONNULL_END
