//
//  NasaApodTests.swift
//  NasaApodTests
//
//  Created by Nishant Bhasin on 7/30/18.
//  Copyright © 2018 Nishant Bhasin. All rights reserved.
//

import XCTest
@testable import NasaApod

class NasaApodParserTests: XCTestCase {
    
    let urlToCheck = "https://apod.nasa.gov/apod/image/1807/SouthPole_MarsExpress_1080.jpg"
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    //Our parser is a static function of ApodResponse Data
    //We'll use Perfect response constants from NasaApodTestConstants file
    func testApodParserPerfect() {
        let result = ApodResponseData.parse(json: testResponseContract.perfect)
        XCTAssertNotNil(result)
        XCTAssertTrue(urlToCheck == result?.url)
    }
    
    //Our parser is a static function of ApodResponse Data
    //We'll use wrong int url i.e. not the json we are expecting for url
    //This should return nil
    func testApodParserWrongUrl() {

        let result = ApodResponseData.parse(json: testResponseContract.wrongIntUrl)
        XCTAssertNil(result)
    }
    
    //Our parser is a static function of ApodResponse Data
    //We'll use Empty Json response constants from NasaApodTestConstants file
    //This should return non nil because the json is still valid but has nothing in it
    //So, in the end we'll just have ApodResponseData with nil values in it as we support that
    //Hence, not nil
    func testApodParserEmptyJson() {
        let result = ApodResponseData.parse(json: testResponseContract.emptyJsonResponse)
        XCTAssertNotNil(result)
    }
    
    //Our parser is a static function of ApodResponse Data
    //We'll use Empty String response constants from NasaApodTestConstants file
    //This should return nil
    func testApodParserEmpty() {
        let result = ApodResponseData.parse(json: testResponseContract.emptyString)
        XCTAssertNil(result)
    }
}
