//
//  QuestionViewController.swift
//  iQuiz
//
//  Created by Ray Zhang on 11/2/18.
//  Copyright © 2018 Ray Zhang. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {
    
    //these would be passed in from main view controller
    @IBOutlet weak var lblQuestion: UILabel!
    @IBOutlet weak var btnAnswer3: UIButton!
    @IBOutlet weak var btnAnswer2: UIButton!
    @IBOutlet weak var btnAnswer1: UIButton!
    @IBOutlet weak var btnAnswer4: UIButton!
    
    //following variables are passed around viewcontrollers to keep track of which question is displayed
    var currentQuestion = 0;
    var questions: [String] = ["Question 1", "Question 2", "Question 3"]
    var choices: [[String]] = [["answer 1,1", "answer 1,2" , "answer 1,3"],["answer 2,1", "answer 2,2" , "answer 2,3"],["answer 3,1", "answer 3,2" , "answer 3,3"], ["answer 4,1", "answer 4,2" , "answer 4,3"]]
    var correctAnswer: [Int] = [1,1,1];
    var lastSelectedAnswer = -1;
    var questionAnswered = 0;
    var questionRight = 0;
    
    @IBAction func answerOneSelected(_ sender: UIButton) {
        lastSelectedAnswer = 0;
        sender.backgroundColor = UIColor.lightGray
        btnAnswer2.backgroundColor = UIColor.white
        btnAnswer3.backgroundColor = UIColor.white
        btnAnswer4.backgroundColor = UIColor.white
    }
    
    @IBAction func answerTwoSelected(_ sender: UIButton) {
        lastSelectedAnswer = 1;
        sender.backgroundColor = UIColor.lightGray
        btnAnswer1.backgroundColor = UIColor.white
        btnAnswer3.backgroundColor = UIColor.white
        btnAnswer4.backgroundColor = UIColor.white
    }
    
    @IBAction func answerThreeSelected(_ sender: UIButton) {
        lastSelectedAnswer = 2;
        sender.backgroundColor = UIColor.lightGray
        btnAnswer1.backgroundColor = UIColor.white
        btnAnswer2.backgroundColor = UIColor.white
        btnAnswer4.backgroundColor = UIColor.white
    }
    
    @IBAction func answerFourSelected(_ sender: UIButton) {
        lastSelectedAnswer = 3;
        sender.backgroundColor = UIColor.lightGray
        btnAnswer1.backgroundColor = UIColor.white
        btnAnswer2.backgroundColor = UIColor.white
        btnAnswer3.backgroundColor = UIColor.white
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        lblQuestion.text = questions[currentQuestion];
        btnAnswer1.setTitle(choices[currentQuestion][0], for: .normal)
        btnAnswer2.setTitle(choices[currentQuestion][1], for: .normal)
        btnAnswer3.setTitle(choices[currentQuestion][2], for: .normal)
        btnAnswer4.setTitle(choices[currentQuestion][3], for: .normal)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func submitPressed(_ sender: Any) {
        if(lastSelectedAnswer == -1){
            let alert = UIAlertController(title: "No Selection", message: "Please select an answer to continue.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }else{
            performSegue(withIdentifier: "toReveal", sender: self)
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "toReveal"){
            let dest = segue.destination as! AnswerViewController
            dest.answered = lastSelectedAnswer
            dest.currentQuestion = currentQuestion
            dest.questions = questions
            dest.correctAnswer = correctAnswer
            dest.questionAnswered = questionAnswered
            dest.questionRight = questionRight
            dest.choices = choices
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
