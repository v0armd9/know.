//
//  PopupPickerViewController.swift
//  know.
//
//  Created by Madison Kaori Shino on 8/26/19.
//  Copyright © 2019 Darin Armstrong. All rights reserved.
//

import UIKit

class PopupPickerViewController: UIViewController {

    //Properties
    var birthday: Date?
    
    //Outlets
    @IBOutlet weak var datePickerView: UIDatePicker!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var exitButton: UIButton!
    
    //Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let birthday = birthday else { return }
        datePickerView.setDate(birthday, animated: true)
    }
    
    @IBAction func exitButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        birthday = datePickerView.date
        self.performSegue(withIdentifier: "unwindToProfileSettingsVC", sender: self)
    }
}
