//
//  ViewController.swift
//  NotionClientExample
//
//  Created by David De Bels on 15/05/2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let client = NotionClient.init(token: "NOTION_INTEGRATION_TOKEN")
    }


}

