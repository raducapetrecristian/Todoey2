//
//  Item.swift
//  Todoey
//
//  Created by Cristi Raduca on 29/12/2018.
//  Copyright © 2018 Cristi Raduca. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated: Date?
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
