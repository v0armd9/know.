//
//  SettingListTableViewController.swift
//  know.
//
//  Created by Madison Kaori Shino on 8/26/19.
//  Copyright © 2019 Darin Armstrong. All rights reserved.
//

import UIKit

class SettingListTableViewController: UITableViewController {

    
    @IBOutlet weak var navBarItem: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavTitle()
    }
    
    func setNavTitle() {
        let label = UILabel()
        label.text = "Settings"
        label.textColor = #colorLiteral(red: 0.554766655, green: 0.7184440494, blue: 0.8180738091, alpha: 1)
        label.textAlignment = .center
        label.sizeToFit()
        label.font = UIFont(name: "Nunito-Regular", size: 30)
        navigationItem.titleView = label
    }
}
