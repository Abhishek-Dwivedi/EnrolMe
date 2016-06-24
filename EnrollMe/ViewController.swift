//
//  ViewController.swift
//  EnrollMe
//
//  Created by Abhishek Dwivedi on 09/06/16.
//  Copyright © 2016 Abhishek Dwivedi. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    var studentsArray: [Student]?
    @IBOutlet weak var studentsTableview: UITableView!
    
    override func viewWillAppear(animated: Bool) {
        studentsArray = Student.getStudents()
        studentsTableview.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "EnrollMe"
        
        //APIs test
        //For Testing Purpose Only
        printStudentsData()
        
        if let students = Specialization.getStudentsInSpecialization("Biology") {
            for student in students {
                    print("Biology : \(student.valueForKey("name")!)")
            }
        }
        
        if let students = Specialization.getComputerScGraduates() {
            for student in students {
                print("Computer Sc. : \(student.valueForKey("name")!)")
            }
        }
        
        if let students = Student.searchStudentByName("Abhishek") {
            for student in students {
                print("Student found :: \(student.name!)")
            }
        }
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let studentsArray = studentsArray {
            return studentsArray.count
        } else {
            return 0
        }
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("identifier", forIndexPath: indexPath)
        
        cell.contentView.backgroundColor = UIColor.randomColor()
        cell.textLabel?.backgroundColor = UIColor.clearColor()
        cell.detailTextLabel?.backgroundColor = UIColor.clearColor()
        
        let student = studentsArray![indexPath.row]
        cell.textLabel?.text = student.name
        if let rollNumberString = student.rollNumber {
            cell.detailTextLabel?.text = "Roll Number : " + rollNumberString
        } else {
            cell.detailTextLabel?.text = ""
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 60
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.Delete {
            let student = studentsArray![indexPath.row]
            studentsArray?.removeAtIndex(indexPath.row)
            Student.deleteStudent(student )
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "studentTapped" {
            
            let row = studentsTableview.indexPathForSelectedRow?.row
            let vc = segue.destinationViewController as? EditStudentViewController
            vc?.selectedStudent = studentsArray?[row!]
        }
    }
    
    //For Testing Purpose Only
    func printStudentsData() {
        let students = Student.getStudents()
        
        for student in students! {
            print(student.name!, student.rollNumber!, (student.specialization?.subject)!)
        }
    }
    
    @IBAction func sortTapped(sender: AnyObject) {
        let sortedStudents = Student.sortStudentsBasedOnAttribute("name")
        studentsArray = sortedStudents
        studentsTableview.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}