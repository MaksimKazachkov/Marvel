//
//  HTTPMethod.swift
//  MarvelApi
//
//  Created by Maksim Kazachkov on 23.01.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import Foundation

public enum HTTPMethod: String {
    
      case options = "OPTIONS"
      case get     = "GET"
      case head    = "HEAD"
      case post    = "POST"
      case put     = "PUT"
      case patch   = "PATCH"
      case delete  = "DELETE"
      case trace   = "TRACE"
      case connect = "CONNECT"
        
}
