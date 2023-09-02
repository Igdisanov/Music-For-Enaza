//
//  SongListProtocols.swift
//  Music For Enaza
//
//  Created by Vadim Igdisanov on 30.08.2023.
//

import UIKit

protocol SongListModuleInput {
    var moduleOutput: SongListModuleOutput? { get }
}

protocol SongListModuleOutput: AnyObject {
}

protocol SongListViewInput: AnyObject {
}

protocol SongListViewOutput: AnyObject {
    func collectionRequest(completion: @escaping (Collection?) -> ())
    func getImageAlbum(completion: @escaping (Data?) -> ())
    func pushViewController(view: UIViewController, trackList: [Track], currentTrack: Track)
}

protocol SongListInteractorInput: AnyObject {
    func collectionRequest(completion: @escaping (Collection?) -> ())
    func imageAlbumRerquest(completion: @escaping (Data?) -> ())
}

protocol SongListInteractorOutput: AnyObject {
}

protocol SongListRouterInput: AnyObject {
    func pushViewController(view: UIViewController, trackList: [Track], currentTrack: Track)
}
