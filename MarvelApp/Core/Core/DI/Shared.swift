//
//  Shared.swift
//  Core
//
//  Created by Maksim Kazachkov on 27.05.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import Foundation
import Swinject

public let assembler = Assembler()

public var resolver: Resolver {
    assembler.resolver
}
