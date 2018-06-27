//
//  PersistenceHelper.swift
//  ToDoTaskList
//
//  Created by Kuharich, Mark X. -ND on 6/26/18.
//  Copyright © 2018 Kuharich. All rights reserved.
//

import UIKit
import CoreData

class PersistenceHelper: NSObject {
    
    var appDel: AppDelegate = (UIApplication.shared.delegate as! AppDelegate)
    var context: NSManagedObjectContext?;
    
    override init(){
    }
    
    func save(entity: String, parameters: Dictionary<String,String> )->Bool{
        
        let newEntity = NSEntityDescription.insertNewObject(forEntityName: entity, into: context!)
        for (key, value) in parameters{
            newEntity.setValue(value, forKey: key)
        }
        
        do {
            try context?.save()
            return true
        } catch _ {
            return false
        }
    }
    
    func list(entity: String ) ->NSArray{
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        request.returnsObjectsAsFaults = false;
        let results: NSArray = try! context!.fetch(request) as NSArray
        return results
    }
    
    func remove(entity:String, key:String, value:String)->Bool{
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        request.returnsObjectsAsFaults = false
        request.predicate = NSPredicate(format: "\(key) = %@", value)
        let results: NSArray = try! context!.fetch(request) as NSArray
        
        if(results.count>0){
            
            let res = results[0] as! NSManagedObject
            context?.delete(res)
            do {
                try context?.save()
            } catch _ {
            }
            return true
        }
        
        return false
    }
    
}
