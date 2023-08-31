//
//  MusicPlayerProtocols.swift
//  Music For Enaza
//
//  Created by Vadim Igdisanov on 31.08.2023.
//

import Foundation

protocol MusicPlayerModuleInput {
    var moduleOutput: MusicPlayerModuleOutput? { get }
}

protocol MusicPlayerModuleOutput: AnyObject {
}

protocol MusicPlayerViewInput: AnyObject {
}

protocol MusicPlayerViewOutput: AnyObject {
}

protocol MusicPlayerInteractorInput: AnyObject {
}

protocol MusicPlayerInteractorOutput: AnyObject {
}

protocol MusicPlayerRouterInput: AnyObject {
}
