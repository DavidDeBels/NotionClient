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

NS_ASSUME_NONNULL_BEGIN

extern NSString * const NotionClientBaseUrl;
extern NSString * const NotionClientApiversion;
extern NSErrorDomain const NotionClientErrorDomain;

/// MARK: - NotionClient Interface

@interface NotionClient : NSObject

/// MARK: Properties

@property (nonatomic, copy, readonly) NSString *token;
@property (nonatomic, assign, readwrite) NSInteger pageSize;

/// MARK: Init

+ (NotionClient *)clientWithToken:(NSString *)token;

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithToken:(NSString *)token;

/// MARK: Users

- (void)fetchAllUsersWithCompletion:(void(^)(NSArray<NotionUser *> *results, NSError *error))completion;

/// MARK: Database

- (void)queryDatabaseWithId:(NSString *)databaseId completion:(void(^)(NSArray<NotionPage *> * _Nullable results, NSError * _Nullable error))completion;

/// MARK: Update Page

- (void)updatePageWithId:(NSString *)pageId properties:(NSArray<NotionProperty *> *)properties completion:(void(^)(NotionPage *page, NSError *error))completion;

- (void)updatePageWithId:(NSString *)pageId archived:(BOOL)archived completion:(void(^)(NotionPage * _Nullable page, NSError *error))completion;

@end

NS_ASSUME_NONNULL_END
