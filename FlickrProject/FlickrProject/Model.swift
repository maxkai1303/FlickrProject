//
//  Model.swift
//  FlickrProject
//
//  Created by Max Kai on 2021/2/24.
//

import Foundation

// MARK: - Search
struct Search: Codable {
    let photos: Photos
    let stat: String
}

// MARK: - Photos
struct Photos: Codable {
    let page, pages, perpage: Int
    let total: String
    let photo: [Photo]
}

// MARK: - Photo
struct Photo: Codable {
    let id, owner, secret, server: String
    let farm: Int
    let title: String
    let ispublic, isfriend, isfamily: Int
    
    var imageUrl: URL {
        
        return URL(string:"https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret)_m.jpg")!
    }
}

