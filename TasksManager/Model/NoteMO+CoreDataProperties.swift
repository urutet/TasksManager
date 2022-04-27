//
//  NoteMO+CoreDataProperties.swift
//  TasksManager
//
//  Created by Yushkevich Ilya on 27.04.22.
//
//

import Foundation
import CoreData


extension NoteMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NoteMO> {
        return NSFetchRequest<NoteMO>(entityName: "NoteMO")
    }

    @NSManaged public var title: String?
    @NSManaged public var content: String?

}

extension NoteMO : Identifiable {

}
