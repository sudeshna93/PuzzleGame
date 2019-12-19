//
//  PuzzleBoard15.swift
//  PuzzleGame
//
//  Created by Consultant on 12/1/19.
//  Copyright © 2019 Consultant. All rights reserved.
//

import Foundation
import UIKit

class PuzzleBoard15{
    
    var state15 : [[Int]] = [[1,2,3,4],
                           [5,6,7,8],
                           [9,10,11,12],
                           [13,14,15,0]]
    
    
    let rows = 4
    let cols = 4
    
    //swap tiles with the blank space.
    func switchTiles(fromRow r1: Int, Column c1: Int, toRow r2: Int, Column c2: Int){
        state15[r2][c2] = state15[r1][c1]
        state15[r1][c1] = 0
    }
    
    //get tile for a agiven positions
    func getTile(atRow r: Int, atColumn c: Int) -> Int{
        return state15[r][c]
    }
    //Get the position for a Particular tile
    func getPositionRowandColumn(forTile tile: Int) -> (row: Int, column: Int)?{
        for i in 0..<rows{
            for j in 0..<cols{
                if (state15[i][j] == tile){
                    return (row: i, column: j)
                }
            }
        }
        return (row: 0, column: 0)
    }
    
    func canTileSlidetoTop(atRow r: Int, atColumn c:Int) -> Bool{
        if r < 1{
            return false
        }
        else{
            return  (state15[r - 1][c] == 0)
        }
    }
    
    func canTileSlidetoDown(atRow r: Int, atColumn c:Int) -> Bool{
           if r == (rows - 1) {
               return false
           }else{
              return ( state15[r + 1][c] == 0 )
           }
           
       }
       
       func canTileSlidetoRight(atRow r: Int, atColumn c:Int) -> Bool{
           if c == (cols - 1){
               return false
           }
           else{
               return ( state15[r][c + 1] == 0 )
           }
       }
    
    func canTileSlidetoLeft(atRow r: Int, atColumn c:Int) -> Bool{
        if c < 1{
            return false
        }else{
            return ( state15[r][c - 1] == 0)
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
                state15[i][j] = set%16
                set = set + 1
            }
        }
    }
    
    func gameSolved() -> Bool{
        var num = 1
        for r in 0..<rows{
            for c in 0..<cols {
                if (state15[r][c] != num%16){
                    return false
                }
                num = num + 1
            }
            
        }
        return true
    } //end of Checking gamesolve
    
}
 
