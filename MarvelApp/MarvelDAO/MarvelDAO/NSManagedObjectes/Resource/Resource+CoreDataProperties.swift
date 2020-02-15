//
//  Resource+CoreDataProperties.swift
//  MarvelDAO
//
//  Created by Maksim Kazachkov on 15.02.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//
//

import Foundation
import CoreData


extension Resource {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Resource> {
        return NSFetchRequest<Resource>(entityName: "Resource")
    }

    @NSManaged public var available: Int16
    @NSManaged public var collectionURI: URL?
    @NSManaged public var returned: Int16
    @NSManaged public var items: Set<Item>

}

// MARK: Generated accessors for items
extension Resource {

    @objc(addItemsObject:)
    @NSManaged public func addToItems(_ value: Item)

    @objc(removeItemsObject:)
    @NSManaged public func removeFromItems(_ value: Item)

    @objc(addItems:)
    @NSManaged public func addToItems(_ values: Set<Item>)

    @objc(removeItems:)
    @NSManaged public func removeFromItems(_ values: Set<Item>)

}
