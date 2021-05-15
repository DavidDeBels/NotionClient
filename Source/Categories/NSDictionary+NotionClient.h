//
//  NSDictionary+NotionClient.h
//  NotionClient
//
//  Created by David De Bels on 14/05/2021.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (NotionClient)

- (NSString *)stringForKeyOrNil:(id<NSCopying>)aKey;

- (NSNumber *)numberForKeyOrNil:(id<NSCopying>)aKey;

- (NSDate *)dateForKeyOrNil:(id<NSCopying>)aKey;

- (NSArray *)arrayForKeyOrNil:(id<NSCopying>)aKey;

- (NSDictionary *)dictionaryForKeyOrNil:(id<NSCopying>)aKey;

- (NSString *)JSONStringWithError:(NSError **)error;

- (NSData *)JSONDataWithError:(NSError **)error;

@end

NS_ASSUME_NONNULL_END
