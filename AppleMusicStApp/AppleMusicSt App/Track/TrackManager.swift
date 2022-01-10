//
//  TrackManager.swift
//  AppleMusicSt App
//
//  Created by jiyun moon on 2022/01/09.
//

import UIKit
import AVFoundation

class TrackManager {
    
    var currentIndex: Int = 0
    var tracks: [AVPlayerItem] = []
    var albums: [Album] = []
    
    var todaysTrack: AVPlayerItem?
    
    init() {
        let tracks = loadTracks()
        self.tracks = tracks
        self.albums = loadAlbums(tracks: tracks)
        self.todaysTrack = self.tracks.randomElement()
    }
    
    func loadAlbums(tracks: [AVPlayerItem]) -> [Album] {
        let trackList = tracks.compactMap { $0.convertToTrack() }
        let albumDics = Dictionary(grouping: trackList, by: { track in  track.albumName })
        var albums: [Album] = []
        for (key, value) in albumDics {
            let title = key
            let tracks = value
            let album = Album(title: title, tracks: tracks)
            albums.append(album)
        }
        return albums
    }
    
    func loadTracks() -> [AVPlayerItem] {
        let urls = Bundle.main.urls(forResourcesWithExtension: "mp3", subdirectory: nil) ?? []
        let tracks = urls.map { AVPlayerItem(url: $0) }
        return tracks
    }
    
    func track(at index: Int) -> Track? {
        return tracks[index].convertToTrack()
    }
    
    func loadOtherTodaysTrack() {
        self.todaysTrack = self.tracks.randomElement()
    }
    
    func getNextItem() -> AVPlayerItem? {
        guard currentIndex < tracks.count else { return nil }
        currentIndex += 1
        return tracks[currentIndex]
    }
    
    func getPrevItem() -> AVPlayerItem? {
        guard currentIndex > 0 else { return nil }
        currentIndex -= 1
        return tracks[currentIndex]
    }
}
