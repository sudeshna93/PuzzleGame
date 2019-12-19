//
//  ScoreController.swift
//  PuzzleGame
//
//  Created by Consultant on 11/30/19.
//  Copyright © 2019 Consultant. All rights reserved.
//

import Foundation


protocol ScoreViewProtocol {
    func update()
}
protocol ScoreControllerProtocol {
    var score: [Score] { get }
    func createScore(time: Double, type: String)
    func loadScore()
}

class ScoreController: ScoreControllerProtocol {
    var score: [Score] = []
    let manager = CoreDataManager()
    let view : ScoreViewProtocol
    
    init(_ view: ScoreViewProtocol) {
        self.view = view
    }
    
    func createScore(time: Double, type: String) {
        let s = manager.create(time: time, type: type)
        score.append(s)
        view.update()
    }
    
    func loadScore() {
        score = manager.load()
        view.update()
    }
    
    func test() {
        // load 8s
        print(manager.load("8Puzzle").count)
        
        // load 15s
        print(manager.load("15Puzzle").count)
        
        // load all
        print(manager.load().count)
    }
    
    
    
}
