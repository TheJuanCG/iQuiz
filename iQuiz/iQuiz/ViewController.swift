//
//  ViewController.swift
//  iQuiz
//
//  Created by Juan Carlos Garcia on 4/30/25.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var quizTopicTableView: UITableView!
    
    let topicStrings = [
        "Mathematics",
        "Marvel Super Heroes",
        "Science"
    ]
    
    let topicImages:[String] = []
    
    let topicDescriptions:[String] = [
        "This is Mathematics quiz to test you math skills",
        "This is a quiz that test your knowledge on the Marvel Universe",
        "This is a quiz that test your knowledge to all of Science"
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        quizTopicTableView.delegate = self
        quizTopicTableView.dataSource = self
        
        // TO-DO: Customize cell content so that it has icon (image) on left, Title, and short description sentence
    }
    
    
    // Currently doesn't make a difference because it already is one
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    // Function for what happens the the cell was selected
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Guessing when this is called the UITableView along with index gives the
        // row selected
        if let cell = tableView.cellForRow(at: indexPath) {
            print(cell.textLabel?.text ?? "No text")
        }
        
        print("Selected the row")
    }
    
    
    // Number of rows that we want to show in the table (same as the table cell)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topicStrings.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Trying to see if there is a previous available cell and using it for the new cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "topicCell", for: indexPath)
        
        cell.textLabel?.text = topicStrings[indexPath.row]
        cell.detailTextLabel?.text = topicDescriptions[indexPath.row]
        
        return cell
    }
    
}
