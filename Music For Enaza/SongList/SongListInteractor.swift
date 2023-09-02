//
//  SongListInteractor.swift
//  Music For Enaza
//
//  Created by Vadim Igdisanov on 30.08.2023.
//

import Foundation

class SongListInteractor {
    weak var output: SongListInteractorOutput?
    private let networkDataFetcher: NetworkFetcherProtocol
    private let collectionURL = "https://api.mobimusic.kz/?method=product.getCard&productId=234234"
    private var collection: Collection?
    private var songList = ["music1", "music2", "music3", "music4", "music5", "music6"]
    
    init() {
        self.networkDataFetcher = NetworkDataFetcher()
    }
}

extension SongListInteractor: SongListInteractorInput {
    
    func collectionRequest(completion: @escaping (Collection?) -> ()) {
        guard let url = URL(string: collectionURL) else { return }
        self.networkDataFetcher.fetchAlbom(url: url) { [weak self] (collectionResults) in
            guard let self = self else {return}
            guard let collectionResults = collectionResults as? CollectionResults, let collection = collectionResults.collection else {return}
            var index = 0
            for (_, value) in collection.track {
                value.song = self.songList[index]
                index += 1
            }
            self.collection = collection
            
            completion(collection)
        }
    }
    
    func imageAlbumRerquest(completion: @escaping (Data?) -> ()) {
        guard let coverUrlString = self.collection?.album.first?.value.coverUrl else {return}
        self.networkDataFetcher.fetchImage(cover: coverUrlString) { (data) in
            guard let data = data as? Data else {return}
            completion(data)
        }
    }
}

