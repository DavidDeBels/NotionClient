//
//  NotionCheckboxProperty.h
//  NotionClient
//
//  Created by David De Bels on 14/05/2021.
//

#import "NotionProperty.h"

NS_ASSUME_NONNULL_BEGIN

/// MARK: - NotionCheckboxProperty Interface

@interface NotionCheckboxProperty : NotionProperty

/// MARK: Properties

@property (nonatomic, assign, readwrite) BOOL checked;

/// MARK: Init

+ (NotionCheckboxProperty *)checkboxWithName:(NSString *)name checked:(BOOL)checked;

@end

NS_ASSUME_NONNULL_END
