//
//  NotionRichText.h
//  NotionClient
//
//  Created by David De Bels on 15/05/2021.
//

#import "NotionTextPart.h"

NS_ASSUME_NONNULL_BEGIN

/// MARK: - NotionTextPart Interface

@interface NotionRichText : NotionTextPart

@property (nonatomic, copy, readwrite, nullable) NSString *content;

/// MARK: Init

+ (NotionRichText *)textWithContent:(nullable NSString *)content;

+ (NotionRichText *)textWithContent:(nullable NSString *)content URL:(nullable NSURL *)URL;

+ (NotionRichText *)textWithContent:(nullable NSString *)content color:(NotionColor)color;

+ (NotionRichText *)textWithContent:(nullable NSString *)content URL:(nullable NSURL *)URL color:(NotionColor)color;

+ (NotionRichText *)textWithContent:(nullable NSString *)content URL:(nullable NSURL *)URL color:(NotionColor)color bold:(BOOL)bold italic:(BOOL)italic underline:(BOOL)underline strikethrough:(BOOL)strikethrough code:(BOOL)code;

@end

NS_ASSUME_NONNULL_END
