//
//  Character+CDR.swift
//  MarvelCoreDataRepository
//
//  Created by Maksim Kazachkov on 22.05.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import Foundation
import CoreData
import MarvelDomain

extension MarvelDomain.Character: CoreDataRepresentable {
    
    public var uid: String? {
        guard let id = id else {
            return nil
        }
        return String(id)
    }
    
    public func update(entity: Character) {
        if let id = id {
            entity.id = Int64(id)
        }
        entity.name = name
        entity.desc = description
        entity.modified = modified
        entity.resourceURI = resourceURI
        guard let context = entity.managedObjectContext else {
            return
        }
        if let thumbnail = thumbnail {
            if let imageEntity = entity.thumbnail {
                thumbnail.update(entity: imageEntity)
            } else {
                let imageEntity = MarvelCoreDataRepository.Image(context: context)
                thumbnail.update(entity: imageEntity)
                entity.thumbnail = imageEntity
            }
        }
        
        entity.removeFromUrls(entity.urls)
        urls?.forEach({
            let urlEntity = MarvelCoreDataRepository.URLType(context: context)
            $0.update(entity: urlEntity)
            entity.addToUrls(urlEntity)
        })
        if let comics = comics {
            if let comicsEntity = entity.comics {
                comics.update(entity: comicsEntity)
            } else {
                let comicsEntity = MarvelCoreDataRepository.Resource(context: context)
                comics.update(entity: comicsEntity)
                entity.comics = comicsEntity
            }
        }
        if let stories = stories {
            if let storiesEntity = entity.stories {
                stories.update(entity: storiesEntity)
            } else {
                let storiesEntity = MarvelCoreDataRepository.Resource(context: context)
                stories.update(entity: storiesEntity)
                entity.stories = storiesEntity
            }
        }
        if let events = events {
            if let eventsEntity = entity.events {
                events.update(entity: eventsEntity)
            } else {
                let eventsEntity = MarvelCoreDataRepository.Resource(context: context)
                events.update(entity: eventsEntity)
                entity.events = eventsEntity
            }
        }
        if let series = series {
            if let seriesEntity = entity.series {
                series.update(entity: seriesEntity)
            } else {
                let seriesEntity = MarvelCoreDataRepository.Resource(context: context)
                series.update(entity: seriesEntity)
                entity.series = seriesEntity
            }
        }
    }
    
}
