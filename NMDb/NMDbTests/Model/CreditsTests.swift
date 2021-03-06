//
//  CreditsTests.swift
//  NMDbTests
//
//  Created by Gian Nucci on 02/02/18.
//  Copyright © 2018 nucci. All rights reserved.
//

import XCTest
@testable import NMDb

class CreditsTests: XCTestCase {

    var mock: BaseMock?
    let bundle = Bundle(for: CreditsTests.self)
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testValidParse() {
        mock = BaseMock(file: "credits", error: nil, bundle: bundle)
        do {
            let jsonData = try mock!.json()
            let credits = try JSONDecoder().decode(Credits.self, from: jsonData)
            
            XCTAssert((credits.crewList?.count ?? 0) > 0)
            XCTAssert((credits.castList?.count ?? 0) > 0)
            
        } catch {
            XCTFail("Parse should not fail")
        }
    }
    
    func testParseFail() {
        mock = BaseMock(file: "fail", error: nil, bundle: bundle)
        do {
            let jsonData = try mock!.json()
            let credits = try JSONDecoder().decode(Credits.self, from: jsonData)
            
            XCTAssertNotNil(credits)
            XCTAssertNil(credits.crewList)
            XCTAssertNil(credits.castList)
        } catch {
            XCTFail("Parse should not fail")
        }
    }
    
    func testParseEmpty() {
        mock = BaseMock(file: "error", error: nil, bundle: bundle)
        do {
            let jsonData = try mock!.json()
            XCTAssertThrowsError(try JSONDecoder().decode(Credits.self, from: jsonData))
        } catch { }
    }

}
