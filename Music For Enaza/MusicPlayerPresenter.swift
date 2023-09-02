//
//  MusicPlayerPresenter.swift
//  Music For Enaza
//
//  Created by Vadim Igdisanov on 31.08.2023.
//

import Foundation

class MusicPlayerPresenter {
    
    weak var view: MusicPlayerViewInput?
    weak var moduleOutput: MusicPlayerModuleOutput?
    
    private let router: MusicPlayerRouterInput
    private let interactor: MusicPlayerInteractorInput
    
    init(router: MusicPlayerRouterInput, interactor: MusicPlayerInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension MusicPlayerPresenter: MusicPlayerModuleInput {
    
}

extension MusicPlayerPresenter: MusicPlayerViewOutput {
    
    func requestImage(cover: String) {
        interactor.requestImage(cover: cover)
    }
    
    func requestTrack() {
        interactor.requestTrack()
    }
    
    func requestNextSong() {
        interactor.requestNextSong()
    }
    
    func requestpreviousSong() {
        interactor.requestpreviousSong()
    }
    
}

extension MusicPlayerPresenter: MusicPlayerInteractorOutput {
    
    func getImageData(data: Data?) {
        view?.getImageData(data: data)
    }
    
    func getTrack(location: LocationTrack?, track: Track) {
        view?.getTrack(location: location, track: track)
    }
}
