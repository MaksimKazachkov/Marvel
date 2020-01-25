//
//  MarvelApiTests.swift
//  MarvelApiTests
//
//  Created by Maksim Kazachkov on 23.01.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import XCTest
@testable import MarvelApi

class MarvelApiTests: XCTestCase {
    
    let credentials = Credentials.init(ts: 1,
                                       publicKey: "5812e43551bf26c47f860ccc020c1154",
                                       privateKey: "a8d3b2a68f8266f631feac88f7dac78313d0745e")

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
