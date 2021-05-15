//
//  NotionEmailProperty.h
//  NotionClient
//
//  Created by David De Bels on 14/05/2021.
//

#import "NotionProperty.h"

NS_ASSUME_NONNULL_BEGIN

/// MARK: - NotionEmailProperty Interface

@interface NotionEmailProperty : NotionProperty

/// MARK: Properties

@property (nonatomic, copy, readwrite, nullable) NSString *email;

/// MARK: Init

+ (NotionEmailProperty *)emailWithName:(NSString *)name email:(NSString *)email;

@end

NS_ASSUME_NONNULL_END
