//
//  TutorialsViewController.swift
//  PuzzleGame
//
//  Created by Consultant on 11/28/19.
//  Copyright © 2019 Consultant. All rights reserved.
//

import UIKit

class TutorialsViewController: UIViewController {

    @IBOutlet weak var backView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.backView.layer.cornerRadius = 5
        
        

    }
    
    @IBAction func doneAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
}
