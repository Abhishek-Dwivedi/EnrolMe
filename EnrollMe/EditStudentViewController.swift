//
//  EditStudentViewController.swift
//  EnrollMe
//
//  Created by Abhishek Dwivedi on 09/06/16.
//  Copyright © 2016 Abhishek Dwivedi. All rights reserved.
//

import UIKit
import CoreData

class EditStudentViewController: UIViewController,SpecializationDelegate {

    var selectedStudent: Student?
    var chosenSpecialization: Specialization?
    var specializationVC = SpecializationViewController()
    
    @IBOutlet weak var nameTxtField: UITextField!
    @IBOutlet weak var rollNumberTxtField: UITextField!
    @IBOutlet weak var choseSpecialization: UIButton!
    @IBOutlet weak var specializationLabel: UILabel!
    
    override func viewWillAppear(animated: Bool) {
    
        if selectedStudent != nil {
            nameTxtField?.text = selectedStudent?.name
            rollNumberTxtField?.text = selectedStudent?.rollNumber
            
            if chosenSpecialization != nil {
                specializationLabel.text = chosenSpecialization?.subject
            }
            else {
                specializationLabel.text = selectedStudent?.specialization?.subject
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func submitTapped(sender: AnyObject) {
        
        if selectedStudent == nil {
            //Add new student
            Student.addStudent(nameTxtField.text!, studentRollNumber: rollNumberTxtField.text!, studentSpecialization: chosenSpecialization!)
        }
        else {
            //Edit student info
            Student.editStudentInfo(selectedStudent!, studentName: (nameTxtField?.text)!, studentRollNumber: (rollNumberTxtField?.text)!, studentSpecialization: (selectedStudent?.specialization)!)
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func cancelTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func specializationSelected(chosenSpecialization: Specialization) {
        self.chosenSpecialization = chosenSpecialization
        specializationLabel.text = self.chosenSpecialization?.subject
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 55
    }
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "specializationSegue"{
            let vc = segue.destinationViewController as? SpecializationViewController
            vc?.delegate = self
        }
    }
}
