//
//  NotionEquation.h
//  NotionClient
//
//  Created by David De Bels on 15/05/2021.
//

#import "NotionTextPart.h"

NS_ASSUME_NONNULL_BEGIN

/// MARK: - NotionEquation Interface

@interface NotionEquation : NotionTextPart

@property (nonatomic, copy, readwrite, nullable) NSString *expression;

/// MARK: Convenience Init

+ (NotionEquation *)equationWithExpression:(nullable NSString *)expression NS_SWIFT_NAME(equation(expression:));

/// MARK: Init

- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
