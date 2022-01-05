//
//  ArticleTableView.swift
//  NewsApp
//
//  Created by jiyun moon on 2021/12/31.
//

import Foundation
import UIKit

class ArticleTableView: UITableViewController {
    
    var queryValue: String = ""
    private var articleVM: ArticleListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let cellNib = UINib(nibName: "ArticleTableViewCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "ArticleTableViewCell")
        setup()
        
    }
    
    private func setup() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        NewsAPI().APICaller(queryValue: queryValue) {
            (items) in
            if let items = items {
                self.articleVM = ArticleListViewModel(items: items)
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
//            print("검색어\(self.queryValue)")
        }
    }
}

extension ArticleTableView {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articleVM.numberOfRowsInSection(section)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.articleVM == nil ? 0: self.articleVM.numberOfSection
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell", for: indexPath) as? ArticleTableViewCell else {
            fatalError("no matched articleTableViewCell identifier")}
            
            let articleVM = self.articleVM.articleAtIndex(indexPath.row)
//            print("제목:\(articleVM.title)")
        //            print("내용:\(articleVM.description)")
        cell.titleLabel?.text = articleVM.title?.replacingOccurrences(of: "</b>", with: "").replacingOccurrences(of: "<b>", with: "")
        cell.DescriptionLabel?.text = articleVM.description?.replacingOccurrences(of: "</b>", with: "").replacingOccurrences(of: "<b>", with: "")
        
            return cell
    }
}
