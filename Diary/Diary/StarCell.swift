//
//  StarCell.swift
//  Diary
//
//  Created by jiyun moon on 2021/11/27.
//

import UIKit

class StarCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.contentView.layer.cornerRadius = 3.0
        self.contentView.layer.borderWidth = 2.0
        self.contentView.layer.borderColor = UIColor.black.cgColor
    }
}
