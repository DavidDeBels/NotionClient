//
//  NotionClient.m
//  NotionClient
//
//  Created by David De Bels on 14/05/2021.
//

#import "NotionClient.h"
#import "NotionObject.h"
#import "NotionProperty.h"
#import "NotionTitleProperty.h"
#import "NotionRichText.h"

#import "NotionPage.h"
#import "NotionUser.h"

#import "NSDictionary+NotionClient.h"

NSString * const NotionClientBaseUrl = @"https://api.notion.com/v1";
NSString * const NotionClientApiversion = @"2021-05-13";
NSErrorDomain const NotionClientErrorDomain = @"so.notion.notionclient";

/// MARK: - NotionClient Class Extension

@interface NotionClient ()

@end

/// MARK: - NotionClient Implementation

@implementation NotionClient

/// MARK: Init

+ (NotionClient *)clientWithToken:(NSString *)token {
    return [[NotionClient alloc] initWithToken:token];
}

- (instancetype)initWithToken:(NSString *)token {
    if (!token) {
        return nil;
    }
    
    self = [super init];
    if (self) {
        _token = token;
        _pageSize = 100;
    }
    
    return self;
}

/// MARK: Users

- (void)fetchAllUsersWithCompletion:(void(^)(NSArray<NotionUser *> *results, NSError *error))completion {
    [self fetchAllUsersWithCompletion:completion startCursor:nil appendPreviousResults:nil];
}

- (void)fetchAllUsersWithCompletion:(void(^)(NSArray<NotionUser *> *results, NSError *error))completion startCursor:(nullable NSString *)startCursor appendPreviousResults:(nullable NSArray *)previousResults {
    // Endpoint path
    NSString *path = @"/users";
    
    // Query parameters
    NSMutableDictionary *queryParameters = [NSMutableDictionary new];
    queryParameters[@"page_size"] = [NSString stringWithFormat:@"%ld", self.pageSize];
    if (startCursor) {
        queryParameters[@"start_cursor"] = startCursor;
    }
    
    // Create & perform request
    NSMutableURLRequest *request = [self requestForMethod:@"GET" path:path query:queryParameters];

    __weak typeof(self) weakSelf = self;
    [self performRequest:request expectedStatusCode:200 completion:^(NSDictionary *responseBody, NSError *error) {
        if (error) {
            completion(nil, error);
            return;
        }
        
        // Get results and append to any results from a previous request
        NSArray *results = [responseBody arrayForKeyOrNil:@"results"];
        if (previousResults) {
            results = [previousResults arrayByAddingObjectsFromArray:results];
        }
        
        // If there is more content get it, if not parse results and call completion
        NSString *nextCursor = [responseBody stringForKeyOrNil:@"next_cursor"];
        if (nextCursor) {
            [weakSelf fetchAllUsersWithCompletion:completion startCursor:nextCursor appendPreviousResults:results];
        } else {
            NSArray *objects = [self parseListResults:results];
            completion(objects, nil);
        }
    }];
}

/// MARK: Query Database

- (void)queryDatabaseWithId:(NSString *)databaseId completion:(void(^)(NSArray<NotionPage *> *results, NSError *error))completion {
    [self queryDatabaseWithId:databaseId completion:completion startCursor:nil appendPreviousResults:nil];
}

- (void)queryDatabaseWithId:(NSString *)databaseId completion:(void(^)(NSArray<NotionPage *> *results, NSError *error))completion startCursor:(nullable NSString *)startCursor appendPreviousResults:(nullable NSArray *)previousResults {
    // Endpoint path
    NSString *path = [NSString stringWithFormat:@"/databases/%@/query", databaseId];
    
    // Query parameters
    NSMutableDictionary *queryParameters = [NSMutableDictionary new];
    queryParameters[@"page_size"] = [NSString stringWithFormat:@"%ld", self.pageSize];
    if (startCursor) {
        queryParameters[@"start_cursor"] = startCursor;
    }
    
    // Request Body
    NSMutableDictionary *body = [NSMutableDictionary new];
    
    // Create & perform request
    NSMutableURLRequest *request = [self requestForMethod:@"POST" path:path query:queryParameters];
    request.HTTPBody = [body JSONDataWithError:nil];

    __weak typeof(self) weakSelf = self;
    [self performRequest:request expectedStatusCode:200 completion:^(NSDictionary *responseBody, NSError *error) {
        if (error) {
            completion(nil, error);
            return;
        }
        
        // Get results and append to any results from a previous request
        NSArray *results = [responseBody arrayForKeyOrNil:@"results"];
        if (previousResults) {
            results = [previousResults arrayByAddingObjectsFromArray:results];
        }
        
        // If there is more content get it, if not parse results
        NSString *nextCursor = [responseBody stringForKeyOrNil:@"next_cursor"];
        if (nextCursor) {
            [weakSelf queryDatabaseWithId:databaseId completion:completion startCursor:nextCursor appendPreviousResults:results];
        } else {
            NSArray *objects = [self parseListResults:results];
            completion(objects, nil);
        }
    }];
}

/// MARK: Get Database Page

- (void)getPageWithId:(NSString *)pageId completion:(void(^)(NotionPage *page, NSError *error))completion {
    // Endpoint path
    NSString *path = [NSString stringWithFormat:@"/pages/%@", pageId];
    
    // Create & perform request
    NSMutableURLRequest *request = [self requestForMethod:@"GET" path:path query:nil];
    
    [self performRequest:request expectedStatusCode:200 completion:^(NSDictionary *responseBody, NSError *error) {
        if (error) {
            completion(nil, error);
            return;
        }
        
        NotionPage *page = [[NotionPage alloc] initWithDictionary:responseBody];
        completion(page, nil);
    }];
}

/// MARK: Create Database Page

- (void)addPage:(NotionPage *)page databaseId:(NSString *)databaseId completion:(void(^)(NotionPage *page, NSError *error))completion {
    // Make sure the parent is set correctly
    page.parentId = databaseId;
    page.parentType = NotionParentTypeDatabase;
    
    // Endpoint path
    NSString *path = @"/pages";
    
    // Request Body
    NSDictionary *body = page.serializedObject;
    
    // Create & perform request
    NSMutableURLRequest *request = [self requestForMethod:@"POST" path:path query:nil];
    request.HTTPBody = [body JSONDataWithError:nil];
    
    [self performRequest:request expectedStatusCode:200 completion:^(NSDictionary *responseBody, NSError *error) {
        if (error) {
            completion(nil, error);
            return;
        }
        
        NotionPage *page = [[NotionPage alloc] initWithDictionary:responseBody];
        completion(page, nil);
    }];
}

/// MARK: Update Page

- (void)updatePage:(NotionPage *)page completion:(void (^)(NotionPage *, NSError *))completion {
    // Endpoint path
    NSString *path = [NSString stringWithFormat:@"/pages/%@", page.id];
    
    // Request Body
    NSMutableDictionary *body = page.serializedObject;
    
    // Create & perform request
    NSMutableURLRequest *request = [self requestForMethod:@"PATCH" path:path query:nil];
    request.HTTPBody = [body JSONDataWithError:nil];

    [self performRequest:request expectedStatusCode:200 completion:^(NSDictionary *responseBody, NSError *error) {
        if (error) {
            completion(nil, error);
            return;
        }
        
        NotionPage *page = [[NotionPage alloc] initWithDictionary:responseBody];
        completion(page, nil);
    }];
}

- (void)updatePageWithId:(NSString *)pageId properties:(NSArray<NotionProperty *> *)properties completion:(void(^)(NotionPage *page, NSError *error))completion {
    // Endpoint path
    NSString *path = [NSString stringWithFormat:@"/pages/%@", pageId];
    
    // Build body
    NSMutableDictionary *propertiesDict = [NSMutableDictionary new];
    for (NotionProperty *property in properties) {
        propertiesDict[property.name] = [property serializedObject];
    }
    
    // Request Body
    NSMutableDictionary *body = [NSMutableDictionary new];
    body[@"properties"] = propertiesDict;
    
    // Create & perform request
    NSMutableURLRequest *request = [self requestForMethod:@"PATCH" path:path query:nil];
    request.HTTPBody = [body JSONDataWithError:nil];

    [self performRequest:request expectedStatusCode:200 completion:^(NSDictionary *responseBody, NSError *error) {
        if (error) {
            completion(nil, error);
            return;
        }
        
        NotionPage *page = [[NotionPage alloc] initWithDictionary:responseBody];
        completion(page, nil);
    }];
}

- (void)updatePageWithId:(NSString *)pageId archived:(BOOL)archived completion:(void (^)(NotionPage *, NSError *))completion {
    // Endpoint path
    NSString *path = [NSString stringWithFormat:@"/pages/%@", pageId];
    
    // Request Body
    NSMutableDictionary *body = [NSMutableDictionary new];
    body[@"archived"] = @(archived);
    
    // Create & perform request
    NSMutableURLRequest *request = [self requestForMethod:@"PATCH" path:path query:nil];
    request.HTTPBody = [body JSONDataWithError:nil];

    [self performRequest:request expectedStatusCode:200 completion:^(NSDictionary *responseBody, NSError *error) {
        if (error) {
            completion(nil, error);
            return;
        }
        
        NotionPage *page = [[NotionPage alloc] initWithDictionary:responseBody];
        completion(page, nil);
    }];
}

/// MARK: Duplicate Page

- (void)duplicatePage:(NotionPage *)page databaseId:(NSString *)databaseId completion:(void(^)(NotionPage *page, NSError *error))completion {
    [self duplicatePage:page databaseId:databaseId prefix:@"Copy of " suffix:nil completion:completion];
}

- (void)duplicatePage:(NotionPage *)page databaseId:(NSString *)databaseId prefix:(NSString *)prefix suffix:(NSString *)suffix completion:(void(^)(NotionPage *page, NSError *error))completion {
    NotionPage *copiedPage = [NotionPage pageWithProperties:page.properties.allValues];
    copiedPage.archived = page.archived;
    
    // Add a prefix or suffix to the title to differentiate the duplicated page
    NotionTitleProperty *copiedTitleProperty = copiedPage.titleProperty;
    if (copiedTitleProperty && copiedTitleProperty.parts && (prefix || suffix)) {
        NSMutableArray *parts = [copiedTitleProperty.parts mutableCopy];
        if (prefix) {
            [parts insertObject:[NotionRichText textWithContent:prefix] atIndex:0];
        }
        if (suffix) {
            [parts addObject:[NotionRichText textWithContent:suffix]];
        }
        
        copiedTitleProperty.parts = parts;
    }

    [self addPage:copiedPage databaseId:databaseId completion:completion];
}


/// MARK: Notion Request

- (NSMutableURLRequest *)requestForMethod:(NSString *)HTTPMethod path:(NSString *)path query:(NSDictionary *)query {
    // Set path
    NSString *urlString = [NotionClientBaseUrl stringByAppendingString:path];
    NSURLComponents *URLComponents = [NSURLComponents componentsWithString:urlString];
    
    // Create query parameters
    if (query) {
        NSMutableArray *queryItems = [NSMutableArray new];
        for (NSString *key in query.allKeys) {
            NSURLQueryItem *queryItem = [NSURLQueryItem queryItemWithName:key value:query[key]];
            [queryItems addObject:queryItem];
        }
        URLComponents.queryItems = queryItems;
    }

    // Build request
    NSMutableURLRequest *request = [NSMutableURLRequest new];
    request.URL = URLComponents.URL;
    request.HTTPMethod = HTTPMethod;
    request.allHTTPHeaderFields = @{
        @"Content-Type": @"application/json",
        @"Authorization": [NSString stringWithFormat:@"Bearer %@", self.token],
        @"Notion-Version": NotionClientApiversion
    };
    
    return request;
}

- (void)performRequest:(NSURLRequest *)request expectedStatusCode:(NSInteger)statusCode completion:(void(^)(NSDictionary *responseBody, NSError *error))completion {
    NSURLSessionDataTask *task = [NSURLSession.sharedSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable connectionError) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (!connectionError) {
                NSHTTPURLResponse *HTTPResponse = ((NSHTTPURLResponse *)response);
                NSDictionary *responseBody = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
                if (HTTPResponse.statusCode == statusCode) {
                    completion(responseBody, nil);
                } else {
                    NSError *requestError = [NSError errorWithDomain:NotionClientErrorDomain code:HTTPResponse.statusCode userInfo:responseBody];
                    completion(nil, requestError);
                }
            } else {
                completion(nil, connectionError);
            }
        });
    }];
    [task resume];
}

- (NSInteger)pageSize {
    return (_pageSize > 0) ? _pageSize : 100;
}

/// MARK: Helper Functions

- (NSArray *)parseListResults:(NSArray<NSDictionary *> *)results {
    NSMutableArray *objects = [NSMutableArray new];
    for (NSDictionary *dictionary in results) {
        NSString *object = [dictionary stringForKeyOrNil:@"object"];
        Class class = [NotionHelper classForObjectType:object];
        if (class) {
            NotionObject *object = [[class alloc] initWithDictionary:dictionary];
            if (object) {
                [objects addObject:object];
            }
        }
    }

    return objects;
}

@end
