//
//  CharacterMO+CoreDataProperties.swift
//  MarvelRepository
//
//  Created by Maksim Kazachkov on 03.02.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//
//

import Foundation
import CoreData


extension CharacterMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CharacterMO> {
        return NSFetchRequest<CharacterMO>(entityName: "Character")
    }
    
    @nonobjc public class func charactersFetchRequest() -> NSFetchRequest<NSFetchRequestResult> {
        return entity().managedObjectModel.fetchRequestTemplate(forName: "CharacterFetchRequest")!
    }

    @NSManaged public var desc: String?
    @NSManaged public var id: Int64
    @NSManaged public var modified: Date?
    @NSManaged public var name: String?
    @NSManaged public var resourceURI: URL?

}
