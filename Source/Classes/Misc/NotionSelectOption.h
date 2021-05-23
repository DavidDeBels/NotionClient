//
//  NotionSelectOption.h
//  NotionClient
//
//  Created by David De Bels on 14/05/2021.
//

#import <Foundation/Foundation.h>
#import "NotionHelper.h"

NS_ASSUME_NONNULL_BEGIN

/// MARK: - NotionSelectOption Interface

@interface NotionSelectOption : NSObject

/// MARK: Properties

@property (nonatomic, copy, readwrite) NSString *name;
@property (nonatomic, assign, readwrite) NotionColor color;

@property (nonatomic, copy, readonly, nullable) NSString *id;

/// MARK: Init

+ (NotionSelectOption *)optionWithName:(nullable NSString *)name;

- (instancetype)init;
- (instancetype)initWithName:(nullable NSString *)name;
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

/// MARK: Serialize

- (NSMutableDictionary *)serializedObject;

@end

NS_ASSUME_NONNULL_END
