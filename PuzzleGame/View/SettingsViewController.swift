//
//  SettingsViewController.swift
//  PuzzleGame
//
//  Created by Consultant on 11/29/19.
//  Copyright © 2019 Consultant. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet var tileButtons: [ButtonExtension]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        for i in 0...2{
            tileButtons[i].backgroundColor = UIColor.brown
        }
    }

    //Dismiss the viewController
    @IBAction func doneAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    //Chooses the number of tiles player selected for play
    @IBAction func tileChooseAction(_ sender: UIButton) {
        sender.backgroundColor = UIColor.black

        if sender.tag == 1{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PuzzleViewController") as? PuzzleViewController
            self.navigationController?.pushViewController(vc!, animated: true)
        }
        else if sender.tag == 2{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "FifteenPuzzleViewController") as? FifteenPuzzleViewController
            self.navigationController?.pushViewController(vc!, animated: true)
        }
        else if sender.tag == 3{
        }
        
    }
    
}
