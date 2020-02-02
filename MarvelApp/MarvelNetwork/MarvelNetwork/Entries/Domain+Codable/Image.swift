//
//  Image.swift
//  MarvelApi
//
//  Created by Maksim Kazachkov on 26.01.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import Foundation
import MarvelDomain

extension Image: Codable {

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self = .init(
            path: try container.decode(String.self, forKey: .path),
            extensionType: Image.ExtensionType(rawValue: try container.decode(String.self, forKey: .extensionType))
        )
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(path, forKey: .path)
        try container.encode(extensionType.rawValue, forKey: .extensionType)
    }

    private enum CodingKeys: String, CodingKey {

        case path
        
        case extensionType = "extension"

    }

}
