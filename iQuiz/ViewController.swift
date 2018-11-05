//
//  ViewController.swift
//  iQuiz
//
//  Created by Ray Zhang on 11/2/18.
//  Copyright © 2018 Ray Zhang. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!

    let elements: [String] = ["marvel", "math", "science"]
    let descriptions: [String] = ["Quiz questions about marvel heros", "Math questions", "Science questions" ]
    
    //these should be set up by reading the json in part 3
    let marvelQuestions: [String] = ["marvel question1", "marvel question2","marvel question3"]
    let marvelAnswers: [[String]] = [["marvel answer1 for Q1(right)", "marvel answer2 for Q1", "marvel answer3 for Q1", "marvel answer4 for Q1"],["marvel answer1 for Q2", "marvel answer2 for Q2(right)", "marvel answer3 for Q2", "marvel answer4 for Q2"],["marvel answer1 for Q3", "marvel answer2 for Q3", "marvel answer3 for Q3(right)", "marvel answer4 for Q3"]]
    let marvelCorrectAnswers: [Int] = [0,1,2]; //answer for question is the number of question for testing
    
    let mathQuestions: [String] = ["math question1", "math question2","math question3"]
    let mathAnswers: [[String]] = [["math answer1 for Q1(right)", "math answer2 for Q1", "math answer3 for Q1", "math answer4 for Q1"],["math answer1 for Q2", "math answer2 for Q2(right)", "math answer3 for Q2", "math answer4 for Q2"],["math answer1 for Q3", "math answer2 for Q3", "math answer3 for Q3(right)", "math answer4 for Q3"]]
    let mathCorrectAnswers: [Int] = [0,1,2];
    
    let sciQuestions: [String] = ["sci question1", "sci question2","sci question3"]
    let sciAnswers: [[String]] = [["sci answer1 for Q1(right)", "sci answer2 for Q1", "sci answer3 for Q1", "sci answer4 for Q1"],["sci answer1 for Q2", "sci answer2 for Q2(right)", "sci answer3 for Q2", "sci answer4 for Q2"],["sci answer1 for Q3", "sci answer2 for Q3", "sci answer3 for Q3(right)", "sci answer4 for Q3"]]
    let sciCorrectAnswers: [Int] = [0,1,2];

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elements.count;
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as! CustomTableViewCell
        cell.descriptionLabel.text = descriptions[indexPath.row]
        cell.cellLabel.text = elements[indexPath.row]
        cell.cellImage.image = UIImage(named: elements[indexPath.row])
        return cell
    }
    
    @IBAction func settingsPressed(_ sender: Any) {
        let alert = UIAlertController(title: "Settings", message: "Settings go here.", preferredStyle: UIAlertControllerStyle.alert)
    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))

        self.present(alert, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        //this will set up all the questions and category
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //check which cell is pressed, and send over data
        if let indexPath = tableView.indexPathForSelectedRow{
            let selectedRow = indexPath.row
            let questionView = segue.destination as! QuestionViewController
            switch selectedRow{
            case 0:
                questionView.questions = marvelQuestions
                questionView.choices = marvelAnswers
                questionView.correctAnswer = marvelCorrectAnswers
            case 1:
                questionView.questions = mathQuestions
                questionView.choices = mathAnswers
                questionView.correctAnswer = mathCorrectAnswers
            case 2:
                questionView.questions = sciQuestions
                questionView.choices = sciAnswers
                questionView.correctAnswer = sciCorrectAnswers
            default:
                print("error")
            }
        }
    }


}

