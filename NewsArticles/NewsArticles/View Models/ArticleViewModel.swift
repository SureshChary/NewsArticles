//
//  ArticleViewModel.swift
//  NewsArticles
//
//  Created by Rachha on 2/20/19.
//  Copyright © 2019 Suresh Durishetti. All rights reserved.
//

import Foundation

class ArticleViewModel {

    var onResultHandling : (([Result]?) -> Void)?
    var onErrorHandling : ((String?) -> Void)?

   
    func fetchRequest()  {
        
        WebAPI.sharedInstance.fetchFeaturedArticles(completion: { (result, error) in
            DispatchQueue.main.async {

            if error == nil {
                self.onResultHandling?(result)
            } else {
                self.onErrorHandling?(error?.localizedDescription)

            }
            }
        })
        
    }
}
