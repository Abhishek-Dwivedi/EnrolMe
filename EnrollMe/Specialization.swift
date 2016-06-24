//
//  Specialization.swift
//  EnrollMe
//
//  Created by Abhishek Dwivedi on 15/06/16.
//  Copyright © 2016 Abhishek Dwivedi. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class Specialization: NSManagedObject {

    //Fetch all Specializations
    static func getSpecializations() -> [Specialization]? {
        
        var specializations: [Specialization]?
        
        let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate
        
        let context = appDelegate?.managedObjectContext
        
        let request = NSFetchRequest(entityName: "Specialization")
        
        do {
            try specializations = context?.executeFetchRequest(request) as? [Specialization]
            return specializations
        }
        catch {
            let nserror = error as NSError
            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        return [Specialization]()
    }
    
    //Add a Specialization
    static func addSpecializations(subject: String) {
        
        let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate
        
        let context = appDelegate?.managedObjectContext
        
        let entity = NSEntityDescription.entityForName("Specialization", inManagedObjectContext: context!)
        
        let newSubject = Specialization(entity: entity!, insertIntoManagedObjectContext:context)
        newSubject.subject = subject
        
        do {
            try context?.save()
        }
        catch {
            let nserror = error as NSError
            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    //Fetch students of a specific Specialization
    static func getStudentsInSpecialization(subjectName: String) -> NSSet? {
        
        let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate
        let context = appDelegate?.managedObjectContext
        
        let specializationArray: [Specialization]?
        
        let predicate = NSPredicate(format: "subject == '\(subjectName)'")
        let request = NSFetchRequest(entityName: "Specialization")
        request.predicate = predicate
        
        specializationArray = try! context?.executeFetchRequest(request) as? [Specialization]
        if specializationArray?.count > 0 {
            return specializationArray![0].students
        } else {
            return nil
        }
    }
    
    //Fetch Computer Sc students
    //This function is written only to demonstrate use of Fetch Request templates
    static func getComputerScGraduates() -> NSSet? {
        
        let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate
        let context = appDelegate?.managedObjectContext
        
        let model = appDelegate?.managedObjectModel
        
        let specializationArray: [Specialization]?
        
        let request = model?.fetchRequestTemplateForName("fetchComputerScStudents")
        
        specializationArray = try! context?.executeFetchRequest(request!) as? [Specialization]
        if specializationArray?.count > 0 {
            return specializationArray![0].students
        } else {
            return nil
        }
    }
}
