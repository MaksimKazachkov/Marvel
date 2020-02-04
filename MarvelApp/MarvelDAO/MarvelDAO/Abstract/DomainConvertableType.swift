//
//  DomainCovertableType.swift
//  MarvelRepository
//
//  Created by Maksim Kazachkov on 03.02.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import Foundation

public protocol DomainConvertableType {
    
    associatedtype DomainType

    func asDomain() -> DomainType
    
}
