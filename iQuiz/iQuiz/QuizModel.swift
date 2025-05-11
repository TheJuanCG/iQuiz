//
//  QuizModel.swift
//  iQuiz
//
//  Created by Juan Garcia on 5/10/25.
//

import Foundation
import UIKit

struct Quiz {
    let topic: String
    let description: String
    let questions: [Question]
    let image: UIImage?
}

struct Question {
    let text: String
    let answers: [String]
    let correctAnswerIndex: Int
}
