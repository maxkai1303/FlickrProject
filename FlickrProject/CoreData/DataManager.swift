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
    
    static let shared = FavoritesData()
    
    private init(){}
    
    // MARK: - 儲存資料
    
    func saveData(title: String, image: String) {
        
        let data = Favorites(context: appDel)
        
        data.title = title
        data.imageData = image
        
        do {
            
            try appDel.save()
            
            print("======== 資料儲存成功 ========")
            
        } catch let error {
            
            print("context can't save!, Error:\(error)")
        }
    }
    
    // MARK: - 讀取資料
    
    func fetchData() -> [Favorites] {
      
      let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityData)
      do {
        let results =
          try appDel.fetch(request) as! [Favorites]
        
        for result in results {
            
          print("===== 讀取成功：Title:\(String(describing: result.value(forKey: "title")!))image:\(result.value(forKey: "imageData")!)=======")
        }
        
        return results
        
      } catch {
        
        fatalError("啊啊啊啊啊。讀取失敗!, Error:\(error)")
      }
    }
    
}
