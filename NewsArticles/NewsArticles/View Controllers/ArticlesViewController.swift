//
//  ArticlesViewController.swift
//  NewsArticles
//
//  Created by Rachha on 2/20/19.
//  Copyright © 2019 Suresh Durishetti. All rights reserved.
//

import UIKit

class ArticlesViewController: BaseViewController {

    @IBOutlet weak var articletableView: UITableView!
    
    var articleViewModel:ArticleViewModel = {
            let viewModel = ArticleViewModel()
            viewModel.fetchRequest()
            return viewModel
    }()
    var articlelist:[Result] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Most Viewed Articles"
        // Do any additional setup after loading the view.
       
        articletableView.accessibilityIdentifier = "TheTable"
        articletableView.isAccessibilityElement = true

        articletableView.estimatedRowHeight = 120
        articletableView.rowHeight = UITableView.automaticDimension
        articletableView.dataSource = self;
        handleArticleResponse()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ArticleDetail" {
            let row = (articletableView.indexPathForSelectedRow?.row)!
            let detailViewController = segue.destination as! ArticleDetailViewController
            detailViewController.articleResult = articlelist[row]
        }
    }
    func handleArticleResponse()  {
        let activityLoader = ActivityIndicatorView()
        activityLoader.showActivityIndicatory(uiView: self.view)
        articleViewModel.onResultHandling = { [weak self] result in
            DispatchQueue.main.async {
                activityLoader.hideActivityIndicator()
                if let result = result {
                    self?.articlelist = result
                    self?.articletableView.reloadData()
                }
            }
        }
        articleViewModel.onErrorHandling = { [weak self] errorMsg in
            DispatchQueue.main.async {
                activityLoader.hideActivityIndicator()
                if let message = errorMsg {
                    self?.showAlertWithMessage(alertTitle: "", alertMessage: message)
                }
            }
        }
    }
}

extension ArticlesViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articlelist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell") as! ArticleTableViewCell
        cell.articleResult = articlelist[indexPath.row]
        cell.accessibilityLabel = "TheCell"
        cell.accessibilityIdentifier = "TheCell"
        cell.isAccessibilityElement = true
       // cell.selectionStyle = .none
        return cell
    }
}
