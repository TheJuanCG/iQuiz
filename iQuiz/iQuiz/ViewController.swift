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
        //cell.imageView?.image = quiz.image

        
        return cell
    }
    
    // Adding a navigation item (settings button)
    // Need to make it some screen pops up to add in URL
    // that we will download from
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
        let alert = UIAlertController(title: nil, message: "Error", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("Ok", comment: "Invalid URL"), style: .default, handler: {_ in
            NSLog("User said close")
            alert.dismiss(animated: true)
        }))
        
//        self.present(alert, animated: true)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let settingsVC = storyboard.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
        
        settingsVC.onCheck = { url in
            print("user entered URL: \(url)")
            // TO-DO: Create function to download url data and extract
            // could have it return true or false
            // if return false return the error
            
//            if fetchURLQuizData(stringUrl: url) == false {
//                self.present(alert, animated: true)
//            }
            
            fetchURLQuizData(stringUrl: url) { success in
                if success {
                    self.quizTopicTableView.reloadData()
                } else {
                    self.present(alert, animated: true)
                }
            }
//            self.quizTopicTableView.reloadData()
        }
        
        settingsVC.modalPresentationStyle = .formSheet
        present(settingsVC, animated: true)
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
