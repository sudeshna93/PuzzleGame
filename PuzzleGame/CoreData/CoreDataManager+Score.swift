//
//  CoreDataManager+Score.swift
//  PuzzleGame
//
//  Created by Consultant on 11/30/19.
//  Copyright © 2019 Consultant. All rights reserved.
//

import Foundation
import CoreData

private let ENTITY_NAME = "Score"

extension CoreDataManager {
    func create(time: Double, type: String) -> Score{
        let desc = NSEntityDescription.entity(forEntityName: ENTITY_NAME, in: mainMOC)!
        let score = Score(entity: desc, insertInto: mainMOC)
        
        score.time = time
        score.type = type
        save()
        return score
    }
    
    func load(_ type: String? = nil) -> [Score]{
        //fetch request
        let request : NSFetchRequest<Score> = Score.fetchRequest()
        
        //using predicate to fetch only 8puzzle scores
        if let type = type {
            let predicate = NSPredicate(format: "type = %@", type)
            request.predicate = predicate
        }
        
        let sort = NSSortDescriptor(key: "time", ascending:true)
        request.sortDescriptors = [sort]
        //use of context
        do{
            let result = try mainMOC.fetch(request)
            return result
        }
        catch{
            print("Failed: \(error)")
        }
        
        return []
    }
    
    func loadforFifteen() -> [Score]{
        //fetch request
        let request : NSFetchRequest<Score> = Score.fetchRequest()
        
        //using predicate to fetch only 8puzzle scores
        let predicate = NSPredicate(format: "type = %@", argumentArray: ["15Puzzle"])
        request.predicate = predicate

        //use of context
        do{
            let result = try mainMOC.fetch(request)
            return result
        }
        catch{
            print("Failed: \(error)")
        }
        //return
        return []
    }
    
    
    
    func save (){
        saveContext()
    }
}





