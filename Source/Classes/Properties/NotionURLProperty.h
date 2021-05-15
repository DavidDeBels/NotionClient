//
//  NotionURLProperty.h
//  NotionClient
//
//  Created by David De Bels on 14/05/2021.
//

#import "NotionProperty.h"

NS_ASSUME_NONNULL_BEGIN

/// MARK: - NotionURLProperty Interface

@interface NotionURLProperty : NotionProperty

/// MARK: Properties

@property (nonatomic, copy, readwrite, nullable) NSURL *URL;

/// MARK: Init

+ (NotionURLProperty *)urlWithName:(NSString *)name URL:(NSURL *)URL;

@end

NS_ASSUME_NONNULL_END
