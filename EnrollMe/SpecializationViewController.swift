//
//  SpecializationViewController.swift
//  EnrollMe
//
//  Created by Abhishek Dwivedi on 09/06/16.
//  Copyright © 2016 Abhishek Dwivedi. All rights reserved.
//

import UIKit
import CoreData

protocol SpecializationDelegate: class {
    func specializationSelected(chosenSpecialization:Specialization);
}

class SpecializationViewController: UITableViewController {

    var subjects: [Specialization]?
    weak var delegate: SpecializationDelegate?
    
    @IBOutlet var specializationsTableview: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        subjects = Specialization.getSpecializations()
        
        //Add Specializations through code(For testing purposes).
        //Should be done in the backend
        //Uncomment when app is run for the first time to add Specializations in the Database. Comment back once Specializations are added.
        /*
        Specialization.addSpecializations("Maths")
        Specialization.addSpecializations("Biology")
        Specialization.addSpecializations("Computer Sc.")
        Specialization.addSpecializations("English")
        Specialization.addSpecializations("Hindi")
        */
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return subjects!.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("identifier", forIndexPath: indexPath)
        
        cell.contentView.backgroundColor = UIColor.randomColor()
        cell.textLabel?.backgroundColor = UIColor.clearColor()
        cell.detailTextLabel?.backgroundColor = UIColor.clearColor()

        let subject = subjects![indexPath.row]
        cell.textLabel?.text = subject.subject
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let selectedSubject = subjects![indexPath.row]
        delegate?.specializationSelected(selectedSubject)

        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
