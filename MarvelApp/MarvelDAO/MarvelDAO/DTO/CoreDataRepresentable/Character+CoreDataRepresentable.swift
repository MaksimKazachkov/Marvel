//
//  Character+CoreDataRepresentable.swift
//  MarvelRepository
//
//  Created by Maksim Kazachkov on 03.02.2020.
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
        if let context = entity.managedObjectContext {
            urls?.forEach({
                let urlEntity = MarvelDAO.URLType(context: context)
                $0.update(entity: urlEntity)
                entity.addToUrls(urlEntity)
            })
            if let comics = comics {
                if let comicsEntity = entity.comics {
                    comics.update(entity: comicsEntity)
                } else {
                    let request: NSFetchRequest<Resource> = MarvelDAO.Resource.fetchRequest(by: entity)
                    if let comicsEntity = try? context.fetch(request).first {
                        comics.update(entity: comicsEntity)
                        entity.comics = comicsEntity
                    } else {
                        let comicsEntity = MarvelDAO.Resource(context: context)
                        comics.update(entity: comicsEntity)
                        entity.comics = comicsEntity
                    }
                }
            }
            if let stories = stories {
                if let storiesEntity = entity.stories {
                    stories.update(entity: storiesEntity)
                } else {
                    let request: NSFetchRequest<Resource> = MarvelDAO.Resource.fetchRequest(by: entity)
                    if let storiesEntity = try? context.fetch(request).first {
                        stories.update(entity: storiesEntity)
                        entity.stories = storiesEntity
                    } else {
                        let storiesEntity = MarvelDAO.Resource(context: context)
                        stories.update(entity: storiesEntity)
                        entity.stories = storiesEntity
                    }
                }
            }
            if let events = events {
                if let eventsEntity = entity.events {
                    events.update(entity: eventsEntity)
                } else {
                    let request: NSFetchRequest<Resource> = MarvelDAO.Resource.fetchRequest(by: entity)
                    if let eventsEntity = try? context.fetch(request).first {
                        events.update(entity: eventsEntity)
                        entity.events = eventsEntity
                    } else {
                        let eventsEntity = MarvelDAO.Resource(context: context)
                        events.update(entity: eventsEntity)
                        entity.events = eventsEntity
                    }
                }
            }
            if let series = series {
                if let seriesEntity = entity.series {
                    series.update(entity: seriesEntity)
                } else {
                    let request: NSFetchRequest<Resource> = MarvelDAO.Resource.fetchRequest(by: entity)
                    if let seriesEntity = try? context.fetch(request).first {
                        series.update(entity: seriesEntity)
                        entity.series = seriesEntity
                    } else {
                        let seriesEntity = MarvelDAO.Resource(context: context)
                        series.update(entity: seriesEntity)
                        entity.series = seriesEntity
                    }
                }
            }
        }
    }
    
}
