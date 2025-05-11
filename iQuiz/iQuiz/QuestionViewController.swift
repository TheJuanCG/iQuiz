//
//  QuestionViewController.swift
//  iQuiz
//
//  Created by Juan Garcia on 5/10/25.
//

import Foundation

import UIKit

class QuestionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var questionsTableView: UITableView!
    
    var selectedQuiz : Quiz?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Question"
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // Selecting answer (AKA row)
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            print(cell.textLabel?.text ?? "No text")
        }
        
        print("Selected the row")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let quiz = selectedQuiz {
            return quiz.questions.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Trying to see if there is a previous available cell and using it for the new cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "questionCell", for: indexPath)
        
        cell.textLabel?.text = selectedQuiz?.questions[indexPath.row].text
        return cell
    }
}
