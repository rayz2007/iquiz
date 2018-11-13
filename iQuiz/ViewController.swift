//
//  ViewController.swift
//  iQuiz
//
//  Created by Ray Zhang on 11/12/18.
//  Copyright © 2018 Ray Zhang. All rights reserved.
//

import UIKit

struct Quiz: Decodable{
    let title: String
    let desc: String
    let questions: [Question]
}

struct Question: Decodable{
    let text: String
    let answer: String
    let answers: [String]
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var jsonData: [Quiz]? = nil
    var elements: [String] = ["science", "marvel", "math"]
    var titles: [String] = []
    var descriptions: [String] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jsonData?.count ?? 0;
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as! CustomTableViewCell
        cell.descriptionLabel.text = jsonData?[indexPath.row].desc
        cell.cellLabel.text = jsonData?[indexPath.row].title
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
        
        fetchJson("http://tednewardsandbox.site44.com/questions.json")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //check which cell is pressed, and send over data
        if let indexPath = tableView.indexPathForSelectedRow{
            let categoryIndex = indexPath.row
            let questionView = segue.destination as! QuestionViewController
            questionView.jsonData = jsonData
            questionView.categoryIndex = categoryIndex
        }
    }
    
    func fetchJson(_ fetchUrl: String){
        guard let url = URL(string: fetchUrl) else {return}
        URLSession.shared.dataTask(with: url) { (data, res, err) in
            guard let data = data else {return}
            do{
                let questions = try JSONDecoder().decode([Quiz].self, from: data)
                self.jsonData = questions
                for q in questions{
                    self.titles.append(q.title)
                    self.descriptions.append(q.desc)
                }
            }catch let jsonErr{
                print(jsonErr)
            }
            
            DispatchQueue.main.async{
                self.tableView.reloadData()
            }
            
            }.resume()
    }
}



