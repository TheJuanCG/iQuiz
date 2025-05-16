//
//  QuestionViewController.swift
//  iQuiz
//
//  Created by Juan Garcia on 5/10/25.
//

import Foundation

import UIKit

class QuestionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    // TO-DO: Add submit button
    // TO-DO: Add question at the top
    
    @IBOutlet weak var questionLable: UILabel!
    @IBOutlet weak var questionsTableView: UITableView!
    
    var selectedQuiz : Quiz?
    var currentQuestion: Question?
    var currentIndex: Int?
    var selectedAnswer: Int?
    var numberCorrectAnswers: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Question"
        questionsTableView.delegate = self
        questionsTableView.dataSource = self
        
        questionLable.text = currentQuestion?.text
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // Selecting answer (AKA row)
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            print(cell.textLabel?.text ?? "No text")
        }
        
        // Used to keep track of which answer was selected
        selectedAnswer = indexPath.row
        
        print("Selected the row")
    }
    
    // Need to input the number of options for a particular question
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let question = currentQuestion {
            return question.answers.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Trying to see if there is a previous available cell and using it for the new cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "questionCell", for: indexPath)
        
        cell.textLabel?.text = currentQuestion?.answers[indexPath.row]
        return cell
    }
    
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if selectedAnswer == nil {
            return false
        }
        
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ShowAnswerScene" {
            
            
            
            let destination = segue.destination as! AnswerViewController
            
            destination.selectedQuiz = selectedQuiz
            destination.currentIndex = currentIndex
            destination.currentQuestion = currentQuestion
            
            
            if selectedAnswer == Int(currentQuestion!.correctAnswerIndex) {
                destination.correctAnswer = true
                destination.numberCorrectAnswers = numberCorrectAnswers! + 1
            } else {
                destination.correctAnswer = false
                destination.numberCorrectAnswers = numberCorrectAnswers
            }
        }
    }
    
}
