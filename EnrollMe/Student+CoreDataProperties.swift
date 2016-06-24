//
//  Student+CoreDataProperties.swift
//  EnrollMe
//
//  Created by Abhishek Dwivedi on 15/06/16.
//  Copyright © 2016 Abhishek Dwivedi. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Student {

    @NSManaged var name: String?
    @NSManaged var rollNumber: String?
    @NSManaged var specialization: Specialization?
}
