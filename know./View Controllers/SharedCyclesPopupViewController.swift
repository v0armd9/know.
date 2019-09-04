//
//  SharedCyclesPopupViewController.swift
//  know.
//
//  Created by Madison Kaori Shino on 9/3/19.
//  Copyright © 2019 Darin Armstrong. All rights reserved.
//

import UIKit

class SharedCyclesPopupViewController: UIViewController {

    var sharedUsers: [User] = UserController.shared.viewedUsers
    var selectedUser: User?
    
    //Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var sharedCyclesTableView: UITableView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var acceptButton: UIButton!
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var noSharesLabel: UILabel!
    
    //Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        checkUsersSharing()
        sharedCyclesTableView.delegate = self
        sharedCyclesTableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    

    @IBAction func dismissButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func acceptButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "unwindToHome", sender: self)
    }
    
    func checkUsersSharing() {
        if sharedUsers == [] {
            acceptButton.isHidden = true
            sharedCyclesTableView.isHidden = true
            noSharesLabel.isHidden = false
        } else {
            noSharesLabel.isHidden = true
        }
    }
    
    //Helper func for view
    func setView() {
        popupView.layer.cornerRadius = 25
    }
    
}
extension SharedCyclesPopupViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sharedUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "nameCell", for: indexPath)
        let user = sharedUsers[indexPath.row]
        cell.textLabel?.textColor = #colorLiteral(red: 0.4156521857, green: 0.4157054424, blue: 0.4156340361, alpha: 1)
        cell.textLabel?.text = user.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "nameCell", for: indexPath)
        cell.textLabel?.textColor = #colorLiteral(red: 0.2311019599, green: 0.2311019599, blue: 0.2311019599, alpha: 1)
        let selectedUser = sharedUsers[indexPath.row]
        self.selectedUser = selectedUser
    }
}
