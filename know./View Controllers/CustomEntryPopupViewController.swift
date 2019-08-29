//
//  CustomEntryPopupViewController.swift
//  know.
//
//  Created by Madison Kaori Shino on 8/29/19.
//  Copyright © 2019 Darin Armstrong. All rights reserved.
//

import UIKit

class CustomEntryPopupViewController: UIViewController {

    var customEntryText = ""
    
    //Outlets
    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var addSymptomTextView: UITextView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setPopupView()
    }
    
    func setPopupView() {
        popupView.layer.cornerRadius = 25
        addSymptomTextView.text = customEntryText
        addSymptomTextView.layer.cornerRadius = 20
        addSymptomTextView.layer.borderWidth = 2
        addSymptomTextView.layer.borderColor = #colorLiteral(red: 0.5245693922, green: 0.6367838979, blue: 0.7222397327, alpha: 1)
    }

    @IBAction func dismissButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        customEntryText = addSymptomTextView.text
        self.performSegue(withIdentifier: "unwindSymptomsVC", sender: self)
    }
    
}
