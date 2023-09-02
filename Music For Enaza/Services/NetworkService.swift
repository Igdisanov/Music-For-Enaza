//
//  NetworkService.swift
//  Music For Enaza
//
//  Created by Vadim Igdisanov on 01.09.2023.
//

import Foundation

protocol NetworkFetcherProtocol {
    func fetchAlbom(url: URL?, completion: @escaping (Any?) -> ())
    func fetchImage(cover: String, completion: @escaping (Any?) -> ())
}

final class NetworkDataFetcher: NetworkFetcherProtocol {
    
    func fetchAlbom(url: URL?, completion: @escaping (Any?) -> ()) {
        
        request(url: url) { (data, request, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
            }
            let decode = self.decodeJSON(type: CollectionResults.self, from: data)
            completion(decode)
            
        }
    }
    
    func fetchImage(cover: String, completion: @escaping (Any?) -> ()) {
        let urlString = cover
        guard let url = URL(string: urlString) else {return}
        request(url: url) { (data, request, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
            }
            completion(data)
        }
    }
    
    func request(url: URL?, completion: @escaping (Data?, URLResponse?, Error?)-> Void) {
        guard let url = url else { return }
        return URLSession.shared.dataTask(with: url) { (data, responce, error) in
            DispatchQueue.main.async {
                completion(data, responce, error)
            }
        }.resume()
    }
    
    func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        
        guard let data = from else {return nil}
        
        do {
            let objects = try decoder.decode(type.self, from: data)
            return objects
        } catch let jsonError {
            print("JSONE", jsonError)
            return nil
        }
    }
}
