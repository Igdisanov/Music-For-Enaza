//
//  MusicPlayerInteractor.swift
//  Music For Enaza
//
//  Created by Vadim Igdisanov on 31.08.2023.
//

import Foundation

enum LocationTrack {
    case first
    case last
}

class MusicPlayerInteractor {
    
    weak var output: MusicPlayerInteractorOutput?
    
    private let networkDataFetcher: NetworkFetcherProtocol
    private let trackList: [Track]?
    private var currentTrack: Track?
    private var currentTrackIndex: Int?
    
    init(context: MusicPlayerContext?) {
        self.trackList = context?.trackList
        self.currentTrack = context?.currentTrack
        self.networkDataFetcher = NetworkDataFetcher()
        
        guard let trackList = self.trackList else {return}
        for (index, value) in trackList.enumerated() {
            if currentTrack?.id == value.id {
                self.currentTrackIndex = index
            }
        }
    }
}

extension MusicPlayerInteractor: MusicPlayerInteractorInput {
    
    func requestImage(cover: String) {
        networkDataFetcher.fetchImage(cover: cover) { [weak self] (data) in
            guard let data = data as? Data else {return}
            self?.output?.getImageData(data: data)
        }
    }
    
    func requestTrack() {
        guard let currentTrack = self.currentTrack else {return}
        let location = getLocation()
        output?.getTrack(location: location,track: currentTrack)
    }
    
    func requestNextSong() {
        guard let trackList = self.trackList, let index = currentTrackIndex else {return}
        if index != trackList.count - 1 {
            let currentIndex = index + 1
            self.currentTrackIndex = currentIndex
            self.currentTrack = trackList[currentIndex]
            let location = getLocation()
            self.output?.getTrack(location: location,track: trackList[currentIndex])
        }
    }
    
    func requestpreviousSong() {
        guard let trackList = self.trackList, let index = currentTrackIndex else {return}
        if index != 0 {
            let currentIndex = index - 1
            self.currentTrackIndex = currentIndex
            self.currentTrack = trackList[currentIndex]
            let location = getLocation()
            self.output?.getTrack(location: location,track: trackList[currentIndex])
        }
    }
    
    private func getLocation() -> LocationTrack? {
        guard let trackList = self.trackList, let currentTrack = self.currentTrack else {return nil}
        if currentTrack.id == trackList.first?.id {
            return LocationTrack.first
        } else if currentTrack.id == trackList.last?.id {
            return LocationTrack.last
        } else {
            return nil
        }
    }
}
