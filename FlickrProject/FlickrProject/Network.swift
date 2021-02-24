//
//  Network.swift
//  FlickrProject
//
//  Created by Max Kai on 2021/2/24.
//

import UIKit

struct NetworkImage {
    
    static func downloadImage(url: URL, handler: @escaping (UIImage?) -> ()) {
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let data = data, let image = UIImage(data: data) {
                
                handler(image)
                
            } else {
                
                handler(nil)
            }
        }
        
        task.resume()
    }
}
