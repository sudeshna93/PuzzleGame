//
//  FifteenPuzzleViewController.swift
//  PuzzleGame
//
//  Created by Consultant on 11/22/19.
//  Copyright © 2019 Consultant. All rights reserved.
//

import UIKit

class FifteenPuzzleViewController: UIViewController {

    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet var tiles: [UIButton]!
    @IBOutlet weak var boardView: UIView!
    let puzzleBoard = PuzzleBoard15()
    var buttonClick = false
    var nsTimer = Timer()
    var counter = Double()
    var delegate: DataReceiver?
    var info: ScoreDataTuple?
    var manager = CoreDataManager()
    var score: [Score] = []
    
    //MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
       
    //MARK: IBActions
    @IBAction func shuffleBtnAction(_ sender: UIButton) {
        self.timerLabel.text = "0.0.0"
        counter = 0.0
        shuffleButton(sender: sender)
        
      //  self.boardView.setNeedsLayout()
    }
    
    @IBAction func buttonslideAction(_ sender: UIButton) {
        self.buttonClick = true
        if !nsTimer.isValid{
            nsTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        }
        slidetheTile(sender: sender)
    }
    
    @IBAction func insertImageAction(_ sender: UIButton) {
        if !buttonClick{
            guard let data = UIImage(named: String("imageExample")) else {
                return
            }
            let croppedImage = data.divideImage15()
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
    
    @IBAction func scoreBtnAction(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ScoreViewController") as? ScoreViewController
        self.navigationController?.pushViewController(vc!, animated: true)
        
        
    }
    //MARK: Custom functions
    
    @objc func updateTime(){
           counter = counter + 0.1
           let hours = Int(counter) / 3600
           let minutes = Int(counter) / 60 % 60
           let seconds = Int(counter) % 60
          // timerLabel.text = String(format: "%.2f", counter) + "s"
           timerLabel.text = String(format:"%2i:%2i:%2i",hours, minutes, seconds)

       }
    
    //shuffling the tiles
    func shuffleButton(sender: UIButton){
            for _ in 0..<1000 {
                let randomInt = Int.random(in: 0..<15)
                switch (tiles![randomInt].tag) {
                case 1...15:
                    let position = puzzleBoard.getPositionRowandColumn(forTile: tiles![randomInt].tag)
                    //print("QQQ ", tiles)
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
    
    //Slide the tiles on Button click
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
               center.x = center.x - bound.size.width
           }
           else if puzzleBoard.canTileSlidetoTop(atRow: position!.row, atColumn: position!.column){
               center.y = center.y - bound.size.width
           }
           else if puzzleBoard.canTileSlidetoDown(atRow: position!.row, atColumn: position!.column){
               center.y = center.y + bound.size.width 
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
        let d = manager.create(time: (counter * 100).rounded() / 100, type: "15Puzzle")
        score.append(d)
        print(score)
        
        
        
    }
    //Stop timer by invalidate it and display the time taken by player.
    func stopTimer() {
        guard nsTimer != nil else { return }
        nsTimer.invalidate()
        // nsTimer = nil
    }
    
    func filltheImages(with images: [UIImage]){
        guard images.count == 16 else{
            return
        }
        for v in view.subviews[2].subviews{
            if let imView = v as? UIButton {
                for i in 0...14{
                    if imView.tag == (i + 1){
                        imView.setImage(images[i], for: .normal)
                    }
                }
                imView.setTitle(nil, for: .normal)
            }
        }
        view.setNeedsLayout()
    }
    
    func fillthenumber(){
        for v in view.subviews[2].subviews{
            if let imView = v as? UIButton {
                for i in 1...15{
                    if imView.tag == i{
                        imView.setTitle(" " + String(i), for: .normal)
                    }
                }
                imView.setImage(nil, for: .normal)
            }
        }
        view.setNeedsLayout()
    }
    


}
