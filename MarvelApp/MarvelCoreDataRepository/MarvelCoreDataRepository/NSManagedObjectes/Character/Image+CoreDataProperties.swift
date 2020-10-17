//
//  Image+CoreDataProperties.swift
//  MarvelCoreDataRepository
//
//  Created by Максим Казачков on 17.10.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//
//

import Foundation
import CoreData


extension Image {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Image> {
        return NSFetchRequest<Image>(entityName: "Image")
    }

    @NSManaged public var path: String?
    @NSManaged public var ext: String?
    @NSManaged public var character: Character?

}
