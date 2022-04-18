//
//  CreditCard.swift
//  CreditCardList
//
//  Created by jiyun moon on 2022/04/11.
//

import Foundation

struct CreditCard: Codable {
    let id: Int
    let rank: Int
    let name: String
    let cardImageURL: String
    let promotionDetail: PromotionDetail
    let isSelected: Bool?
}

struct PromotionDetail: Codable {
    let companyName: String
    let amount: Int
    let period: String
    let benefitCondition: String
    let benefitDate: String
    let benefitDetail: String
    let condition: String
}
