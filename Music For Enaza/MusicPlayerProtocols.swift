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
    func getTrack(location: LocationTrack?, track: Track)
    func getImageData(data: Data?)
}

protocol MusicPlayerViewOutput: AnyObject {
    func requestTrack()
    func requestImage(cover: String)
    func requestNextSong()
    func requestpreviousSong()
}

protocol MusicPlayerInteractorInput: AnyObject {
    func requestTrack()
    func requestImage(cover: String)
    func requestNextSong()
    func requestpreviousSong()
}

protocol MusicPlayerInteractorOutput: AnyObject {
    func getTrack(location: LocationTrack?,track: Track)
    func getImageData(data: Data?)
}

protocol MusicPlayerRouterInput: AnyObject {
}
