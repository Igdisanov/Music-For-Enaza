//
//  SongListProtocols.swift
//  Music For Enaza
//
//  Created by Vadim Igdisanov on 30.08.2023.
//

import Foundation

protocol SongListModuleInput {
    var moduleOutput: SongListModuleOutput? { get }
}

protocol SongListModuleOutput: AnyObject {
}

protocol SongListViewInput: AnyObject {
}

protocol SongListViewOutput: AnyObject {
}

protocol SongListInteractorInput: AnyObject {
}

protocol SongListInteractorOutput: AnyObject {
}

protocol SongListRouterInput: AnyObject {
}
