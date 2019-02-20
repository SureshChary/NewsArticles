//
//  ArticleDetailViewController.swift
//  NewsArticles
//
//  Created by Rachha on 2/20/19.
//  Copyright © 2019 Suresh Durishetti. All rights reserved.
//

import UIKit

class ArticleDetailViewController: BaseViewController {

    @IBOutlet weak var sectionLabel: UILabel!
    @IBOutlet weak var articleImageView: AsyncImageLoader!
    @IBOutlet weak var articleTitle: UILabel!
    @IBOutlet weak var articleDescription: UILabel!
    @IBOutlet weak var publishDate: UILabel!
    
    var articleResult: Result!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        sectionLabel.text = articleResult.section
        articleTitle.text = articleResult.title
        articleDescription.text = articleResult.abstract
        publishDate.text = articleResult.publishedDate
        if articleResult.media.count > 0 {
            if articleResult.media[0].mediaMetadata.count > 0 {
                if let strUrl = articleResult.media[0].mediaMetadata[0].url.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed),
                    let imgUrl = URL(string: strUrl) {
                    articleImageView.loadImageWithUrl(imgUrl)
                }
            }
        }
        
    }
}
