//
//  SettingsViewController.swift
//  iQuiz
//
//  Created by Juan Garcia on 5/15/25.
//

import Foundation
import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var inputURLField: UITextField!
    
    var onCheck:((String) -> Void)?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        inputURLField.text = "https://tednewardsandbox.site44.com/questions.json"
    }
    
    
    @IBAction func checkNowPressed(_ sender: Any) {
        // Do the download here?
        let url = inputURLField.text ?? ""
        onCheck?(url)
        dismiss(animated: true)
    }
}
