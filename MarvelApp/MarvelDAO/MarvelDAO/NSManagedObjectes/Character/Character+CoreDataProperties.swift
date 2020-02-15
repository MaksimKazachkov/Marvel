//
//  Character+CoreDataProperties.swift
//  MarvelDAO
//
//  Created by Maksim Kazachkov on 15.02.2020.
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
    @NSManaged public var urls: NSSet?

}

// MARK: Generated accessors for urls
extension Character {

    @objc(addUrlsObject:)
    @NSManaged public func addToUrls(_ value: URLType)

    @objc(removeUrlsObject:)
    @NSManaged public func removeFromUrls(_ value: URLType)

    @objc(addUrls:)
    @NSManaged public func addToUrls(_ values: NSSet)

    @objc(removeUrls:)
    @NSManaged public func removeFromUrls(_ values: NSSet)

}
