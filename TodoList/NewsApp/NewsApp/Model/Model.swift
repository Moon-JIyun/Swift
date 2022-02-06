//
//  Model.swift
//  NewsApp
//
//  Created by jiyun moon on 2021/12/27.
//

import Foundation


struct SearchResult: Codable {
    let items: [NewsInfo]
}

struct NewsInfo: Codable {
    let title: String?
//    let originallink: URL?
//    let link: URL?
    let description: String?
//    let pubDate: String?
}
