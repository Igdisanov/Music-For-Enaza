//
//  MusicPlayerContainer.swift
//  Music For Enaza
//
//  Created by Vadim Igdisanov on 31.08.2023.
//

import UIKit

final class MusicPlayerContainer {
    let input: MusicPlayerModuleInput
    let viewController: UIViewController
    private(set) weak var router: MusicPlayerRouterInput?
    
    static func assemble(with context: MusicPlayerContext) -> MusicPlayerContainer {
        let router = MusicPlayerRouter()
        let interactor = MusicPlayerInteractor(context: context)
        let presenter = MusicPlayerPresenter(router: router, interactor: interactor)
        let viewController = MusicPlayerViewController(uotput: presenter)
        
        presenter.view = viewController
        presenter.moduleOutput = context.moduleOutput

        interactor.output = presenter

        return MusicPlayerContainer(view: viewController, input: presenter, router: router)
    }
    
    private init(view: UIViewController, input: MusicPlayerModuleInput, router: MusicPlayerRouterInput) {
        self.viewController = view
        self.input = input
        self.router = router
    }
    
}

struct MusicPlayerContext {
    weak var moduleOutput: MusicPlayerModuleOutput?
    let trackList: [Track]
    let currentTrack: Track
}
 
