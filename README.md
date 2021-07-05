# NotionClient: a Notion SDK for iOS & macOS

<img src="https://github.com/DavidDeBels/NotionClient/raw/main/readme_banner.png" />

Unofficial Notion API SDK for iOS & macOS. This is an alpha version and still work in progress.

## TODO

Features:
- Create new pages in a database (WIP)
- Make all objects copyable (WIP)
- Add date & formula filters
- Add Foundation objects for blocks / modifying page contents

Documentation:
- Add documentation for all methods
- Add sample project for Objective-C
- Add sample project for Swift

Support:
- Add support for macOS
- Add support for tvOS
- Add support for watchOS?
- Add OAuth2 authorization support? (currently not possible due to limitations in redirect URI)


## Introduction

NotionClient is a native iOS & macOS SDK for [Notion's official API](https://developers.notion.com/). API responses are automatically converted to native Foundation objects making it a lot easier to read the data coming from Notion. Those same Foundation objects can then be modified and sent back to the API to update the objects. Most objects also have convenience initializers for the most common use cases, e.g. setting a text property with just 1 string in 1 color.

This way, there is never any need to deal with Notion's complex JSON structure directly. 


## Requirements

- iOS 11 or above


## Installation

NotionClient does not use any external dependencies.

### Manually

1. Open NotionClient.xcodeproj
2. Build the NotionClient-iOS scheme
3. Copy the generated NotionClient.framework file to your project

### Using CocoaPods

Add NotionClient to your Podfile and run `pod install`.

```ruby
# Podfile
platform :ios, '11.0'

target 'YOUR_TARGET_NAME' do
    # Dynamic frameworks is supported but not required
    use_frameworks!
	
    pod 'NotionClient'
end
```

## Usage

### Objective-C

Import Notion.h in the implementation files (or in a Prefix header):

```objectivec
#import <NotionClient/Notion.h>
```

### Swift

Import Notion.h in the Objective-C Bridging Header:

```objectivec
// Bridging header
#import <NotionClient/Notion.h>
```

## Documentation

### General information

All communication with the Notion API happens by using a NotionClient object. A NotionClient requires an integration token to be able to communicate with the Notion API, see the [official Authorization guide](https://developers.notion.com/docs/authorization) for more information on how to create an integration and a token. Multiple NotionClient objects can be used, each using different integration tokens.  

Once initialized a NotionClient object can make requests to the Notion API:
* All requests to the Notion API are asynchronous and will return the result (or error) in a completion handler. 
* If the request was successful, the response will be returned in the completion handler in the form of one or multiple native objects (e.g. NotionPage or NotionUser). These objects are (often simplified) wrappers around the JSON objects that the Notion API returns. These  exist to simplify reading and writing data from/to the Notion API. It should never be necessary to deal with JSON directly. 
* If the request has failed, an NSError object will be returned in the completion handler. In case of an API error, the error object's code will be the HTTP status code and the response body containing the error message will be in the userInfo dictionary of the error object. 
* Requests that use pagination are handled automatically by default for simplicity sake. If a response indicates that more items are available, a new request will be made to fetch the next page. This means that calling a function on a NotionClient to get a list may do multiple API requests behind the scenes. The completion handler will return the results of all pages. The page size is set to 100 by default (the maximum) but this can be modified. 
* At the moment there is no way to handle paginated requests manually but this will be added in the future.

For all documentation, visit the <a href="https://github.com/DavidDeBels/NotionClient/wiki" target="_blank">Wiki</a>.


### Creating a NotionClient

Creating a NotionClient is simple, just pass an integration token and you're good to go. 

Swift:
```swift
let client = NotionClient.init(token: "NOTION_INTEGRATION_TOKEN")
```

Objective-C:
```objectivec
NotionClient *client = [NotionClient clientWithToken:@"NOTION_INTEGRATION_TOKEN"];
```

### Getting all users

To get all users in the workspace, you can use NotionClient's `getUsers` method. This will return an array of NotionUser objects. From there you can get the user's ID, name, email, etc.

Swift:
```swift
client.getUsers { (users, error) in
    let user = users?.first
}
```

Objective-C:
```objectivec
[self.notionClient getUsersWithCompletion:^(NSArray<NotionUser *> * _Nonnull users, NSError * _Nonnull error) {
    NotionUser *user = users.firstObject;
}];
```

### Query a database

To get pages from a database, you can use NotionClient's `queryDatabase` method. This will return an array of NotionPage objects. From there you can access the page's properties, title, parent, etc.

Swift:
```swift
client.queryDatabase(id: "DATABASE_ID") { (pages, error) in
    let page = pages?.first
}
```

Objective-C:
```objectivec
[self.notionClient queryDatabaseWithId:@"DATABASE_ID" completion:^(NSArray<NotionPage *> * _Nullable pages, NSError * _Nullable error) {
    NotionPage *page = pages.firstObject;
}];
```

Optionally you can provide a NotionFilter and/or an array of NotionSort objects to either filter results or have them return in a specific order or both.

Swift:
```swift
let filter = NotionTextFilter.property("Country", equals: "Belgium")
let sorts = [
    NotionSort.descendingOnProperty(name: "Inhabitants"),
    NotionSort.ascendingOnProperty(name: "City")
]

client.queryDatabase(id: "DATABASE_ID", filter: filter, sorts: sorts) { (page, error) in
    let page = pages?.first
}
```

Objective-C:
```objectivec
NotionFilter *filter = [NotionTextFilter property:@"Country" equals:@"Belgium"];
NSArray *sorts = @[
    [NotionSort descendingOnProperty:@"Inhabitants"],
    [NotionSort ascendingOnProperty:@"City"]
];

[self.notionClient queryDatabaseWithId:@"DATABASE_ID" filter:filter sorts:sorts completion:^(NSArray<NotionPage *> * _Nullable pages, NSError * _Nullable error) {
    NotionPage *page = pages.firstObject;
}];
```

To use multiple filters, create a NotionFilterGroup object, which is a collection of multiple NotionFilters. A NotionFilterGroup is also a NotionFilter, so groups can be nested up to 2 levels deep. For more information see the [official documentation on Compound Filters](https://developers.notion.com/reference/post-database-query#compound-filters).

Swift:
```swift
let filter = NotionFilterGroup.orGroup(with: [
    NotionTextFilter.property("Country", equals: "Belgium"),
    NotionFilterGroup.andGroup(with: [
        NotionCheckboxFilter.property("Visited", equals: true),
        NotionFilterGroup.orGroup(with: [
            NotionMultiSelectFilter.property("Languages", contains: "English"),
            NotionFileFilter.propertyIsNotEmpty("Flag")
        ])
    ])
])
```

Objective-C:
```objectivec
NotionFilter *filter = [NotionFilterGroup orGroupWithFilters:@[
    [NotionTextFilter property:@"Country" equals:@"Belgium"],
    [NotionFilterGroup andGroupWithFilters:@[
        [NotionCheckboxFilter property:@"Visited" equals:YES],
        [NotionFilterGroup orGroupWithFilters:@[
            [NotionMultiSelectFilter property:@"Languages" contains:@"English"],
            [NotionFileFilter propertyIsNotEmpty:@"Flag"]
        ]]
    ]]
]];
```

### More documentation coming soon!

## License

NotionClient is released under an [MIT License](https://opensource.org/licenses/MIT). See LICENSE for details.
