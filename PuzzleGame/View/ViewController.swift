//
//  ViewController.swift
//  PuzzleGame
//
//  Created by Consultant on 11/16/19.
//  Copyright © 2019 Consultant. All rights reserved.
//

import UIKit
import AVFoundation
import CoreGraphics
import CoreImage


class ViewController: UIViewController {
    
    var player : AVAudioPlayer?
   
    @IBOutlet weak var playLabel: UILabel!
    @IBOutlet weak var demoImageview: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        playSound()
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        UIView.animate(withDuration: 0.5, delay: 0.0, options: [.autoreverse, .repeat], animations: {
            self.playLabel.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
        }, completion: nil)
    }

    
    func playSound(){
        guard let url = Bundle.main.url(forResource: "Electrical_Sweep-Sweeper-1760111493", withExtension: "mp3") else{
            print("url not found")
            return
        }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            
            //fileTypeHint is the type of the audio file
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            guard let player = player else {
                return
            }
            player.play()
        }
        
        catch let error {
            print(error.localizedDescription)
        }
        
    }
    
    @IBAction func settingBtnAction(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SettingsViewController") as? SettingsViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    

}

