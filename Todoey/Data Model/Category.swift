//
//  Category.swift
//  Todoey
//
//  Created by Nova on 1/17/24.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import Foundation
import RealmSwift

final class Category: Object {
    @objc dynamic var name: String = ""
    let items = List<Item>()
}
