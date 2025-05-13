//
//  FinishedViewController.swift
//  iQuiz
//
//  Created by Juan Garcia on 5/12/25.
//

import Foundation
import UIKit

class FinishedViewController: UIViewController {
    var selectedQuiz: Quiz?
    var numberCorrectAnswers: Int?
    
    @IBOutlet weak var performanceLabel: UILabel!
    @IBOutlet weak var numberCorrectLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // TO-DO: Next button that goes back to main page
        if numberCorrectAnswers == selectedQuiz!.questions.count {
            performanceLabel.text = "Perfect!"
        } else {
            performanceLabel.text = "Almost!"
        }
        
        numberCorrectLabel.text = "You got \(numberCorrectAnswers!) out of \(selectedQuiz!.questions.count) questions correct"
    }
}
