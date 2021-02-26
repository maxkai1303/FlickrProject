//
//  DataManager.swift
//  FlickrProject
//
//  Created by Max Kai on 2021/2/26.
//

import Foundation
import UIKit
import CoreData

class FavoritesData {
    
    let appDel = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let entityData = "Favorites"
}
