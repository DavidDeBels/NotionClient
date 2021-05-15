//
//  NotionMultiSelectProperty.h
//  NotionClient
//
//  Created by David De Bels on 14/05/2021.
//

#import "NotionProperty.h"

@class NotionSelectOption;

NS_ASSUME_NONNULL_BEGIN

/// MARK: - NotionMultiSelectProperty Interface

@interface NotionMultiSelectProperty : NotionProperty

/// MARK: Properties

@property (nonatomic, strong, readwrite) NSArray<NotionSelectOption *> *options;

/// MARK: Init

+ (NotionMultiSelectProperty *)multiSelectWithName:(NSString *)name options:(NSArray<NSString *> *)options;

+ (NotionMultiSelectProperty *)multiSelectWithName:(NSString *)name selectOptions:(NSArray<NotionSelectOption *> *)selectOptions;

@end

NS_ASSUME_NONNULL_END
