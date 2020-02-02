//
//  MarvelNetworkTests.swift
//  MarvelNetworkTests
//
//  Created by Maksim Kazachkov on 28.01.2020.
//  Copyright © 2020 Maksim Kazachkov. All rights reserved.
//

import XCTest
@testable import MarvelNetwork
import Combine
import MarvelDomain

class MarvelNetworkTests: XCTestCase {
    
    let credentials = Credentials(
        ts: 1,
        publicKey: "5812e43551bf26c47f860ccc020c1154",
        privateKey: "a8d3b2a68f8266f631feac88f7dac78313d0745e"
    )
    
    let constructor = URLRequestConstructor(
        scheme: "https",
        host: "gateway.marvel.com",
        port: 443
    )
    
    var subscriptions = Set<AnyCancellable>()
    
    var client: Client!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        client = MarvelClient(
             constructor: constructor,
             credentials: credentials
         )
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        subscriptions.removeAll()

    }
    
    func testfetchCharacters() {
        let expectation = XCTestExpectation()
        let model = CharactersRO(limit: 20, offset: 0)
        client?.requestData(route: CharactersRoute.characters(model))
            .print()
            .sink(receiveCompletion: { (completion) in
                switch completion {
                case .finished:
                    expectation.fulfill()
                case .failure(let error):
                    XCTFail(error.localizedDescription)
                }
            }) { data in
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                } catch {
                    XCTFail(error.localizedDescription)
                }
        }
        .store(in: &subscriptions)
        
        wait(for: [expectation], timeout: 60)
    }
    
    func testFetchAndDecodeCharacters() {
        let expectation = XCTestExpectation()
        let model = CharactersRO(limit: 20, offset: 0)
        client?.requestObjects(Character.self, route: CharactersRoute.characters(model), at: "data.results")
            .print()
            .sink(receiveCompletion: { (completion) in
                switch completion {
                case .finished:
                    expectation.fulfill()
                case .failure(let error):
                    XCTFail(error.localizedDescription)
                }
            }) { characters in
                expectation.fulfill()
        }
        .store(in: &subscriptions)
        
        wait(for: [expectation], timeout: 60)
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
