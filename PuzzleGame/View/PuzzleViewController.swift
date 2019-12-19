//
//  PuzzleViewController.swift
//  PuzzleGame
//
//  Created by Consultant on 11/16/19.
//  Copyright © 2019 Consultant. All rights reserved.
//

import UIKit
import CoreGraphics
import CoreImage

class PuzzleViewController: UIViewController {
    
    @IBOutlet var boardConstraints: [NSLayoutConstraint]!
    // represents the UI of the state
    @IBOutlet var tiles: [UIButton]!
    // represents state of the puzzle
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var boardView: UIView!
    //instance of data model.
    let puzzleBoard = PuzzleBoard()
    var buttonClick = false
    var nsTimer = Timer()
    var counter = Double()
    var delegate: DataReceiver?
    var info: ScoreDataTuple?
    //represent coredata Class
    var manager = CoreDataManager()
    //Instance of NSManagedObject
    var score: [Score] = []
    
    //MARK:View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        //view.backgroundColor = UIColor.black
        //self.boardConstraints.isActive = nil
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        //whenever player left this viewcontroller invalidating the timer.
        self.nsTimer.invalidate()
    }
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    //MARK: Button Actions
    @IBAction func shufflebuttonAction(_ sender: UIButton) {
        self.timerLabel.text = " 0: 0: 0"
        counter = 0.0
        shuffleButton(sender: sender)
        // self.boardView.setNeedsLayout()
    }
    
    //Fill the buttons with images and with Numbers.
    @IBAction func imageButtonAction(_ sender: UIButton) {
        if !buttonClick{
            guard let data = UIImage(named: String("imageExample")) else {
                return
            }
            let croppedImage = data.divideImage()
            filltheImages(with: croppedImage)
            sender.setTitle("Number", for: .normal)
            buttonClick = true
        }
        else{
            sender.setTitle("Image", for: .normal)
            fillthenumber()
            buttonClick = false
        }
    }

    //slide the buttons inside the frames when click on a particular button.
    @IBAction func buttonSlideAction(_ sender: UIButton) {
        self.buttonClick = true
        if !nsTimer.isValid{
            nsTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        }
        slidetheTile(sender: sender)
    }
    
    //Redirecting to ScoreViewController to check previous score History
    @IBAction func scoreButtonAction(_ sender: Any) {
        let vc = ScoreViewController(nibName: "ScoreViewController", bundle: nil)
        navigationController?.show(vc, sender: nil)
        
        
    }
    //Updating time while player playing the game.And showing on timer label.
    @objc func updateTime(){
        counter = counter + 0.1
        let hours = Int(counter) / 3600
        let minutes = Int(counter) / 60 % 60
        let seconds = Int(counter) % 60
        //timerLabel.text = String(format: "%.2f", counter) + "s"
        timerLabel.text = String(format:"%2i:%2i:%2i",hours, minutes, seconds)
    }
    
    //shuffling the tiles by randomize the buttons inside the frame.
    func shuffleButton(sender: UIButton){
            for _ in 0..<1000 {
                let randomInt = Int.random(in: 0..<8)
                switch (tiles![randomInt].tag) {
                case 1...8:
                    let position = puzzleBoard.getPositionRowandColumn(forTile: tiles![randomInt].tag)
                    let bound = tiles[randomInt].bounds
                    if puzzleBoard.canTileSlidetoRight(atRow: position!.row, atColumn: position!.column){
                        puzzleBoard.slidetheTile(arRow: position!.row, atColumn: position!.column)
                        let t = self.tiles[randomInt]
                        self.tiles[randomInt].frame.origin = CGPoint(x: t.frame.origin.x + bound.size.width ,
                                                 y: t.frame.origin.y + 0)
                       
                        
                    }
                    if puzzleBoard.canTileSlidetoLeft(atRow: position!.row, atColumn: position!.column){
                        puzzleBoard.slidetheTile(arRow: position!.row, atColumn: position!.column)
                        let t = self.tiles[randomInt]
                        self.tiles[randomInt].frame.origin = CGPoint(x: t.frame.origin.x - bound.size.width,
                                                 y: t.frame.origin.y + 0)
                    }
                    
                    if puzzleBoard.canTileSlidetoTop(atRow: position!.row, atColumn: position!.column){
                        puzzleBoard.slidetheTile(arRow: position!.row, atColumn: position!.column)
                        let t = self.tiles[randomInt]
                        self.tiles[randomInt].frame.origin = CGPoint(x: t.frame.origin.x + 0,
                                                 y: t.frame.origin.y - bound.size.width )
                    }
                    
                    if puzzleBoard.canTileSlidetoDown(atRow: position!.row, atColumn: position!.column){
                        puzzleBoard.slidetheTile(arRow: position!.row, atColumn: position!.column)
                        let t = self.tiles[randomInt]
                        self.tiles[randomInt].frame.origin = CGPoint(x: t.frame.origin.x + 0,
                                                 y: t.frame.origin.y + bound.size.width )
                        
                    }
                default:
                    print("no tiles")
                }
            }
        
        }
           
 //Funstion for Slide the tiles on Button click
    func slidetheTile(sender: UIButton){
        let position = puzzleBoard.getPositionRowandColumn(forTile: sender.tag)
        var center = sender.center
        var bound = sender.bounds
        var slideFlag = true
        buttonClick = true
        
        
        if puzzleBoard.canTileSlidetoRight(atRow: position!.row, atColumn: position!.column){
            center.x = center.x + bound.size.width
        }
        else if puzzleBoard.canTileSlidetoLeft(atRow: position!.row, atColumn: position!.column){
            center.x = center.x - bound.size.width - 0.5
        }
        else if puzzleBoard.canTileSlidetoTop(atRow: position!.row, atColumn: position!.column){
            center.y = center.y - bound.size.width - 0.3
        }
        else if puzzleBoard.canTileSlidetoDown(atRow: position!.row, atColumn: position!.column){
            center.y = center.y + bound.size.width + 0.5
        }
        else{
            slideFlag = false
        }
        if slideFlag == true{
            puzzleBoard.slidetheTile(arRow: position!.row, atColumn: position!.column)
            UIView.animate(withDuration: 0.5, animations: {sender.center = center})
            
            if puzzleBoard.gameSolved(){
                let alert = UIAlertController(title: "PuzzleGame", message: "Congratulation!! Play Again", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: {(action:UIAlertAction!) in
                    print("Action")
                }))
                //stop the timer to record your time
                stopTimer()
                //saving the time in CoreData
                savetheScore()
                
                //show alert on Completion of game
                self.present(alert, animated: true, completion: nil)
                
                
            }
        }
        
    }
    //Saving the time in CoreData
    func savetheScore(){
//        let info = (time: counter, type: "Image" )
//        if self.info == nil{
//            delegate?.receive(info)
//        }
//        else{
//            delegate?.update(with: info)
//        }
        let d = manager.create(time: (counter * 100).rounded() / 100, type: "8Puzzle")
        score.append(d)
        print(score)
    
        
        
    }
    //Stop timer by invalidating it.
    func stopTimer() {
        guard nsTimer != nil else { return }
        nsTimer.invalidate()
       // nsTimer = nil
    }
    
    //fill the images in button tiles.
    func filltheImages(with images: [UIImage]){
        guard images.count == 9 else{
            return
        }
        for v in view.subviews[2].subviews{
            if let imView = v as? UIButton {
                
                for i in 0...7{
                    if imView.tag == (i + 1) {
                        imView.setImage(images[i], for: .normal)
                    }
                }
                imView.setTitle(nil, for: .normal)
            }
        }
        view.setNeedsLayout()
    }
    
    //Fill the buton tiles with numbers.
    func fillthenumber(){
        for v in view.subviews[2].subviews{
             if let imView = v as? UIButton {
                if imView.tag == 1{
                    imView.setTitle("  1", for: .normal)
                }
                if imView.tag == 2{
                    imView.setTitle("  2", for: .normal)
                }
                if imView.tag == 3{
                     imView.setTitle("  3", for: .normal)
                }
                if imView.tag == 4{
                    imView.setTitle("  4", for: .normal)
                }
                if imView.tag == 5{
                     imView.setTitle("  5", for: .normal)
                }
                if imView.tag == 6{
                     imView.setTitle("  6", for: .normal)
                }
                if imView.tag == 7{
                     imView.setTitle("  7", for: .normal)
                }
                if imView.tag == 8{
                     imView.setTitle("  8", for: .normal)
                }
                imView.setImage(nil, for: .normal)
            }
        }
        view.setNeedsLayout()
    }
    
    
}
