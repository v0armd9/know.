//
//  InfoListViewController.swift
//  know.
//
//  Created by Madison Kaori Shino on 8/23/19.
//  Copyright © 2019 Darin Armstrong. All rights reserved.
//

import UIKit

class InfoListViewController: UIViewController {

    //Properties
    
    //Outlets
    @IBOutlet weak var infoTitleLabel: UILabel!
    @IBOutlet weak var infoListTableView: UITableView!
    
    //Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.backgroundColor = .cyan
        infoListTableView.dataSource = self
        infoListTableView.delegate = self
        HealthInfoController.shared.loadHealthInfo()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.infoListTableView.reloadData()
    }
    
    //Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toInfoDetailVC" {
            guard let indexPath = infoListTableView.indexPathForSelectedRow else { return }
            let destination = segue.destination as? InfoDetailViewController
            let category = HealthInfoController.shared.infoCategories[indexPath.row]
            destination?.info = category
        }
    }
}

//Table View Data Source
extension InfoListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HealthInfoController.shared.infoCategories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath)
        let categories = HealthInfoController.shared.infoCategories
        let category = categories[indexPath.row]
        cell.textLabel?.text = category.subject
        return cell
    }
}
