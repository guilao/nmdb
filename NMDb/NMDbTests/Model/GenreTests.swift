//
//  GenreTests.swift
//  NMDbTests
//
//  Created by Gian Nucci on 02/02/18.
//  Copyright © 2018 nucci. All rights reserved.
//

import XCTest
@testable import NMDb

class GenreTests: XCTestCase {

    var mock: BaseMock?
    let bundle = Bundle(for: GenreTests.self)
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testValidParse() {
        mock = BaseMock(file: "genre", error: nil, bundle: bundle)
        do {
            let jsonData = try mock!.json()
            let genre = try JSONDecoder().decode(Genre.self, from: jsonData)
            
            XCTAssertEqual(genre.name!, "Action")
            XCTAssertEqual(genre.identifier!, 28)
            
        } catch {
            XCTFail("Parse should not fail")
        }
    }
    
    func testParseFail() {
        mock = BaseMock(file: "fail", error: nil, bundle: bundle)
        do {
            let jsonData = try mock!.json()
            let genre = try JSONDecoder().decode(Genre.self, from: jsonData)
            
            XCTAssertNotNil(genre)
            XCTAssertNil(genre.name)
            XCTAssertNil(genre.identifier)
        } catch {
            XCTFail("Parse should not fail")
        }
    }
    
    func testParseEmpty() {
        mock = BaseMock(file: "error", error: nil, bundle: bundle)
        do {
            let jsonData = try mock!.json()
            XCTAssertThrowsError(try JSONDecoder().decode(Genre.self, from: jsonData))
        } catch { }
    }
}
