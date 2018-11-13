//
//  ViewController.swift
//  iQuiz
//
//  Created by Ray Zhang on 11/12/18.
//  Copyright © 2018 Ray Zhang. All rights reserved.
//

import UIKit

struct Quiz: Codable{
    let title: String
    let desc: String
    let questions: [Question]
}

struct Question: Codable{
    let text: String
    let answer: String
    let answers: [String]
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    let defaults = UserDefaults.standard
    var toStore: NSArray = []
    var jsonData: [Quiz]? = nil
    var elements: [String] = ["science", "marvel", "math"]
    var titles: [String] = []
    var descriptions: [String] = []
    var jsonUrlString: String = UserDefaults.standard.string(forKey: "url") ?? "http://tednewardsandbox.site44.com/questions.json"
    
    var urlTextField: UITextField = UITextField()
    
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
        
        cell.cellImage.image = UIImage(named: "default")
        //check if title has icon if not use default.
        for  i  in 0...elements.count-1{
            if((cell.cellLabel.text?.lowercased().range(of: elements[i])) != nil){
                cell.cellImage.image = UIImage(named: elements[i])
            }
        }
        
        return cell
    }
    
    @IBAction func settingsPressed(_ sender: Any) {
        let alert = UIAlertController(title: "Settings", message: "Enter Data URL", preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addTextField { (textField: UITextField) in
            self.urlTextField = textField
            self.urlTextField.placeholder = "Enter url here"
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil))
        alert.addAction(UIAlertAction(title: "Check now", style: UIAlertActionStyle.default, handler:{
            (act: UIAlertAction) in
            if((self.urlTextField.text) != nil){
                self.fetchJson(self.urlTextField.text!)
            }
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        
        //grabbing url fetched successfully last time
        if((defaults.object(forKey: "url")) != nil){
            self.jsonUrlString = defaults.object(forKey: "url") as! String
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if(Reachability.isConnectedToNetwork()){
            if(jsonData == nil){
                fetchJson(jsonUrlString)
            }
        }else{
            let alert = UIAlertController(title: "No Internet", message: "Using local data", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            print("no internet, grabbing from user default");
            let anyData = defaults.object(forKey: "quizData")
            if(anyData == nil){
                let alert = UIAlertController(title: "No Local Data", message: "Please connect to internet", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }else{
                let data = anyData as! Data
                do{
                    let questions = try JSONDecoder().decode([Quiz].self, from: data)
                    self.jsonData = questions
                    for q in questions{
                        self.titles.append(q.title)
                        self.descriptions.append(q.desc)
                    }
                }catch{
                    self.failDownloadAlert()
                }
                self.tableView.reloadData()
            }
        }
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
            guard let data = data else {
                self.failDownloadAlert()
                return
            }
            self.defaults.set(fetchUrl, forKey: "url")
            self.defaults.set(data, forKey:"quizData")
            do{
                let questions = try JSONDecoder().decode([Quiz].self, from: data)
                self.jsonData = questions
                for q in questions{
                    self.titles.append(q.title)
                    self.descriptions.append(q.desc)
                }
            }catch{
                self.failDownloadAlert()
            }
            
            DispatchQueue.main.async{
                self.tableView.reloadData()
            }
            }.resume()
    }
    
    func failDownloadAlert(){
        let alert = UIAlertController(title: "Download Failed", message: "Please check internet/ data URL/ data format", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
