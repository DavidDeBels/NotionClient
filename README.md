# NotionClient: a Notion SDK for iOS & macOS

<img src="https://github.com/DavidDeBels/NotionClient/raw/main/readme_banner.png" />

Unofficial Notion API SDK for iOS & macOS. This is an alpha version and still work in progress.

## TODO

Features:
- Create new pages in a database
- Add filters & sorts for database query
- Make all objects copyable
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

NotionClient is a native iOS & macOS SDK for [Notion's official API](https://developers.notion.com/). NotionClient converts all API JSON objects to native Foundation objects. API responses are automatically converted to Foundation objects making it a lot easier to read the data coming from Notion. Those same Foundation objects can then be modified and sent back to the API to update the objects. Several objects also have convenience initializers for the most common use cases, e.g. setting a text property with just 1 string in 1 color.

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
	
    pod 'NotionClient', '0.0.1'
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

### Creating a NotionClient

All communication with the Notion API happens using the NotionClient object. To initialize it you'll need a token, see the [official Authorization guide](https://developers.notion.com/docs/authorization) for more info.

Swift:
```swift
let client = NotionClient.init(token: "NOTION_INTEGRATION_TOKEN")
```

Objective-C:
```objectivec
NotionClient *client = [NotionClient clientWithToken:@"NOTION_INTEGRATION_TOKEN"];
```

### More documentation coming soon!

## License

NotionClient is released under an [MIT License](https://opensource.org/licenses/MIT). See LICENSE for details.
