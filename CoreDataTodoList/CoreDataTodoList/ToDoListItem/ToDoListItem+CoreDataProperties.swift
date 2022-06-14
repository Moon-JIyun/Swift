//
//  ToDoListItem+CoreDataProperties.swift
//  CoreDataTodoList
//
//  Created by jiyun moon on 2022/06/14.
//
//

import Foundation
import CoreData


extension ToDoListItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDoListItem> {
        return NSFetchRequest<ToDoListItem>(entityName: "ToDoListItem")
    }

    @NSManaged public var createdAt: Date?
    @NSManaged public var name: String?

}

extension ToDoListItem : Identifiable {

}
