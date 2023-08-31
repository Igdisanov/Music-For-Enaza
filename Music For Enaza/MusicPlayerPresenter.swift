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
    
}

extension MusicPlayerPresenter: MusicPlayerInteractorOutput {
    
}
