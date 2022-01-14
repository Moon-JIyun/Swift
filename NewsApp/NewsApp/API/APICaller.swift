//
//  APICaller.swift
//  NewsApp
//
//  Created by jiyun moon on 2021/12/27.
//

// Client ID : IqUVLpCx1qlACFBZR6Kp
// Client PW : r3NkQnZGIT

import Foundation

class NewsAPI {

    func APICaller(queryValue: String, completion: @escaping([NewsInfo]?)->()) {
        let clientID: String = "clientID"
        let clientKey: String = "clientKey"
        
        let query: String = "https://openapi.naver.com/v1/search/news.json?query=\(queryValue)"
        let encodedQuery: String = query.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
        let queryURL: URL = URL(string: encodedQuery)!
        
        var requestURL = URLRequest(url: queryURL)
        requestURL.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        requestURL.addValue(clientID, forHTTPHeaderField: "X-Naver-Client-Id")
        requestURL.addValue(clientKey, forHTTPHeaderField: "X-Naver-Client-Secret")
        
        let task = URLSession.shared.dataTask(with: requestURL) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
            }
            else if let data = data {
                let items = try? JSONDecoder().decode(SearchResult.self, from: data)
                if let items = items {
                    completion(items.items)
                }
//                print("At Model Item:\(items?.items)")
            }
        }
        task.resume()
    }
}
