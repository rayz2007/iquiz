//
//  AnswerViewController.swift
//  iQuiz
//
//  Created by Ray Zhang on 11/2/18.
//  Copyright © 2018 Ray Zhang. All rights reserved.
//

import UIKit

class AnswerViewController: UIViewController {
    
    var currentQuestion: Int = -1
    var questions: [String] = []
    var choices: [[String]] = [[]]
    var answered: Int = -1
    var correctAnswer: [Int] = []
    var questionAnswered = 0
    var questionRight = 0

    @IBOutlet weak var lblQuestion: UILabel!
    @IBOutlet weak var lblUserAnswer: UILabel!
    @IBOutlet weak var lblCorrectAnswer: UILabel!
    @IBOutlet weak var lblResult: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questionAnswered += 1
        lblUserAnswer.text = choices[currentQuestion][answered]
        lblQuestion.text = questions[currentQuestion]
        lblCorrectAnswer.text = choices[currentQuestion][correctAnswer[currentQuestion]]
        
        if(answered == correctAnswer[currentQuestion]){
            questionRight += 1
            lblResult.text = "Correct! Current Score: \(questionRight) / \(questionAnswered)"
        }else{
            lblResult.text = "Wrong, Current Score: \(questionRight) / \(questionAnswered)"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func nextView(_ sender: Any) {
        if(currentQuestion == questions.count - 1){
            performSegue(withIdentifier: "toFinish", sender: self)
        }else{
            currentQuestion += 1
            performSegue(withIdentifier: "toNextQuestion", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "toFinish"){
            let dest = segue.destination as! FinishedViewController
            dest.totalRight = questionRight
            dest.totalQuestion = questions.count
        }else if (segue.identifier == "toNextQuestion"){
            let dest = segue.destination as! QuestionViewController
            dest.questions = questions
            dest.currentQuestion = currentQuestion
            dest.choices = choices
            dest.correctAnswer = correctAnswer
            dest.questionAnswered = questionAnswered
            dest.questionRight = questionRight
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
