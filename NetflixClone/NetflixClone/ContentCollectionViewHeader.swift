//
//  ContentCollectionViewHeader.swift
//  NetflixClone
//
//  Created by jiyun moon on 2022/05/19.
//

import UIKit
import SnapKit

class ContentCollectionViewHeader: UICollectionReusableView {
    
    let sectionNameLabel = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        sectionNameLabel.font = .systemFont(ofSize: 17, weight: .bold)
        sectionNameLabel.textColor = .white
        sectionNameLabel.sizeToFit()
        
        addSubview(sectionNameLabel)
        
        sectionNameLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.top.bottom.leading.equalToSuperview().offset(10)
        }
    }
}

