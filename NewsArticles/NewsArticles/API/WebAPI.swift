//
//  WebAPI.swift
//  NewsArticles
//
//  Created by Rachha on 2/20/19.
//  Copyright © 2019 Suresh Durishetti. All rights reserved.
//

import UIKit

class WebAPI: NSObject {
    static let sharedInstance = WebAPI()
    
    private let sessionManager: URLSession = {
        let urlSessionConfiguration: URLSessionConfiguration = URLSessionConfiguration.default
        return URLSession(configuration: urlSessionConfiguration, delegate: nil, delegateQueue: nil)
    }()
    
    private override init() {
        print("WebAPI is singleton class")
    }
    
    func fetchFeaturedArticles(completion: @escaping ([Result], Error?) -> ()) {
        
        let articlesUrl = URL(string: "http://api.nytimes.com/svc/mostpopular/v2/mostviewed/all-sections/7.json?api-key=RKMBZf5AAQlMbOU3BtdsZA97QDUxQkqh")
        
        URLSession.shared.dataTask(with:URLRequest(url:articlesUrl!) ) { (data, response, error) in
            
            guard error == nil else {
                print("Error in network response! \(String(describing: error?.localizedDescription))")
                completion([], error)
                return
            }
            if let jsondata = data {
                let allArticlesObject = try? JSONDecoder().decode(FeatureArticles.self, from: jsondata)
                print("allArticlesObject \(String(describing: allArticlesObject))")
                completion((allArticlesObject?.results)!, error)
            }
            }.resume()
    }

}
