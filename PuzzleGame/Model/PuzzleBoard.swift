//
//  PuzzleBoard.swift
//  PuzzleGame
//
//  Created by Consultant on 11/16/19.
//  Copyright © 2019 Consultant. All rights reserved.
//

import Foundation
import UIKit

class PuzzleBoard {
    //represent state of every tile.
    var state : [[Int]] = [ [ 1, 2, 3],
                            [ 4, 5, 6],
                            [ 7, 8, 0] ]
    var state1 : [[Int]] = [ [ 1, 2, 3],
    [ 4, 5, 6],
    [ 7, 8, 0] ]
    
    
    let rows = 3
    let cols = 3
    
    //swap tiles with the black space
    func switchTiles(fromRow r1: Int, Column c1: Int, toRow r2: Int, Column c2: Int){
        state[r2][c2] = state[r1][c1]
        state[r1][c1] = 0
    }
    
    //Get tile for a agiven positions
    func getTile(atRow r: Int, atColumn c: Int) -> Int{
        return state[r][c]
    }
    //Get the position for a Particular tile
    func getPositionRowandColumn(forTile tile: Int) -> (row: Int, column: Int)?{
        for i in 0..<rows{
            for j in 0..<cols{
                if (state[i][j] == tile){
                    return (row: i, column: j)
                }
            }
        }
        return (row: 0, column: 0)
    }
    //checks if the tile can move to top
    func canTileSlidetoTop(atRow r: Int, atColumn c:Int) -> Bool{
        if r < 1{
            return false
        }
        else{
            return  (state[r - 1][c] == 0)
        }
    }
    
    //checks if the tile csn move to down
    func canTileSlidetoDown(atRow r: Int, atColumn c:Int) -> Bool{
        if r == (rows - 1) {
            return false
        }else{
           return ( state[r + 1][c] == 0 )
        }
        
    }
    //checks if the
    func canTileSlidetoRight(atRow r: Int, atColumn c:Int) -> Bool{
        if c == (cols - 1){
            return false
        }
        else{
            return ( state[r][c + 1] == 0 )
        }
    }
    
    func canTileSlidetoLeft(atRow r: Int, atColumn c:Int) -> Bool{
        if c < 1{
            return false
        }else{
            return ( state[r][c - 1] == 0)
        }
    }
    //checks if the tile can slides to empty space
    func canTileSlide(arRow r: Int, atColumn c: Int) -> Bool{
        return ( canTileSlidetoTop(atRow: r, atColumn: c) || canTileSlidetoDown(atRow: r, atColumn: c) || canTileSlidetoLeft(atRow: r, atColumn: c) || canTileSlidetoRight(atRow: r, atColumn: c))
    }
    
    //If the tile can be slidable in any direct then change the position of tile by changing row and column position.
    func slidetheTile(arRow r : Int, atColumn c: Int){
        if ( canTileSlide(arRow: r, atColumn: c)) {
            if (canTileSlidetoTop(atRow: r, atColumn: c)){
                switchTiles(fromRow: r, Column: c, toRow: r - 1, Column: c)
            }
            if (canTileSlidetoLeft(atRow: r, atColumn: c)){
                switchTiles(fromRow: r, Column: c, toRow: r, Column: c - 1)
            }
            if (canTileSlidetoDown(atRow: r, atColumn: c)){
                switchTiles(fromRow: r, Column: c, toRow: r + 1, Column: c)
            }
            if (canTileSlidetoRight(atRow: r, atColumn: c)){
                switchTiles(fromRow: r, Column: c, toRow: r, Column: c + 1)
            }
        }
    }
    
    func resetBoard() {
        
        var set = 1
        for i in 0..<rows{
            for j in 0..<cols{
                state[i][j] = set%9
                set = set + 1
            }
        }
        
    }
    //checking if the game is in Solve State.
    func gameSolved() -> Bool{
        var num = 1
        for r in 0..<rows{
            for c in 0..<cols {
                if (state[r][c] != num%9){
                    return false
                }
                num = num + 1
            }
            
        }
        return true
    } //end of Checking gamesolve
    
    
//    func shuffle(){
//        
////        let x = getPositionRowandColumn(forTile: sender.tag)?.row
////        let y = getPositionRowandColumn(forTile: sender.tag)?.column
//        for _ in 1...100{
//            var movingTiles : [(atRow: Int, atColumn: Int)] = []
//            var numofMovinfTiles : Int = 0
//            for x in 0..<rows{
//                for y in 0..<cols{
//                    if canTileSlide(arRow: x, atColumn: y){
//                        movingTiles.append((x,y))
//                        numofMovinfTiles = numofMovinfTiles + 1
//                    }
//                }
//            }
//            let randomTile = Int(arc4random_uniform(UInt32(numofMovinfTiles)))
//            var moveRow : Int, moveCol :Int
//            moveRow = movingTiles[randomTile].atRow
//            moveCol = movingTiles[randomTile].atColumn
//            slidetheTile(arRow: moveRow, atColumn: moveCol)
//            
//        }
//    }
    
    
    
    
}
