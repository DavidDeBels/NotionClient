//
//  NotionUser.h
//  NotionClient
//
//  Created by David De Bels on 14/05/2021.
//

#import <Foundation/Foundation.h>
#import "NotionObject.h"

NS_ASSUME_NONNULL_BEGIN

/// MARK: - NotionUser Interface

@interface NotionUser : NotionObject

/// MARK: Properties

@property (nonatomic, assign, readonly) NotionUserType type;
@property (nonatomic, copy, readonly, nullable) NSString *name;
@property (nonatomic, copy, readonly, nullable) NSString *email;
@property (nonatomic, copy, readonly, nullable) NSURL *avatarURL;

@end

NS_ASSUME_NONNULL_END
