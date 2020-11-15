//
//  ImageFetcher+LoadState.swift
//  Marvel
//
//  Created by Максим Казачков on 15.11.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import Foundation
import UIKit

public extension ImageFetcher {
    
    enum LoadState {
        
        case loading, loaded(UIImage), failed(Swift.Error)
        
        public var image: UIImage? {
            switch self {
            case .loaded(let value):
                return value
            case .loading,
                 .failed:
                return nil
            }
        }
        
    }
    
}
