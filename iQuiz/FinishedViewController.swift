//
//  FinishedViewController.swift
//  iQuiz
//
//  Created by Ray Zhang on 11/12/18.
//  Copyright © 2018 Ray Zhang. All rights reserved.
//

import UIKit

class FinishedViewController: UIViewController {
    
    var totalRight : Int = 0
    var totalQuestion: Int = 1

    @IBOutlet weak var lblScore: UILabel!
    @IBOutlet weak var endMsg: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(totalQuestion < 1){
            lblScore.text = "Invalid Score"
            endMsg.text = ""
        }else{
            var score: Double = (Double(totalRight) / Double(totalQuestion))
            score = round(score * 10)/10;
            var msg = ""
            if(score < 0.6){
                msg = "You failed"
            } else if(score > 0.6 && score < 1){
                msg = "Good Job"
            }else if(score == 1){
                msg = "Perfect!"
            }
            
            lblScore.text = "\(totalRight)/\(totalQuestion)"
            endMsg.text = msg
        }
        // Do any additional setup after loading the view.
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
