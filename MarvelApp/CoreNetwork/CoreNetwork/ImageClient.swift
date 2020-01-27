//
//  ImageClient.swift
//  CoreNetwork
//
//  Created by Maksim Kazachkov on 28.01.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import Foundation
import Combine

public protocol ImageClient {
    
    func image(for url: URL) -> AnyPublisher<Data, Error>
    
}
