//
//  NotionTitleProperty.h
//  NotionClient
//
//  Created by David De Bels on 14/05/2021.
//

#import "NotionProperty.h"

@class NotionTextPart;

NS_ASSUME_NONNULL_BEGIN

/// MARK: - NotionTitleProperty Interface

@interface NotionTitleProperty : NotionProperty

/// MARK: Properties

@property (nonatomic, strong, readwrite) NSArray<NotionTextPart *> *parts;

@property (nonatomic, copy, readonly, nullable) NSString *plainText;
@property (nonatomic, copy, readwrite, nullable) NSString *title;

/// MARK: Init

+ (NotionTitleProperty *)titleWithName:(NSString *)name title:(NSString *)title;

+ (NotionTitleProperty *)titleWithName:(NSString *)name parts:(NSArray<NotionTextPart *> *)parts;

@end

NS_ASSUME_NONNULL_END
