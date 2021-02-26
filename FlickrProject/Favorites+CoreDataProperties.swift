//
//  Favorites+CoreDataProperties.swift
//  FlickrProject
//
//  Created by Max Kai on 2021/2/26.
//
//

import Foundation
import CoreData


extension Favorites {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favorites> {
        return NSFetchRequest<Favorites>(entityName: "Favorites")
    }

    @NSManaged public var imageData: Data?
    @NSManaged public var title: String?

}

extension Favorites : Identifiable {

}
