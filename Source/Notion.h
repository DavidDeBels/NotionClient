//
//  Notion.h
//  NotionClient
//
//  Created by David De Bels on 14/05/2021.
//

#import <Foundation/Foundation.h>

//! Project version number for NotionClient.
FOUNDATION_EXPORT double NotionClientVersionNumber;

//! Project version string for NotionClient.
FOUNDATION_EXPORT const unsigned char NotionClientVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <NotionClient/PublicHeader.h>

#ifndef _NOTIONCLIENT_
#define _NOTIONCLIENT_

// Main
#import <NotionClient/NotionTypes.h>
#import <NotionClient/NotionClient.h>

// Objects
#import <NotionClient/NotionUser.h>
#import <NotionClient/NotionPage.h>

// Properties
#import <NotionClient/NotionTitleProperty.h>
#import <NotionClient/NotionTextProperty.h>
#import <NotionClient/NotionNumberProperty.h>
#import <NotionClient/NotionSelectProperty.h>
#import <NotionClient/NotionMultiSelectProperty.h>
#import <NotionClient/NotionDateProperty.h>
#import <NotionClient/NotionPersonProperty.h>
#import <NotionClient/NotionCheckboxProperty.h>
#import <NotionClient/NotionURLProperty.h>
#import <NotionClient/NotionEmailProperty.h>
#import <NotionClient/NotionPhoneProperty.h>
#import <NotionClient/NotionRelationProperty.h>
#import <NotionClient/NotionFormulaProperty.h>

// Rich Text
#import <NotionClient/NotionRichText.h>

// Database query
#import <NotionClient/NotionFilterGroup.h>
#import <NotionClient/NotionTextFilter.h>
#import <NotionClient/NotionNumberFilter.h>
#import <NotionClient/NotionCheckboxFilter.h>
#import <NotionClient/NotionSelectFilter.h>
#import <NotionClient/NotionMultiSelectFilter.h>
#import <NotionClient/NotionPersonFilter.h>
#import <NotionClient/NotionRelationFilter.h>
#import <NotionClient/NotionFileFilter.h>
#import <NotionClient/NotionSort.h>

// Misc
#import <NotionClient/NotionSelectOption.h>

#endif
