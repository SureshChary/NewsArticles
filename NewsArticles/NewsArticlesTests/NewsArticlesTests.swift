//
//  NewsArticlesTests.swift
//  NewsArticlesTests
//
//  Created by Rachha on 2/20/19.
//  Copyright © 2019 Suresh Durishetti. All rights reserved.
//

import XCTest
@testable import NewsArticles

class NewsArticlesTests: XCTestCase {


    var articleViewController:ArticlesViewController!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        self.articleViewController = storyboard.instantiateViewController(withIdentifier: "ArticlesViewController") as? ArticlesViewController
        self.articleViewController.loadView()
        self.articleViewController.viewDidLoad()
        
        let url = Bundle.main.url(forResource: "StacticArticleJSON", withExtension: "json")!
        do {
            let jsonData = try Data(contentsOf: url)
            let allArticlesObject = try? JSONDecoder().decode(FeatureArticles.self, from: jsonData)

            self.articleViewController.articlelist = (allArticlesObject?.results)!
            self.articleViewController.articletableView.reloadData()
        }
        catch {
            print(error)
        }

    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        self.articleViewController = nil
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
    
    func testHasATableView() {
        XCTAssertNotNil(self.articleViewController.articletableView)
    }
    
    func testTableViewHasDataSource() {
        XCTAssertNotNil(self.articleViewController.articletableView.dataSource)
    }
    
    func testTableViewCellHasReuseIdentifier() {
        let cell = self.articleViewController.articletableView.cellForRow(at: IndexPath(row: 0, section: 0))
        let actualReuseIdentifer = cell?.reuseIdentifier
        let expectedReuseIdentifier = "ArticleTableViewCell"
        XCTAssertEqual(actualReuseIdentifer, expectedReuseIdentifier)
    }
    
    func testSegueShouldExist() {
        let identifiers = getSegues(ofViewController: self.articleViewController)
        XCTAssertEqual(identifiers.count, 1, "Segue count should equal one.")
        XCTAssertTrue(identifiers.contains("ArticleDetail"), "Segue searchSegue should exist.")
    }
    
    func getSegues(ofViewController viewController: UIViewController) -> [String] {
        let identifiers = (viewController.value(forKey: "storyboardSegueTemplates") as? [AnyObject])?.compactMap({ $0.value(forKey: "identifier") as? String }) ?? []
        return identifiers
    }
}
