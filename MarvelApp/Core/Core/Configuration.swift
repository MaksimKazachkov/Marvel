//
//  Configuration.swift
//  Core
//
//  Created by Maksim Kazachkov on 07.02.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import Foundation

public struct Configuration: Codable {
    
     public let scheme: String
       
     public let host: String
       
     public let port: Int?
    
}
