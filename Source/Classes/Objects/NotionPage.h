//
//  NotionPage.h
//  NotionClient
//
//  Created by David De Bels on 14/05/2021.
//

#import "NotionObject.h"
#import "NotionProperty.h"

@class NotionTitleProperty;

NS_ASSUME_NONNULL_BEGIN

/// MARK: - NotionPage Interface

@interface NotionPage : NotionObject

/// MARK: Properties

/// Returns the created time of the page.
@property (nonatomic, copy, readonly) NSDate *createdTime;

/// Returns the last edited time of the page.
@property (nonatomic, copy, readonly) NSDate *lastEditedTime;

/// Marks the page as archived. In Notion this means the trash bin.
@property (nonatomic, assign, readwrite) BOOL archived;

/// The type of the parent of the page. Either workspace, page or database.
@property (nonatomic, assign, readwrite) NotionParentType parentType;

/// The id of the parent of the page. If the parent is a page this will be that page's id. If the parent is a database this will that database's id. If the parent is the workspace this will be nil.
@property (nonatomic, copy, readwrite, nullable) NSString *parentId;

/// The properties of the page by name.
@property (nonatomic, copy, readwrite) NSDictionary<NSString *, NotionProperty *> *properties;

/// Returns the name of the title property of the page. There should only ever be 1 title property per page.
@property (nonatomic, copy, readonly, nullable) NSString *titlePropertyName;

/// The title property of the page. There should only ever be 1 title property per page. Setting this will replace the existing title property.
@property (nonatomic, strong, readwrite, nullable) NotionTitleProperty *titleProperty;

/// The title of the page as plain text. Setting this will overwrite the text of the title property.
@property (nonatomic, copy, readwrite, nullable) NSString *title;

/// MARK: Init

/// Create a new NotionPage object with a default title property.
/// @param title The title of the page.
+ (NotionPage *)pageWithTitle:(NSString *)title;

/// Create a new NotionPage object with page properties.
/// @param properties The page properties.
+ (NotionPage *)pageWithProperties:(NSArray<NotionProperty *> *)properties;

/// MARK: Modify Page Properties

/// Add a property. If a property already exists for this name it will be replaced.
/// @param property The property.
- (void)addProperty:(NotionProperty *)property;

/// Removes a property with a specific name.
/// @param name The name of the property.
- (void)removePropertyWithName:(NSString *)name;

/// MARK: Serialize

- (NSMutableDictionary *)serializedObject;

@end

NS_ASSUME_NONNULL_END
