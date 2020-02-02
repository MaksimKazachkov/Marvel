//
//  ImageClient.swift
//  MarvelNetwork
//
//  Created by Maksim Kazachkov on 02.02.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import Foundation
import Combine

protocol ImageClient {
    
    func image(for url: URL) -> AnyPublisher<Data, Error>
    
}
