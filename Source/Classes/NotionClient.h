//
//  NotionClient.h
//  NotionClient
//
//  Created by David De Bels on 14/05/2021.
//

#import <Foundation/Foundation.h>

@class NotionUser;
@class NotionPage;
@class NotionProperty;
@class NotionFilter;
@class NotionSort;

NS_ASSUME_NONNULL_BEGIN

extern NSString * const NotionClientBaseUrl;
extern NSString * const NotionClientApiversion;
extern NSErrorDomain const NotionClientErrorDomain;

/// MARK: - NotionClient Interface

@interface NotionClient : NSObject

/// MARK: Properties

/// The integration token.
@property (nonatomic, copy, readonly) NSString *token;

/// The amount of objects to get per page in paginated requests. Minimum is 1, maximum is 100. Default is 100
@property (nonatomic, assign, readwrite) NSInteger pageSize;

/// MARK: Init

/// Creates a new NotionClient.
/// @param token The integration token. This can be either an internal integration token or an OAuth access token.
+ (NotionClient *)clientWithToken:(NSString *)token;

- (instancetype)init NS_UNAVAILABLE;

/// Initialize a new NotionClient.
/// @param token The integration token. This can be either an internal integration token or an OAuth access token.
- (instancetype)initWithToken:(NSString *)token;

/// MARK: Users

/// Get all users for the workspace of the integration.
/// @param completion The completion handler. This will return either an array of NotionUser objects or an error if something went wrong.
- (void)getUsersWithCompletion:(void(^)(NSArray<NotionUser *> * _Nullable users, NSError * _Nullable error))completion NS_SWIFT_NAME(getUsers(completion:));

/// MARK: Query Database

/// Get all pages within a database.
/// @param databaseId The ID of the database.
/// @param completion The completion handler. This will return either an array of NotionPage objects or an error if something went wrong.
- (void)queryDatabaseWithId:(NSString *)databaseId completion:(void(^)(NSArray<NotionPage *> * _Nullable pages, NSError * _Nullable error))completion NS_SWIFT_NAME(queryDatabase(id:completion:));

/// Get all pages within a database that match with one or multiple filters.
/// @param databaseId The ID of the database.
/// @param filter An optional NotionFilter object. When provided, only pages that match with the filter criteria will be returned.
/// @param sorts An optional array of NotionSort objects. When provided, pages will be returned in the order based on the sort objects.
/// @param completion The completion handler. This will return either an array of NotionPage objects or an error if something went wrong.
- (void)queryDatabaseWithId:(NSString *)databaseId filter:(nullable NotionFilter *)filter sorts:(nullable NSArray<NotionSort *> *)sorts completion:(void(^)(NSArray<NotionPage *> * _Nullable results, NSError * _Nullable error))completion NS_SWIFT_NAME(queryDatabase(id:filter:sorts:completion:));

/// MARK: Get Pages

/// Get a single page.
/// @param pageId The ID of the page.
/// @param completion The completion handler. This will return either the requested NotionPage object or an error if something went wrong.
- (void)getPageWithId:(NSString *)pageId completion:(void(^)(NotionPage * _Nullable page, NSError * _Nullable error))completion NS_SWIFT_NAME(getPage(id:completion:));

/// MARK: Add Pages

/// Add a page to a database.
/// @param page The NotionPage object to add to the database.
/// @param databaseId The ID of the database.
/// @param completion The completion handler. This will return either the added NotionPage object or an error if something went wrong.
- (void)addPage:(NotionPage *)page databaseId:(NSString *)databaseId completion:(void(^)(NotionPage * _Nullable page, NSError * _Nullable error))completion NS_SWIFT_NAME(addPage(_:databaseId:completion:));

/// MARK: Update Page

/// Update an existing page.
/// @param page The NotionPage object to update.
/// @param completion The completion handler. This will return either the updated NotionPage object or an error if something went wrong.
- (void)updatePage:(NotionPage *)page completion:(void (^)(NotionPage * _Nullable page, NSError * _Nullable error))completion NS_SWIFT_NAME(updatePage(_:completion:));

- (void)updatePageWithId:(NSString *)pageId properties:(NSArray<NotionProperty *> *)properties completion:(void(^)(NotionPage * _Nullable page, NSError * _Nullable error))completion NS_SWIFT_NAME(updatePage(id:properties:completion:));

- (void)updatePageWithId:(NSString *)pageId archived:(BOOL)archived completion:(void(^)(NotionPage * _Nullable page, NSError *error))completion NS_SWIFT_NAME(updatePage(id:archived:completion:));

/// MARK: Duplicate Page

// - (void)duplicatePage:(NotionPage *)page databaseId:(NSString *)databaseId completion:(void(^)(NotionPage * _Nullable page, NSError * _Nullable error))completion NS_SWIFT_NAME(updatePage(_:databaseId:completion:));

@end

NS_ASSUME_NONNULL_END
