//
//  NasaApodNetworkTest.swift
//  NasaApodTests
//
//  Created by Nishant Bhasin on 7/31/18.
//  Copyright © 2018 Nishant Bhasin. All rights reserved.
//

import XCTest
@testable import NasaApod

class NasaApodNetworkTest: XCTestCase {
    
    var urlComponents:URLComponents?
    let testTimeout:TimeInterval = 10
    
    override func setUp() {
        super.setUp()
        self.urlComponents = URLComponents()
        urlComponents?.scheme = "https"
        urlComponents?.host = ApodUrlConstants.host
        urlComponents?.path = ApodUrlConstants.path
        urlComponents?.queryItems = [
            URLQueryItem(name: "api_key", value: ApodUrlConstants.key)
        ]
        
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    //This test we perform to check how our Network Manager getApodData reacts to a key with proper params
    //We should get an no error back and response data should not be nil
    func testServerResponseWithProperKey() {
        let expectation = XCTestExpectation(description: "Server Response With Proper Key")
        if urlComponents == nil {
            XCTAssertFalse(true)
        }
        let url = urlComponents?.url
        NetworkManager.shared.getApodData(from: url!) { (apodResponseData, error) in
            XCTAssertNotNil(apodResponseData)
            XCTAssertNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: TimeInterval(testTimeout))
    }
    
    //This test we perform to check how our Network Manager getApodData reacts to a key with no query params
    //We should get an error back and response data should be nil
    func testServerResponseWithBadKey() {
        let expectation = XCTestExpectation(description: "Server Response Bad Key")
        if urlComponents == nil {
            XCTAssertFalse(true)
        }
        urlComponents?.queryItems = nil
        let url = urlComponents?.url
        NetworkManager.shared.getApodData(from: url!) { (apodResponseData, error) in
            XCTAssertNil(apodResponseData)
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: TimeInterval(testTimeout))
    }
}
