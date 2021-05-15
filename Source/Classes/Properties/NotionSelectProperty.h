//
//  NotionSelectProperty.h
//  NotionClient
//
//  Created by David De Bels on 14/05/2021.
//

#import "NotionProperty.h"

@class NotionSelectOption;

NS_ASSUME_NONNULL_BEGIN

/// MARK: - NotionSelectProperty Interface

@interface NotionSelectProperty : NotionProperty

/// MARK: Properties

@property (nonatomic, strong, readwrite) NotionSelectOption *option;

/// MARK: Init

+ (NotionSelectProperty *)selectWithName:(NSString *)name option:(NSString *)option;

+ (NotionSelectProperty *)selectWithName:(NSString *)name selectOption:(NotionSelectOption *)selectOption;

@end

NS_ASSUME_NONNULL_END
