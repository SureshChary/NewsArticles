//
//  ArticleTableViewCell.swift
//  NewsArticles
//
//  Created by Rachha on 2/20/19.
//  Copyright © 2019 Suresh Durishetti. All rights reserved.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {

    @IBOutlet weak var sectionTitle: UILabel!
    @IBOutlet weak var articleDate: UILabel!
    @IBOutlet weak var articleTitle: UILabel!
    @IBOutlet weak var articleDescription: UILabel!
    
    @IBOutlet weak var articleImageView: AsyncImageLoader!
    
    var articleResult: Result! {
        didSet {
            guard let articleData = articleResult else {
                return
            }
            self.updateCellUI(articleData: articleData)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.isAccessibilityElement = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func updateCellUI(articleData:Result)  {
        sectionTitle.text = articleData.section
        articleTitle.text = articleData.title
        articleDescription.text = articleData.abstract
        articleDate.text = articleData.publishedDate
        if articleData.media.count > 0 {
            if articleData.media[0].mediaMetadata.count > 1 {
                if let strUrl = articleData.media[0].mediaMetadata[1].url.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed),
                    let imgUrl = URL(string: strUrl) {
                    articleImageView.loadImageWithUrl(imgUrl)
                }
            }
        }
    }

}
