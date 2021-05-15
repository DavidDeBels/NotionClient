//
//  NotionTextPart.h
//  NotionClient
//
//  Created by David De Bels on 15/05/2021.
//

#import <Foundation/Foundation.h>
#import "NotionTypes.h"
#import "NotionHelper.h"
#import "NSDictionary+NotionClient.h"

NS_ASSUME_NONNULL_BEGIN

/// MARK: - NotionTextPart Interface

@interface NotionTextPart : NSObject

/// MARK: Properties

@property (nonatomic, assign, readonly) NotionTextPartType type;

@property (nonatomic, assign, readwrite) BOOL bold;
@property (nonatomic, assign, readwrite) BOOL italic;
@property (nonatomic, assign, readwrite) BOOL strikethrough;
@property (nonatomic, assign, readwrite) BOOL underline;
@property (nonatomic, assign, readwrite) BOOL code;
@property (nonatomic, assign, readwrite) NotionColor color;

@property (nonatomic, copy, readwrite, nullable) NSString *plainText;
@property (nonatomic, copy, readwrite, nullable) NSURL *URL;

/// MARK: Init

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

/// MARK: Serialize

- (NSMutableDictionary *)serializedObject;

@end

NS_ASSUME_NONNULL_END
