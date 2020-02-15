//
//  URLType+CoreDataProperties.swift
//  MarvelDAO
//
//  Created by Maksim Kazachkov on 15.02.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//
//

import Foundation
import CoreData


extension URLType {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<URLType> {
        return NSFetchRequest<URLType>(entityName: "URLType")
    }

    @NSManaged public var type: String?
    @NSManaged public var url: URL?

}
