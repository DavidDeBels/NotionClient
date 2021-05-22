//
//  NotionSort.m
//  NotionClient
//
//  Created by David De Bels on 20/05/2021.
//

#import "NotionSort.h"

/// MARK: NotionSort Implementation

@implementation NotionSort

/// MARK: Convenience Init

+ (NotionSort *)ascendingOnProperty:(NSString *)propertyName {
    return [[NotionSort alloc] initForProperty:propertyName direction:NotionSortDirectionAscending];
}

+ (NotionSort *)descendingOnProperty:(NSString *)propertyName {
    return [[NotionSort alloc] initForProperty:propertyName direction:NotionSortDirectionDescending];
}

+ (NotionSort *)ascendingOnCreatedTime {
    return [[NotionSort alloc] initForCreatedTimeWithDirection:NotionSortDirectionAscending];
}

+ (NotionSort *)descendingOnCreatedTime {
    return [[NotionSort alloc] initForCreatedTimeWithDirection:NotionSortDirectionDescending];
}

+ (NotionSort *)ascendingOnLastEditedTime {
    return [[NotionSort alloc] initForLastEditedTimeWithDirection:NotionSortDirectionAscending];
}

+ (NotionSort *)descendingOnLastEditedTime {
    return [[NotionSort alloc] initForLastEditedTimeWithDirection:NotionSortDirectionDescending];
}

/// MARK: Init

- (instancetype)initForProperty:(NSString *)propertyName direction:(NotionSortDirection)direction {
    if (!propertyName) {
        return nil;
    }
    
    self = [self  init];
    if (self) {
        _type = NotionSortTypeProperty;
        _direction = direction;
        _propertyName = propertyName;
    }
    
    return self;
}

- (instancetype)initForCreatedTimeWithDirection:(NotionSortDirection)direction {
    self = [self  init];
    if (self) {
        _type = NotionSortTypeCreatedTime;
        _direction = direction;
    }
    
    return self;
}

- (instancetype)initForLastEditedTimeWithDirection:(NotionSortDirection)direction {
    self = [self  init];
    if (self) {
        _type = NotionSortTypeLastEditedTime;
        _direction = direction;
    }
    
    return self;
}

/// MARK: Getters & Setters

- (void)setDirection:(NotionSortDirection)direction {
    if (direction != NotionSortDirectionDescending) {
        _direction = NotionSortDirectionAscending;
    } else {
        _direction = NotionSortDirectionDescending;
    }
}

/// MARK: Serialize

- (NSMutableDictionary *)serializedObject {
    NSMutableDictionary *dictionary = [NSMutableDictionary new];
    
    if (self.direction == NotionSortDirectionDescending) {
        dictionary[@"direction"] = @"descending";
    } else {
        dictionary[@"direction"] = @"ascending";
    }
    
    if (self.type == NotionSortTypeProperty) {
        dictionary[@"property"] = self.propertyName;
    } else if (self.type == NotionSortTypeCreatedTime) {
        dictionary[@"timestamp"] = @"created_time";
    } else if (self.type == NotionSortTypeLastEditedTime) {
        dictionary[@"timestamp"] = @"last_edited_time";
    }
    
    return dictionary;
}

@end
