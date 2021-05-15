//
//  NotionRelationProperty.h
//  NotionClient
//
//  Created by David De Bels on 14/05/2021.
//

#import "NotionProperty.h"

@class NotionUser;

NS_ASSUME_NONNULL_BEGIN

/// MARK: - NotionRelationProperty Interface

@interface NotionRelationProperty : NotionProperty

/// MARK: Properties

@property (nonatomic, strong, readwrite) NSArray<NSString *> *pageIds;

/// MARK: Init

+ (NotionRelationProperty *)relationWithName:(NSString *)name pageIds:(NSArray<NSString *> *)pageIds;

@end

NS_ASSUME_NONNULL_END
