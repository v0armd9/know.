//
//  InfoDetailViewController.swift
//  know.
//
//  Created by Madison Kaori Shino on 8/23/19.
//  Copyright © 2019 Darin Armstrong. All rights reserved.
//

import UIKit

class InfoDetailViewController: UIViewController {

    //Properties
    var info: HealthInfo?
    
    //Outlets
    @IBOutlet weak var firstTitleLabel: UILabel!
    @IBOutlet weak var firstTextLabel: UILabel!
    @IBOutlet weak var secondTitleLabel: UILabel!
    @IBOutlet weak var secondTextLabel: UILabel!
    @IBOutlet weak var thirdTitleLabel: UILabel!
    @IBOutlet weak var thirdTextLabel: UILabel!
    @IBOutlet weak var fourthTitleLabel: UILabel!
    @IBOutlet weak var fourthTextLabel: UILabel!
    @IBOutlet weak var fifthTitleLabel: UILabel!
    @IBOutlet weak var fifthTextLabel: UILabel!
    @IBOutlet weak var sixTitleLabel: UILabel!
    @IBOutlet weak var sixTextLabel: UILabel!
    @IBOutlet weak var sevenTitleLabel: UILabel!
    @IBOutlet weak var sevenTextLabel: UILabel!
    @IBOutlet weak var eightTitleLabel: UILabel!
    @IBOutlet weak var eightTextLabel: UILabel!
    @IBOutlet weak var nineTitleLabel: UILabel!
    @IBOutlet weak var nineTextLabel: UILabel!
    
    //Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
        guard let info = info else { return }
        self.title = info.subject
    }
    
    //Helper Function to Load Necessary Data
    func updateView() {
        secondTitleLabel.isHidden = false
        secondTextLabel.isHidden = false
        thirdTitleLabel.isHidden = false
        thirdTextLabel.isHidden = false
        fourthTitleLabel.isHidden = false
        fourthTextLabel.isHidden = false
        fifthTitleLabel.isHidden = false
        fifthTextLabel.isHidden = false
        sixTitleLabel.isHidden = false
        sixTextLabel.isHidden = false
        sevenTitleLabel.isHidden = false
        sevenTextLabel.isHidden = false
        eightTitleLabel.isHidden = false
        eightTextLabel.isHidden = false
        nineTitleLabel.isHidden = false
        nineTextLabel.isHidden = false
        if let info = info {
            firstTitleLabel.text = info.firstSecTitle
            firstTextLabel.text = info.fifthSecBody
            secondTitleLabel.text = info.secSecTitle
            secondTextLabel.text = info.secSecBody
            thirdTitleLabel.text = info.thirdSecTitle
            thirdTextLabel.text = info.thirdSecBody
            fourthTitleLabel.text = info.fourthSecTitle
            fourthTextLabel.text = info.fourthSecBody
            fifthTitleLabel.text = info.fifthSecTitle
            fifthTextLabel.text = info.fifthSecBody
            sixTitleLabel.text = info.sixSecTitle
            sixTextLabel.text = info.sixSecBody
            sevenTitleLabel.text = info.sevenSecTitle
            sevenTextLabel.text = info.sevenSecBody
            if info.eightSecTitle != nil {
                eightTitleLabel.text = info.eightSecTitle
            } else {
                eightTitleLabel.isHidden = true
            }
            if info.eightSecBody != nil {
                eightTextLabel.text = info.eightSecBody
            } else {
                eightTextLabel.isHidden = true
            }
            if info.nineSecTitle != nil {
                nineTitleLabel.text = info.nineSecTitle
            } else {
                nineTitleLabel.isHidden = true
            }
            if info.nineSecBody != nil {
                nineTextLabel.text = info.nineSecBody
            } else {
                nineTextLabel.isHidden = true
            }
        } else {
            firstTitleLabel.text = "Uh Oh!"
            firstTextLabel.text = "We are currently having trouble loading this data. Please come back later."
            secondTitleLabel.isHidden = true
            secondTextLabel.isHidden = true
            thirdTitleLabel.isHidden = true
            thirdTextLabel.isHidden = true
            fourthTitleLabel.isHidden = true
            fourthTextLabel.isHidden = true
            fifthTitleLabel.isHidden = true
            fifthTextLabel.isHidden = true
            sixTitleLabel.isHidden = true
            sixTextLabel.isHidden = true
            sevenTitleLabel.isHidden = true
            sevenTextLabel.isHidden = true
            eightTitleLabel.isHidden = true
            eightTextLabel.isHidden = true
            nineTitleLabel.isHidden = true
            nineTextLabel.isHidden = true
        }
    }
}
