//
//  ViewController.swift
//  iQuiz
//
//  Created by Juan Carlos Garcia on 4/30/25.
//

import UIKit




class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var quizTopicTableView: UITableView!
    
    var selectedQuiz: Quiz?
    

    // Will pass whichever one we need to the question view controller (depends on which button is selected)
    let quizzes: [Quiz] = [
        Quiz(topic: "Mathematics",
             description: "Test your math skills now",
             questions: [
                Question(text: "What is 5 + 7?",
                         answers: ["10", "11", "12", "13"],
                         correctAnswerIndex: 2),
                Question(text: "What is the square root of 16?",
                         answers: ["2", "4", "8", "16"],
                         correctAnswerIndex: 1),
                Question(text: "What is 9 x 3?",
                         answers: ["27", "21", "18", "36"],
                         correctAnswerIndex: 0)
             ],
             image: UIImage(systemName: "pencil")),

        Quiz(topic: "Marvel Super Heroes",
             description: "Test your knowledge on the Marvel Universe",
             questions: [
                Question(text: "Who is Spider-Man?",
                         answers: ["Spider", "Peter Parker", "Harry Osborn", "Tony Stark"],
                         correctAnswerIndex: 1),
                Question(text: "Which superhero uses a shield?",
                         answers: ["Iron Man", "Hulk", "Captain America", "Thor"],
                         correctAnswerIndex: 2),
                Question(text: "What is Iron Man's real name?",
                         answers: ["Steve Rogers", "Bruce Banner", "Tony Stark", "Clint Barton"],
                         correctAnswerIndex: 2)
             ],
             image: UIImage(systemName: "burst")),

        Quiz(topic: "Science",
             description: "Test your science mind",
             questions: [
                Question(text: "What planet is known as the Red Planet?",
                         answers: ["Mars", "Jupiter", "Venus", "Saturn"],
                         correctAnswerIndex: 0),
                Question(text: "What gas do plants absorb from the atmosphere?",
                         answers: ["Oxygen", "Hydrogen", "Carbon Dioxide", "Nitrogen"],
                         correctAnswerIndex: 2),
                Question(text: "What is H2O commonly known as?",
                         answers: ["Hydrogen", "Oxygen", "Water", "Salt"],
                         correctAnswerIndex: 2)
             ],
             image: UIImage(systemName: "sparkles"))
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        title = "Quiz Topic Page"
        
        quizTopicTableView.delegate = self
        quizTopicTableView.dataSource = self
        
        // TO-DO: Customize cell content so that it has icon (image) on left, Title, and short description sentence
        configureItems()
    }
    
    
    // Currently doesn't make a difference because it already is one
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    // Function for what happens the the cell was selected
    // Where we will add the segue to the QuestionViewController (with source data)
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Guessing when this is called the UITableView along with index gives the
        // row selected
        // can pass the index of questions selected quizzes[indexPath] into source code
        if let cell = tableView.cellForRow(at: indexPath) {
            print(cell.textLabel?.text ?? "No text")
        }
        
        selectedQuiz = quizzes[indexPath.row]
        
        //performSegue(withIdentifier: "ShowQuestionScene", sender: self)
        
        print("Selected the row")
    }
    
    
    // Number of rows that we want to show in the table (same as the table cell)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quizzes.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Trying to see if there is a previous available cell and using it for the new cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "topicCell", for: indexPath)
        let quiz = quizzes[indexPath.row]
        
        cell.textLabel?.text = quiz.topic
        cell.detailTextLabel?.text = quiz.description
        cell.imageView?.image = quiz.image

        
        return cell
    }
    
    // Adding a navigation item (settings button)
    private func configureItems() {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(
                image: UIImage(systemName: "gear"),
                style: .plain,
                target: self,
                action: #selector(sendSettingsAlert)
            )
    }
    
    // Function to send alert when button is pressed (Used Professor demo repo for code)
    @objc private func sendSettingsAlert() {
        let alert = UIAlertController(title: nil, message: "Settings go here", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("Ok", comment: "Close the alert"), style: .default, handler: {_ in
            NSLog("User said close")
            alert.dismiss(animated: true)
        }))
        
        self.present(alert, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Runs this before selecting new quiz
        
        print("Running the prepare function")
        if segue.identifier == "ShowQuestionScene" {
            
            guard
                let cell = sender as? UITableViewCell,
                let indexPath = quizTopicTableView.indexPath(for: cell)
            else { return }
            
            let quiz = quizzes[indexPath.row]
            let destination = segue.destination as! QuestionViewController
            
            destination.selectedQuiz = quiz
            destination.currentIndex = 0
            destination.currentQuestion = quiz.questions[0]
            destination.numberCorrectAnswers = 0
        }
    }
    
}
