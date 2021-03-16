//
//  NetWorkManager.swift
//  FlickrProject
//
//  Created by Max Kai on 2021/3/16.
//

import Foundation

class NetWorkManager {
    
    private static let flickrKey = "a370d6164f42e6950ea2392a0e587ac5"
    
    static func getData(searchText: String, perPage: String, page: Int, completion: @escaping(Search) -> Void) {
        
        let url = URL(string: "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(flickrKey)&text=\(searchText)&per_page=\(perPage)&format=json&nojsoncallback=1&page=\(page)")
        
        
        Network.shared.searchApi(url: url) { (result: Result<Search, Network.Error>) in
            
            DispatchQueue.main.async {
                
                switch result {
                
                case let .success(searchData):
                    
                    completion(searchData)
                    
                case .failure(.connectivityError):
                    
                    break
                    
                case .failure(.invalidData):
                    
                    break
                    
                case .failure(.missingData):
                    
                    break
                }
            }
        }
    }
}
