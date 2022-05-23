//
//  Content.swift
//  NetflixClone
//
//  Created by jiyun moon on 2022/05/19.
//

import Foundation
import UIKit

struct Content: Decodable {
    
    let sectionType: SectionType
    let sectionName: String
    let contentItem: [Item]
    
    // type 을 enum 으로 선언해줘서 좀 더 보기 편하게 sectionType 에 String 으로 전달 가능
    enum SectionType: String, Decodable {
        case basic
        case main
        case large
        case rank
    }
    
}

struct Item: Decodable {
    let description: String
    let imageName: String
    
    var image: UIImage {
        return UIImage(named: imageName) ?? UIImage()
    }
}
