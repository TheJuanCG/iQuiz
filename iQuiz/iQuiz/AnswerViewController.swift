//
//  AnswerViewController.swift
//  iQuiz
//
//  Created by Juan Garcia on 5/12/25.
//

import Foundation
import UIKit
// TO-DO: For this one, need to decide whether next would be a question or end of quiz
// Need to keep track of number correct and if the last answer was correct
// Will pass this onto the next screen whether its question or scene

class AnswerViewController: UIViewController {
    
    var selectedQuiz : Quiz?
    var currentQuestion: Question?
    var currentIndex: Int?
    var correctAnswer: Bool?
    var numberCorrectAnswers: Int?

    @IBOutlet weak var isCorrectLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var correctAnswerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        questionLabel.text = "Question: \(currentQuestion!.text)"
        correctAnswerLabel.text = "The correct answer is: \(currentQuestion!.answers[currentQuestion!.correctAnswerIndex])"
        
        // TO-DO: Show if Answer was correct or not
        // Maybe green text if correct and red if wrong
        if correctAnswer == true {
            isCorrectLabel.textColor = .green
            isCorrectLabel.text = "Correct!"
        } else {
            isCorrectLabel.textColor = .red
            isCorrectLabel.text = "Incorrect!"
        }
        
        print("Number of correct answers is \(numberCorrectAnswers!)")
        
        
    }
    @IBAction func nextButtonPressed(_ sender: Any) {
        
        if isLastQuestion() {
            performSegue(withIdentifier: "ShowFinishScene", sender: self)
        } else {
            performSegue(withIdentifier: "ShowQuestionFromAnswerScene", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowFinishScene" {
            let destination = segue.destination as! FinishedViewController
            destination.selectedQuiz = selectedQuiz
            destination.numberCorrectAnswers = numberCorrectAnswers
        } else if segue.identifier == "ShowQuestionFromAnswerScene" {
            let destination = segue.destination as! QuestionViewController
            destination.selectedQuiz = selectedQuiz
            destination.currentQuestion = selectedQuiz!.questions[currentIndex! + 1]
            destination.currentIndex = currentIndex! + 1
            destination.numberCorrectAnswers = numberCorrectAnswers

        }
    }
    
    func isLastQuestion() -> Bool {
        return currentIndex == selectedQuiz!.questions.count - 1
    }
}
