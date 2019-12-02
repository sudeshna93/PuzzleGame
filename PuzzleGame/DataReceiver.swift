//
//  DataReceiver.swift
//  PuzzleGame
//
//  Created by Consultant on 11/30/19.
//  Copyright © 2019 Consultant. All rights reserved.
//

import Foundation

typealias ScoreDataTuple = (time: Double, type: String)

protocol DataReceiver {
    func receive(_ info: ScoreDataTuple)
    func update(with info: ScoreDataTuple)
}




