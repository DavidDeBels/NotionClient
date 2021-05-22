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

/// MARK: Convenience Init

+ (NotionRichText *)textWithContent:(nullable NSString *)content NS_SWIFT_NAME(text(_:));

+ (NotionRichText *)textWithContent:(nullable NSString *)content URL:(nullable NSURL *)URL NS_SWIFT_NAME(text(_:URL:));

+ (NotionRichText *)textWithContent:(nullable NSString *)content color:(NotionColor)color  NS_SWIFT_NAME(text(_:color:));

+ (NotionRichText *)textWithContent:(nullable NSString *)content URL:(nullable NSURL *)URL color:(NotionColor)color NS_SWIFT_NAME(text(_:URL:color:));

+ (NotionRichText *)textWithContent:(nullable NSString *)content URL:(nullable NSURL *)URL color:(NotionColor)color bold:(BOOL)bold italic:(BOOL)italic underline:(BOOL)underline strikethrough:(BOOL)strikethrough code:(BOOL)code;

/// MARK: Init

- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
