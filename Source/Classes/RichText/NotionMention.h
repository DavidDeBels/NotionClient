//
//  NotionMention.h
//  NotionClient
//
//  Created by David De Bels on 15/05/2021.
//

#import "NotionTextPart.h"

@class NotionUser;
@class NotionPage;
@class NotionDate;

NS_ASSUME_NONNULL_BEGIN

/// MARK: - NotionMention Interface

@interface NotionMention : NotionTextPart

@property (nonatomic, assign, readonly) NotionMentionType mentionType;

@property (nonatomic, strong, readwrite, nullable) NotionUser *user;

@property (nonatomic, strong, readwrite, nullable) NotionDate *date;

@property (nonatomic, copy, readwrite, nullable) NSString *pageId;

@property (nonatomic, copy, readwrite, nullable) NSString *databaseId;

/// MARK: Convenience Init

/// Mention a user.
/// @param user The user object.
+ (NotionMention *)mentionWithUser:(NotionUser *)user NS_SWIFT_NAME(mention(user:));

/// Mention a user.
/// @param userId The ID of the user.
+ (NotionMention *)mentionWithUserId:(NSString *)userId NS_SWIFT_NAME(mention(userId:));

/// Mention a date.
/// @param date The date object.
+ (NotionMention *)mentionWithDate:(NotionDate *)date NS_SWIFT_NAME(mention(date:));

/// Mention a page.
/// @param page The page object.
+ (NotionMention *)mentionWithPage:(NotionPage *)page NS_SWIFT_NAME(mention(page:));

/// Mention a page.
/// @param pageId The ID of the page.
+ (NotionMention *)mentionWithPageId:(NSString *)pageId NS_SWIFT_NAME(mention(pageId:));

/// Mention a database.
/// @param databaseId The ID of the database.
+ (NotionMention *)mentionWithDatabaseId:(NSString *)databaseId NS_SWIFT_NAME(mention(databaseId:));

/// MARK: Init

- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
