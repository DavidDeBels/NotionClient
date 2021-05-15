# NotionClient: a Notion SDK for iOS & macOS

An unofficial SDK to the public Notion API for iOS. This is an alpha version and still work in progress.

## TODO

Features:
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

NotionClient is a native iOS & macOS SDK for [Notion's official API](https://developers.notion.com/). NotionClient wraps all API responses and JSON objects in native Foundation objects. The same Foundation objects can be used to send to the API so it never necessary to deal with Notion's complex JSON structure 



## Requirements

- Xcode 11+
- iOS 10 or above
- Swift 4.2 or above (when using Swift)


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
platform :ios, '10.0'

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

Import the NotionClient module:

```swift
import NotionClient
```

## Documentation

Coming soon

## License

NotionClient is released under an [MIT License](https://opensource.org/licenses/MIT). See LICENSE for details.
