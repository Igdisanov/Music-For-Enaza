//
//  SongListPresenter.swift
//  Music For Enaza
//
//  Created by Vadim Igdisanov on 30.08.2023.
//

import Foundation

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
    
}

extension SongListPresenter: SongListInteractorOutput {
    
}
