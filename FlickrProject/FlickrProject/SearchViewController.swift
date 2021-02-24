//
//  SearchViewController.swift
//  FlickrProject
//
//  Created by Max Kai on 2021/2/24.
//

import UIKit

class SearchViewController: UIViewController, UICollectionViewDelegate {
    
    var getSearchText: String = ""
    var getPerPage: String = ""

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        getData(searchText: getSearchText, perPage: getPerPage)
    }
    
    var photos = [Photo]()
    
    let flickrKey = "a370d6164f42e6950ea2392a0e587ac5"
    
    @IBOutlet weak var imageCollection: UICollectionView!
    
    func getData(searchText: String, perPage: String) {
        
        let url = URL(string: "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(flickrKey)&text=\(searchText)&per_page=\(perPage)&format=json&nojsoncallback=1")
        
        print("搜尋這個ＵＲＬ：", url!)
        
        let task = URLSession.shared.dataTask(with: url!){ (data, response, error) in
            
            if let data = data, let searchData = try? JSONDecoder().decode(Search.self, from: data) {
                self.photos = searchData.photos.photo
                DispatchQueue.main.async {
                    
                    self.imageCollection.reloadData()
                }
            }
        }
        task.resume()
    }

}

extension SearchViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCollectionViewCell", for: indexPath) as! ImageCollectionViewCell
        
        let photo = photos[indexPath.item]
        
        cell.setUi(item: photo)
        
//        NetworkImage.downloadImage(url: photo.imageUrl) { (image) in
//
//            if photo.imageUrl != nil, let image = image {
//
//                DispatchQueue.main.async {
//
//                    cell.image.image = image
//                }
//            }
//        }
        
        return cell
    }
}


