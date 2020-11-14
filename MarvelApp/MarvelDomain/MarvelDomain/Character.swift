//
//  Character.swift
//  MarvelDomain
//
//  Created by Maksim Kazachkov on 26.01.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import Foundation

public struct Character: Identifiable, Equatable {
    
    // The unique ID of the character resource.
    public let id: Int?
    
    // The name of the character.
    public let name: String?
    
    // A short bio or description of the character.
    public let description: String?
    
    // The date the resource was most recently modified.
    public let modified: Date?
    
    // The canonical URL identifier for this resource.
    public let resourceURI: URL?
    
    // A set of public web site URLs for the resource.
    public let urls: [URLType]?
    
    public let thumbnail: Image?
    
    // A resource list containing comics which feature this character.
    public let comics: Resource?
    
    // A resource list of stories in which this character appears.
    public let stories: Resource?
    
    // A resource list of events in which this character appears.
    public let events: Resource?
    
    // A resource list of series in which this character appears.
    public let series: Resource?
    
    public init(
        id: Int?,
        name: String?,
        description: String?,
        modified: Date?,
        resourceURI: URL?,
        urls: [URLType]?,
        thumbnail: Image?,
        comics: Resource?,
        stories: Resource?,
        events: Resource?,
        series: Resource?
    ) {
        self.id = id
        self.name = name
        self.description = description
        self.modified = modified
        self.resourceURI = resourceURI
        self.urls = urls
        self.thumbnail = thumbnail
        self.comics = comics
        self.stories = stories
        self.events = events
        self.series = series
    }
    
}
