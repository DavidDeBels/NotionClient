//
//  ViewController.m
//  NotionClientExample
//
//  Created by David De Bels on 15/05/2021.
//

#import <NotionClient/Notion.h>

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NotionClient *client = [NotionClient clientWithToken:@"NOTION_INTEGRATION_TOKEN"];
}

@end
