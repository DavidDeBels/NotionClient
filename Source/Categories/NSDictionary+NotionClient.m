//
//  NSDictionary+NotionClient.m
//  NotionClient
//
//  Created by David De Bels on 14/05/2021.
//

#import "NSDictionary+NotionClient.h"

@implementation NSDictionary (NotionClient)

- (NSString *)stringForKeyOrNil:(id<NSCopying>)aKey {
    id object = [self objectForKey:aKey];
    return [object isKindOfClass:[NSString class]] ? (NSString *)object : nil;
}

- (NSNumber *)numberForKeyOrNil:(id<NSCopying>)aKey {
    id object = [self objectForKey:aKey];
    return [object isKindOfClass:[NSNumber class]] ? (NSNumber *)object : nil;
}

- (NSDate *)dateForKeyOrNil:(id<NSCopying>)aKey {
    id object = [self objectForKey:aKey];
    return [object isKindOfClass:[NSDate class]] ? (NSDate *)object : nil;
}

- (NSArray *)arrayForKeyOrNil:(id<NSCopying>)aKey {
    id object = [self objectForKey:aKey];
    return [object isKindOfClass:[NSArray class]] ? (NSArray *)object : nil;
}

- (NSDictionary *)dictionaryForKeyOrNil:(id<NSCopying>)aKey {
    id object = [self objectForKey:aKey];
    return [object isKindOfClass:[NSDictionary class]] ? (NSDictionary *)object : nil;
}

- (NSString *)JSONStringWithError:(NSError **)error {
    NSData *jsonData = [self JSONDataWithError:error];
    if (jsonData) {
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    return nil;
}

- (NSData *)JSONDataWithError:(NSError **)error {
    return [NSJSONSerialization dataWithJSONObject:self options:0 error:error];
}

@end
