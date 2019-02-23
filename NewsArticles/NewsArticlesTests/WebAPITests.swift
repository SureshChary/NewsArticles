//
//  WebAPITests.swift
//  NewsArticlesTests
//
//  Created by Rachha on 2/23/19.
//  Copyright © 2019 Suresh Durishetti. All rights reserved.
//

import XCTest
@testable import NewsArticles

class WebAPITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testNYAPIKey() {
        XCTAssertEqual(WebAPI.sharedInstance.privateKey, "RKMBZf5AAQlMbOU3BtdsZA97QDUxQkqh", "My NY API is matching")
    }
    
    func testMostViewedArticles() {
        
        let expectation = XCTestExpectation(description: "Most Viewed Articles")
        var articleList: [Result]?
        WebAPI.sharedInstance.fetchFeaturedArticles(completion: {results,error in
            if results.count > 0 {
                articleList = results
            }
            XCTAssertNotNil(articleList)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 60.0)//wait for 60 seconds
    }
}
