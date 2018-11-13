//
//  AnswerViewController.swift
//  iQuiz
//
//  Created by Ray Zhang on 11/12/18.
//  Copyright © 2018 Ray Zhang. All rights reserved.
//

import UIKit

class AnswerViewController: UIViewController {
    
    
    var jsonData: [Quiz]? = nil
    var currentQuestion: Int = -1
    var lastSelectedAnswer: Int = -1
    var categoryIndex: Int = -1
    var questionAnswered = 0
    var questionRight = 0

    @IBOutlet weak var lblQuestion: UILabel!
    @IBOutlet weak var lblUserAnswer: UILabel!
    @IBOutlet weak var lblCorrectAnswer: UILabel!
    @IBOutlet weak var lblResult: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questionAnswered += 1
        lblUserAnswer.text = jsonData?[categoryIndex].questions[currentQuestion].answers[lastSelectedAnswer]
        lblQuestion.text = jsonData?[categoryIndex].questions[currentQuestion].text
        
        let correctAnswerIndex = Int((jsonData?[categoryIndex].questions[currentQuestion].answer)!)! - 1; //adjusted to zero based
        
        lblCorrectAnswer.text = jsonData?[categoryIndex].questions[currentQuestion].answers[correctAnswerIndex]
        
        if(correctAnswerIndex == lastSelectedAnswer){
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
        if(currentQuestion == (jsonData?[categoryIndex].questions.count)! - 1){
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
            dest.totalQuestion = (jsonData?[categoryIndex].questions.count)!
        }else if (segue.identifier == "toNextQuestion"){
            let dest = segue.destination as! QuestionViewController
            dest.jsonData = jsonData
            dest.currentQuestion = currentQuestion
            dest.questionAnswered = questionAnswered
            dest.questionRight = questionRight
            dest.categoryIndex = categoryIndex
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
