//
//  Network.swift
//  FlickrProject
//
//  Created by Max Kai on 2021/2/24.
//

import UIKit

class Network {
    
    public enum Error: Swift.Error {
        case connectivityError
        case invalidData
        case missingData
    }
    
    static let shared = Network()
    
    private init() {}
    
    let Session = URLSession.shared
    
    func downloadImage(url: URL, handler: @escaping (UIImage?) -> ()) {
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let data = data, let image = UIImage(data: data) {
                
                handler(image)
                
            } else {
                
                handler(nil)
            }
        }
        
        task.resume()
    }
    
    func searchApi<Item: Codable>(url: URL?, completion: @escaping (Result<Item, Network.Error>) -> Void) {
        
        let task = Session.dataTask(with: url!){ (data, response, error) in
            if let _ = error {
                
                completion(.failure(Error.connectivityError))
                
                return
            }
            
            guard let response = response as? HTTPURLResponse, let data = data else {
                
                completion(.failure(Error.missingData))
                
                return
            }
            
            if 200 ... 299 ~= response.statusCode, let searchData = try? JSONDecoder().decode(Item.self, from: data) {
                    completion(.success(searchData))
                
            } else {
                
                completion(.failure(Error.invalidData))
            }
        }
        
        task.resume()
    }

}
