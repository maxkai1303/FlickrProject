//
//  SearchViewController.swift
//  FlickrProject
//
//  Created by Max Kai on 2021/2/24.
//

import UIKit
import EasyRefresher

class SearchViewController: UIViewController, UICollectionViewDelegate {
    
    var getSearchText: String = ""
    var getPerPage: String = ""
    
    var refreshControl:UIRefreshControl!
    
    @IBOutlet weak var imageCollection: UICollectionView!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        addPullRefresh()
        
        getData(searchText: getSearchText, perPage: getPerPage, page: goPage)
        
        
        imageCollection.refresh.footer.addRefreshClosure {
            
            self.imageCollection.refresh.footer.setTitle("loading...", for: .refreshing)
            
            if self.goPage < self.totalPage {
                
                self.goPage += 1
                
                self.getData(searchText: self.getSearchText, perPage: self.getPerPage, page: self.goPage)
                
            } else if self.goPage == self.totalPage {
                
                self.imageCollection.refresh.footer.setAttributedTitle(NSAttributedString(string: "No more data.", attributes: [.foregroundColor: UIColor.red]), for: .disabled)
            }
            
            self.imageCollection.refresh.footer.endRefreshing()
        }
    }
    
    var photos = [Photo]()
    
    let flickrKey = "a370d6164f42e6950ea2392a0e587ac5"
    
    private var totalPage: Int = 1
    private var goPage: Int = 1
    
    func addPullRefresh() {
        
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "refresh")
        imageCollection.addSubview(refreshControl)
        
        refreshControl.addTarget(self, action: #selector(reloadData), for: UIControl.Event.valueChanged)
        
    }
    
    
    func getData(searchText: String, perPage: String, page: Int) {
        
        let url = URL(string: "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(flickrKey)&text=\(searchText)&per_page=\(perPage)&format=json&nojsoncallback=1&page=\(page)")
        
        print("搜尋這個ＵＲＬ：", url!)
        
        let task = URLSession.shared.dataTask(with: url!){ (data, response, error) in
            
            if let data = data, let searchData = try? JSONDecoder().decode(Search.self, from: data) {
                
                self.photos.append(contentsOf: searchData.photos.photo)
                self.totalPage = searchData.photos.pages
                
                DispatchQueue.main.async {
                    
                    self.imageCollection.reloadData()
                }
            }
        }
        task.resume()
    }
    
    @objc func reloadData() {
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
            
            self.refreshControl.endRefreshing()
            
            self.photos = []
            self.goPage = 1
            
            self.getData(searchText: self.getSearchText, perPage: self.getPerPage, page: self.goPage)
        }
    }
    
    @IBAction func likeBTN(_ sender: Any) {
        
        
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
        
        return cell
    }
}

/*
 API還沒回來重新建構 collectionView photos out of range
 */
