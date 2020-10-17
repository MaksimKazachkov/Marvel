//
//  Image+DCT.swift
//  MarvelCoreDataRepository
//
//  Created by Максим Казачков on 17.10.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import CoreData
import MarvelDomain

extension Image: DomainConvertableType {
    
    public static func fetchRequest(by uid: String) -> NSFetchRequest<NSFetchRequestResult>? {
        return nil
    }
    
    public func asDomain() -> MarvelDomain.Image {
        return MarvelDomain.Image(
            path: path ?? "",
            extensionType: MarvelDomain.Image.ExtensionType(rawValue: ext ?? "")
        )
    }
    
}
