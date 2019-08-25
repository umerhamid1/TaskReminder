//
//  ViewController.swift
//  TaskReminder
//
//  Created by umer hamid on 8/25/19.
//  Copyright © 2019 umer hamid. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    let task = ["play Game","watching Movie","IOS practise"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return task.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoListCell", for: indexPath)
        
       // cell.textLabel?.text = task[cell]
        cell.textLabel?.text = task[indexPath.row]
        return cell
    }


}

