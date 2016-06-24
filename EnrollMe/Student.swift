//T//
//  Student.swift
//  EnrollMe
//
//  Created by Abhishek Dwivedi on 15/06/16.
//  Copyright © 2016 Abhishek Dwivedi. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class Student: NSManagedObject {

    //Fetch all students
    static func getStudents() -> [Student]? {
        
        var students: [Student]?
        
        let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate
        
        let context = appDelegate?.managedObjectContext
        
        let request = NSFetchRequest(entityName: "Student")
        
        do {
            try students = context?.executeFetchRequest(request) as? [Student]
            return students
        }
        catch {
            let nserror = error as NSError
            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        return [Student]()
    }
    
    //Add a student
    static func addStudent(studentName: String, studentRollNumber: String, studentSpecialization: Specialization) {

        let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate
        
        let context = appDelegate?.managedObjectContext
        
        let entity = NSEntityDescription.entityForName("Student", inManagedObjectContext: context!)
        
        let newStudent = Student(entity: entity!, insertIntoManagedObjectContext:context)
                
        newStudent.name = studentName
        newStudent.rollNumber = studentRollNumber
        newStudent.specialization = studentSpecialization
        
        do {
            try context?.save()
        }
        catch {
            let nserror = error as NSError
            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    //Edit student info
    static func editStudentInfo(student: Student, studentName: String, studentRollNumber: String, studentSpecialization: Specialization) {
        
        let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate
        
        let context = appDelegate?.managedObjectContext
        
        student.specialization = studentSpecialization
        student.rollNumber = studentRollNumber
        student.name = studentName
        
        do {
            try context?.save()
        }
        catch {
            let nserror = error as NSError
            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    //Delete student
    static func deleteStudent(student: Student) {

        let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate
        
        let context = appDelegate?.managedObjectContext
        
        context?.deleteObject(student)
        
        do {
            try context?.save()
        }
        catch {
            let nserror = error as NSError
            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    //Sort students based on any given attribute
    static func sortStudentsBasedOnAttribute(attribute: String) -> [Student]? {
        
        let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate
        let context = appDelegate?.managedObjectContext
        
        let sortedArray: [Student]?
        let sort = NSSortDescriptor(key: attribute, ascending: true)
        let request = NSFetchRequest(entityName: "Student")
        request.sortDescriptors = [sort]
        
        sortedArray = try! context?.executeFetchRequest(request) as? [Student]
        
        return sortedArray
    }
    
    //Search Asynchronously
    static func searchStudentByName(studentName: String) -> [Student]? {
        
        let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate
        let context = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.MainQueueConcurrencyType)
        context.persistentStoreCoordinator = appDelegate?.persistentStoreCoordinator
        var students: [Student]?
        
        let predicate = NSPredicate(format: "name =='\(studentName)'")
        let request = NSFetchRequest(entityName: "Student")
        request.predicate = predicate
        
        let async = NSAsynchronousFetchRequest(fetchRequest: request) { (result) -> Void in
            students = result.finalResult as? [Student]
        }
        
        try! context.executeRequest(async)
        
        return students
    }
}
