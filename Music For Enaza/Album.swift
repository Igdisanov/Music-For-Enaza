//
//  Albom.swift
//  Music For Enaza
//
//  Created by Vadim Igdisanov on 01.09.2023.
//

import Foundation

class CollectionResults: Decodable {
    let collection: Collection?
}

class Response: Decodable {
    let productId: String?
    let productChildIds: [Int]?
}

class Collection: Decodable {
    let album: [String: Album]
    let track: [String: Track]
}

class Album: Decodable {
    let name: String?
    let cover: String?
    let coverUrl: String?
}

class Track: Decodable {
    let id: String?
    let name: String?
    let cover: String?
    let coverUrl: String?
    var song: String?
}
