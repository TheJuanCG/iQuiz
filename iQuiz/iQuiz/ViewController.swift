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
    
    let topicImages:[UIImage?] = [
        UIImage(systemName: "pencil"),
        UIImage(systemName: "burst"),
        UIImage(systemName: "sparkles")
    ]
    
    let topicDescriptions:[String] = [
        "This is Mathematics quiz to test you math skills",
        "Test your knowledge on the Marvel Universe",
        "Test your science mind"
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
        cell.imageView?.image = topicImages[indexPath.row]

        
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
    
}
