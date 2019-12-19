//
//  ScoreViewController.swift
//  PuzzleGame
//
//  Created by Consultant on 11/30/19.
//  Copyright © 2019 Consultant. All rights reserved.
//

import UIKit

class ScoreViewController: UIViewController {
    
    @IBOutlet weak var tableview: UITableView!
    let reuseID = "ScoreTableViewCell"
    var controller: ScoreControllerProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black
        tableview.delegate = self
        tableview.dataSource = self
        controller = ScoreController(self)
        //Fetching time from Coredata
        controller.loadScore()
        
    }
    
    
    @IBAction func doneAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
}

extension ScoreViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return controller.score.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableview.dequeueReusableCell(withIdentifier: reuseID) as! ScoreTableViewCell
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseID, for: indexPath) as! ScoreTableViewCell
        
        
        let time = controller.score[indexPath.row].time
        let type = controller.score[indexPath.row].type
        let hours = Int(time) / 3600
        let minutes = Int(time / 60) % 60
        let seconds = Int(time) % 60
        cell.scorelabel?.text = "Time taken: \(hours):\(minutes):\(seconds)" + " of: \(type ?? " "))"
        
        return cell
    }
    
}


extension ScoreViewController: DataReceiver {
    func update(with info: ScoreDataTuple) {
        //
    }
    
    func receive(_ info: ScoreDataTuple) {
        controller.createScore(time: info.time, type: info.type)
    }
}

extension ScoreViewController: ScoreViewProtocol{
    
    func update() {
        
        tableview.reloadData()
    }
    
    
}
