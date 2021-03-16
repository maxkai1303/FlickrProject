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
        
        getSearchData()
        
        
        imageCollection.refresh.footer.addRefreshClosure {
            
            self.imageCollection.refresh.footer.setTitle("loading...", for: .refreshing)
            
            if self.goPage < self.totalPage {
                
                self.goPage += 1
                
                self.getSearchData()
                
            } else if self.goPage == self.totalPage {
                
                self.imageCollection.refresh.footer.setAttributedTitle(NSAttributedString(string: "No more data.", attributes: [.foregroundColor: UIColor.red]), for: .disabled)
            }
            
            self.imageCollection.refresh.footer.endRefreshing()
        }
    }
    
    var photos = [Photo]()
    
    private var totalPage: Int = 1
    private var goPage: Int = 1
    
    func addPullRefresh() {
        
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "refresh")
        imageCollection.addSubview(refreshControl)
        
        refreshControl.addTarget(self, action: #selector(reloadData), for: UIControl.Event.valueChanged)
        
    }
    
    @objc func reloadData() {
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
            
            self.refreshControl.endRefreshing()
            
            self.photos = []
            self.goPage = 1
            
            self.getSearchData()
        }
    }
    
    func getSearchData() {
        
        NetWorkManager.getData(searchText: getSearchText, perPage: getPerPage, page: goPage) { [weak self] (reslut) in
            
            self?.photos.append(contentsOf: reslut.photos.photo)
            self?.totalPage = reslut.photos.pages
            
            self?.imageCollection.reloadData()
        }
    }
    
    var likeStatus: Status = .unlike
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        let saveImage = photos[indexPath.item]
        
        FavoritesData.shared.saveData(title: saveImage.title, image: "\(saveImage.imageUrl)")
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCollectionViewCell", for: indexPath) as! ImageCollectionViewCell
        
        switch likeStatus {
        
        case .like:
            
            likeStatus = .unlike
            cell.likeBTN.image(for: .disabled)
            
        case .unlike:
            
            likeStatus = .like
            cell.likeBTN.image(for: .selected)
        }
        
        
    }
}


