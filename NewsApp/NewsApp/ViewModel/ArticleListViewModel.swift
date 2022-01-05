//
//  ArticleListViewModel.swift
//  NewsApp
//
//  Created by jiyun moon on 2022/01/03.
//

import Foundation
import UIKit

struct ArticleListViewModel {
    let items: [NewsInfo]
}

extension ArticleListViewModel {
    var numberOfSection: Int {
        return 1
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return self.items.count
    }
    
    func articleAtIndex(_ index: Int) -> ArticleViewModel {
        let item = self.items[index]
//        print("ItematIndex: \(index) : \(item)")
        return ArticleViewModel(item)
    }
}

struct ArticleViewModel {
    private let item : NewsInfo
}

extension ArticleViewModel {
    init(_ item: NewsInfo) {
        self.item = item
//        print("At ArticlVM Item :\(item)")
    }
}

extension ArticleViewModel {
    var title: String? {
        return self.item.title
    }
    
    var description: String? {
        return self.item.description
    }
}
