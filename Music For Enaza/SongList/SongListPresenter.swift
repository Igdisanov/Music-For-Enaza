//
//  SongListPresenter.swift
//  Music For Enaza
//
//  Created by Vadim Igdisanov on 30.08.2023.
//

import UIKit

class SongListPresenter {
    
    weak var view: SongListViewInput?
    weak var moduleOutput: SongListModuleOutput?
    
    private let router: SongListRouterInput
    private let interactor: SongListInteractorInput
    
    init(router: SongListRouterInput, interactor: SongListInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
    
}

extension SongListPresenter: SongListModuleInput {
    
}

extension SongListPresenter: SongListViewOutput {
    
    func collectionRequest(completion: @escaping (Collection?) -> ()) {
        interactor.collectionRequest { collection in
            guard let collection = collection else { return }
            completion(collection)
        }
    }
    
    func getImageAlbum(completion: @escaping (Data?) -> ()) {
        interactor.imageAlbumRerquest { (data) in
            completion(data)
        }
    }
    
    func pushViewController(view: UIViewController, trackList: [Track], currentTrack: Track) {
        router.pushViewController(view: view, trackList: trackList, currentTrack: currentTrack)
    }
}

extension SongListPresenter: SongListInteractorOutput {
    
}
