//
//  NotionPhoneProperty.h
//  NotionClient
//
//  Created by David De Bels on 14/05/2021.
//

#import "NotionProperty.h"

NS_ASSUME_NONNULL_BEGIN

/// MARK: - NotionPhoneProperty Interface

@interface NotionPhoneProperty : NotionProperty

/// MARK: Properties

@property (nonatomic, copy, readwrite, nullable) NSString *phoneNumber;

/// MARK: Init

+ (NotionPhoneProperty *)phoneWithName:(NSString *)name phoneNumber:(NSString *)phoneNumber;

@end

NS_ASSUME_NONNULL_END
