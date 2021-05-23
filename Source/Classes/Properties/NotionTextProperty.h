//
//  NotionTextProperty.h
//  NotionClient
//
//  Created by David De Bels on 14/05/2021.
//

#import "NotionProperty.h"

@class NotionTextPart;

NS_ASSUME_NONNULL_BEGIN

/// MARK: - NotionTextProperty Interface

@interface NotionTextProperty : NotionProperty

/// MARK: Properties

@property (nonatomic, strong, readwrite) NSArray<NotionTextPart *> *parts;

@property (nonatomic, copy, readwrite, nullable) NSString *text;

/// MARK: Init

+ (NotionTextProperty *)textWithName:(NSString *)name text:(nullable NSString *)text;

+ (NotionTextProperty *)textWithName:(NSString *)name text:(nullable NSString *)text URL:(nullable NSURL *)URL;

+ (NotionTextProperty *)textWithName:(NSString *)name text:(nullable NSString *)text color:(NotionColor)color;

+ (NotionTextProperty *)textWithName:(NSString *)name text:(nullable NSString *)text URL:(nullable NSURL *)URL color:(NotionColor)color;

+ (NotionTextProperty *)textWithName:(NSString *)name text:(nullable NSString *)text URL:(nullable NSURL *)URL color:(NotionColor)color bold:(BOOL)bold italic:(BOOL)italic underline:(BOOL)underline strikethrough:(BOOL)strikethrough code:(BOOL)code;

+ (NotionTextProperty *)textWithName:(NSString *)name parts:(NSArray<NotionTextPart *> *)parts;

@end

NS_ASSUME_NONNULL_END
