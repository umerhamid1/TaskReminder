//
//  Items.swift
//  TaskReminder
//
//  Created by umer hamid on 9/11/19.
//  Copyright © 2019 umer hamid. All rights reserved.
//

import Foundation
import RealmSwift

class Items : Object {
    
    @objc dynamic var done : Bool = false
    @objc dynamic var task : String = ""
    @objc dynamic var createDate : Date?
    
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
    
    
}
