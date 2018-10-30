//
//  ViewController.swift
//  iQuiz
//
//  Created by Ray Zhang on 10/28/18.
//  Copyright © 2018 Ray Zhang. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!

    let elements: [String] = ["marvel", "math", "science"]
    let descriptions: [String] = ["Quiz questions about marvel heros", "Math questions", "Science questions" ]
    
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
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

