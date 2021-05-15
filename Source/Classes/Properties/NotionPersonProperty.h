//
//  NotionPersonProperty.h
//  NotionClient
//
//  Created by David De Bels on 14/05/2021.
//

#import "NotionProperty.h"

@class NotionUser;

NS_ASSUME_NONNULL_BEGIN

/// MARK: - NotionPersonProperty Interface

@interface NotionPersonProperty : NotionProperty

/// MARK: Properties

@property (nonatomic, strong, readwrite) NSArray<NotionUser *> *people;

/// MARK: Init

+ (NotionPersonProperty *)personWithName:(NSString *)name people:(NSArray<NotionUser *> *)people;

@end

NS_ASSUME_NONNULL_END
