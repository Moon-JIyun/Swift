//
//  TrackCollectionHeaderView.swift
//  AppleMusicSt App
//
//  Created by jiyun moon on 2022/01/09.
//


import UIKit
import AVFoundation

class TrackCollectionHeaderView: UICollectionReusableView {
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var item: AVPlayerItem?
    var tapHandler: ((AVPlayerItem) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        thumbnailImageView.layer.cornerRadius = 4
    }
    
    func update(with item: AVPlayerItem) {
        self.item = item
        
        guard let track = item.convertToTrack() else { return }
        
        self.thumbnailImageView.image = track.artwork
        self.descriptionLabel.text = "Today's pick is \(track.artist)'s album - \(track.albumName), Let's listen."
    }
    
    @IBAction func cardTapped(_ sender: UIButton) {
        guard let todaysItem = item else { return }
        tapHandler?(todaysItem)
    }
}
