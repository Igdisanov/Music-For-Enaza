//
//  SongListContainer.swift
//  Music For Enaza
//
//  Created by Vadim Igdisanov on 30.08.2023.
//

import UIKit

final class SongListContainer {
    let input: SongListModuleInput
    let viewController: UIViewController
    private(set) weak var router: SongListRouterInput?
    
    static func assemble(with context: SongListContext) -> SongListContainer {
        let router = SongListRouter()
        let interactor = SongListInteractor()
        let presenter = SongListPresenter(router: router, interactor: interactor)
        let viewController = SongListViewController(output: presenter)
        
        presenter.view = viewController
        presenter.moduleOutput = context.moduleOutput
        
        interactor.output = presenter
        
        return SongListContainer(view: viewController, input: presenter, router: router)
    }
    
    private init(view: UIViewController, input: SongListModuleInput, router: SongListRouterInput) {
        self.viewController = view
        self.input = input
        self.router = router
    }
}

struct SongListContext {
    weak var moduleOutput: SongListModuleOutput?
}

