//
//  Category.swift
//  Todoey
//
//  Created by Cristi Raduca on 29/12/2018.
//  Copyright © 2018 Cristi Raduca. All rights reserved.
//

import Foundation
import RealmSwift

class Category : Object {
    @objc dynamic var name : String = ""
    let items = List<Item>()
}
