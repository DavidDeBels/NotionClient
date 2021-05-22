//
//  NotionFormulaProperty.h
//  NotionClient
//
//  Created by David De Bels on 14/05/2021.
//

#import "NotionProperty.h"

NS_ASSUME_NONNULL_BEGIN

/// MARK: - NotionFormulaProperty Interface

@interface NotionFormulaProperty : NotionProperty

/// MARK: Properties

@property (nonatomic, assign, readonly) NotionFormulaType resultType;

@property (nonatomic, copy, readonly, nullable) NSString *textResult;
@property (nonatomic, copy, readonly, nullable) NSNumber *numberResult;
@property (nonatomic, copy, readonly, nullable) NSDate *startDateResult;
@property (nonatomic, copy, readonly, nullable) NSDate *endDateResult;
@property (nonatomic, assign, readonly) BOOL boolResult;

@end

NS_ASSUME_NONNULL_END
