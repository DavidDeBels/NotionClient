//
//  NotionDateProperty.h
//  NotionClient
//
//  Created by David De Bels on 14/05/2021.
//

#import "NotionProperty.h"

@class NotionDate;

NS_ASSUME_NONNULL_BEGIN

/// MARK: - NotionDateProperty Interface

@interface NotionDateProperty : NotionProperty

/// MARK: Properties

@property (nonatomic, copy, readwrite, nullable) NotionDate *date;

/// MARK: Init

+ (NotionDateProperty *)dateWithName:(NSString *)name date:(nullable NotionDate *)date;

@end

NS_ASSUME_NONNULL_END
