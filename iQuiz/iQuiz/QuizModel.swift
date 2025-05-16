//
//  QuizModel.swift
//  iQuiz
//
//  Created by Juan Garcia on 5/10/25.
//

import Foundation
import UIKit

struct Quiz: Codable {
    let topic: String
    let description: String
    let questions: [Question]

    enum CodingKeys: String, CodingKey {
        case topic = "title"
        case description = "desc"
        case questions
    }
}

struct Question: Codable {
    let text: String
    let answers: [String]
    let correctAnswerIndex: String

    enum CodingKeys: String, CodingKey {
        case text
        case answers
        case correctAnswerIndex = "answer"
    }
}

var quizzes: [Quiz] = [
    Quiz(topic: "Mathematics",
         description: "Test your math skills now",
         questions: [
            Question(text: "What is 5 + 7?",
                     answers: ["10", "11", "12", "13"],
                     correctAnswerIndex: "2"),
            Question(text: "What is the square root of 16?",
                     answers: ["2", "4", "8", "16"],
                     correctAnswerIndex: "1"),
            Question(text: "What is 9 x 3?",
                     answers: ["27", "21", "18", "36"],
                     correctAnswerIndex: "0")
         ]),

    Quiz(topic: "Marvel Super Heroes",
         description: "Test your knowledge on the Marvel Universe",
         questions: [
            Question(text: "Who is Spider-Man?",
                     answers: ["Spider", "Peter Parker", "Harry Osborn", "Tony Stark"],
                     correctAnswerIndex: "1"),
            Question(text: "Which superhero uses a shield?",
                     answers: ["Iron Man", "Hulk", "Captain America", "Thor"],
                     correctAnswerIndex: "2"),
            Question(text: "What is Iron Man's real name?",
                     answers: ["Steve Rogers", "Bruce Banner", "Tony Stark", "Clint Barton"],
                     correctAnswerIndex: "2")
         ]),

    Quiz(topic: "Science",
         description: "Test your science mind",
         questions: [
            Question(text: "What planet is known as the Red Planet?",
                     answers: ["Mars", "Jupiter", "Venus", "Saturn"],
                     correctAnswerIndex: "0"),
            Question(text: "What gas do plants absorb from the atmosphere?",
                     answers: ["Oxygen", "Hydrogen", "Carbon Dioxide", "Nitrogen"],
                     correctAnswerIndex: "2"),
            Question(text: "What is H2O commonly known as?",
                     answers: ["Hydrogen", "Oxygen", "Water", "Salt"],
                     correctAnswerIndex: "2")
         ]),
]


func fetchURLQuizData(stringUrl: String, completion: @escaping (Bool) -> Void) {
    guard let url = URL(string: stringUrl) else {
        print("Bad URL")
        completion(false)
        return
    }

    URLSession.shared.dataTask(with: url) { data, response, error in
        DispatchQueue.main.async {
            if let error = error {
                print("Error fetching data: \(error)")
                completion(false)
                return
            }

            guard let data = data else {
                print("No data")
                completion(false)
                return
            }

            do {
                let decoder = JSONDecoder()
                quizzes = try decoder.decode([Quiz].self, from: data)
                completion(true)
            } catch {
                print("Decoding failed: \(error)")
                completion(false)
            }
        }
    }.resume()
}

