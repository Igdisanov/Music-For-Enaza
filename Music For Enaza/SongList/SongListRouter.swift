//
//  SongListRouter.swift
//  Music For Enaza
//
//  Created by Vadim Igdisanov on 30.08.2023.
//

import UIKit

class SongListRouter {
}

extension SongListRouter: SongListRouterInput {
    
    func pushViewController(view: UIViewController, trackList: [Track], currentTrack: Track) {
        let context = MusicPlayerContext(trackList: trackList, currentTrack: currentTrack)
        let musicPlayerVC = MusicPlayerContainer.assemble(with: context).viewController
        view.navigationController?.pushViewController(musicPlayerVC, animated: true)
    }
}

