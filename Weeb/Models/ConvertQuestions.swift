//
//  ConvertQuestions.swift
//  Weeb
//
//  Created by HaroldDavidson on 6/10/21.
//

import Foundation

var questionList = [Question]()
var questionIndex = 0
var questionArr = [Question]()

class Question {
    let anime: String
    let question: String
    let answer: Int
    let optionOne: String
    let optionTwo: String
    
    init(anime: String, question: String, answer: Int, optionOne: String, optionTwo: String) {
        self.anime = anime
        self.question = question
        self.answer = answer
        self.optionOne = optionOne
        self.optionTwo = optionTwo
    }
}

func convertJSON(jsonToRead: String) {
    // clearing out the questionArr before converting JSON
    questionArr = [Question]()
    
    guard let path = Bundle.main.path(forResource: jsonToRead, ofType: "json") else { return }
    let url = URL(fileURLWithPath: path)
    
    do {
        let data = try Data(contentsOf: url)
        let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
        
        guard let jsonArray = json as? [Any] else { return }
        
        for questionAnswer in jsonArray {
            guard let questionAndAnswer = questionAnswer as? [String: Any] else { return }
            
            // assigning the values in the JSON to local variables
            guard let anime         = questionAndAnswer["anime"] as? String else { return }
            guard let question      = questionAndAnswer["question"] as? String else { return }
            guard let answer        = questionAndAnswer["answer"] as? Int else { return }
            guard let optionOne     = questionAndAnswer["optionOne"] as? String else { return }
            guard let optionTwo     = questionAndAnswer["optionTwo"] as? String else { return }
            
            // creating a new instance of the Question object
            let qa = Question(anime: anime, question: question, answer: answer, optionOne: optionOne, optionTwo: optionTwo)
            
            // appending the recently converted JSON object to an array of Question objects to pull questions from
            questionArr.append(qa)
            questionList = questionArr
        } // end of the for in loop
    } catch {
        print(error)
    }
}

// picking 15 questions per team
func pickNumberOfQuestions(numberOfQuestions: Int) {
    questionList.removeAll()
    for _ in 1...numberOfQuestions {
        let randomNum = (Int(arc4random_uniform(UInt32(questionArr.count))))
        questionList.append(questionArr[randomNum])
        questionArr.remove(at: randomNum)
    }
}
