//
//  ImageCollectionViewCell.swift
//  FlickrProject
//
//  Created by Max Kai on 2021/2/24.
//

import UIKit
import Kingfisher

class ImageCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var imageTitle: UILabel!
    
    @IBOutlet weak var likeBTN: UIButton!
    
    
    func setUi(item: Photo) {
        
        imageTitle.text = item.title
        image.kf.setImage(with: item.imageUrl)
    }
    
}
