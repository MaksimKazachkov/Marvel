//
//  Character+CoreDataProperties.swift
//  MarvelCoreDataRepository
//
//  Created by Максим Казачков on 17.10.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//
//

import Foundation
import CoreData


extension Character {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Character> {
        return NSFetchRequest<Character>(entityName: "Character")
    }

    @NSManaged public var desc: String?
    @NSManaged public var id: Int64
    @NSManaged public var modified: Date?
    @NSManaged public var name: String?
    @NSManaged public var resourceURI: URL?
    @NSManaged public var comics: Resource?
    @NSManaged public var events: Resource?
    @NSManaged public var series: Resource?
    @NSManaged public var stories: Resource?
    @NSManaged public var urls: Set<URLType>
    @NSManaged public var thumbnail: Image?

}

// MARK: Generated accessors for urls
extension Character {

    @objc(addUrlsObject:)
    @NSManaged public func addToUrls(_ value: URLType)

    @objc(removeUrlsObject:)
    @NSManaged public func removeFromUrls(_ value: URLType)

    @objc(addUrls:)
    @NSManaged public func addToUrls(_ values: Set<URLType>)

    @objc(removeUrls:)
    @NSManaged public func removeFromUrls(_ values: Set<URLType>)

}
