//
//  NotionNumberProperty.h
//  NotionClient
//
//  Created by David De Bels on 14/05/2021.
//

#import "NotionProperty.h"

NS_ASSUME_NONNULL_BEGIN

/// MARK: - NotionNumberProperty Interface

@interface NotionNumberProperty : NotionProperty

/// MARK: Properties

@property (nonatomic, assign, readwrite) NotionNumberFormat format;
@property (nonatomic, copy, readwrite, nullable) NSNumber *number;

/// MARK: Init

+ (NotionNumberProperty *)numberWithName:(NSString *)name number:(nullable NSNumber *)number;

@end

NS_ASSUME_NONNULL_END
