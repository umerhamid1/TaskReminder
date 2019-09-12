//
//  Category.swift
//  TaskReminder
//
//  Created by umer hamid on 9/11/19.
//  Copyright © 2019 umer hamid. All rights reserved.
//

import Foundation
import RealmSwift

class Category : Object {
    let items = List<Items>()
    @objc dynamic var work : String = ""
}
