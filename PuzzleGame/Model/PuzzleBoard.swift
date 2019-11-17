//
//  PuzzleBoard.swift
//  PuzzleGame
//
//  Created by Consultant on 11/16/19.
//  Copyright © 2019 Consultant. All rights reserved.
//

import Foundation

class PuzzleBoard {
    var state : [[Int]] = [ [ 1, 2, 3],[ 4, 5, 6],[ 7, 8, 0] ]
    
    let rows = 3
    let cols = 3
    
    //swap tiles
    func switchTiles(fromRow r1: Int, Column c1: Int, toRow r2: Int, Column c2: Int){
        state[r2][c2] = state[r1][c1]
        state[r1][c1] = 0
    }
    
    //get tile for a agiven positions
    func getTile(atRow r: Int, atColumn c: Int) -> Int{
        return state[r][c]
    }
    
    func canTileSlidetoTop(atRow r: Int, atColumn c:Int) -> Bool{
        if r < 1{
            return false
        }
        else{
            return  (state[r - 1][c] == 0)
        }
    }
    
    
    func canTileSlidetoDown(atRow r: Int, atColumn c:Int) -> Bool{
        if r == (rows - 1) {
            return false
        }else{
           return ( state[r + 1][c] == 0 )
        }
        
    }
    
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
        
    }
    
    func gameSolved() -> Bool{
        var num = 1
        for r in 0..<rows{
            for c in 0..<cols {
                if (state[r][c] != num%16){
                    return false
                }
                
            }
            num = num + 1
        }
        return true
    }
    
    
    
    
    
}
