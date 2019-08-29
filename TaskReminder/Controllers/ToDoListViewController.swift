//
//  ViewController.swift
//  TaskReminder
//
//  Created by umer hamid on 8/25/19.
//  Copyright © 2019 umer hamid. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    var task = [Items]()
    
    let def = UserDefaults.standard
    
    let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Item.plist")
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let item = Items()
        item.item = "watching Movie"
        task.append(item)
        
//        if let i =  def.array(forKey: "ToDoList") as? [Items] {
//            task = i
//        }
        loadData()
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return task.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoListCell", for: indexPath)
        
        let i = task[indexPath.row]
       // cell.textLabel?.text = task[cell]
        cell.textLabel?.text = i.item
      //1  tableView.reloadData()
        
//        if task[indexPath.row].done == true{
//            cell.accessoryType = .checkmark
//        }else{
//            cell.accessoryType = .none
//
//        }
        cell.accessoryType = i.done ? .checkmark : .none
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(task[indexPath.row])
//
//     if   task[indexPath.row].done == true {
//            task[indexPath.row].done = false
//     }else{
//        task[indexPath.row].done = true
//        }
        
        
        task[indexPath.row].done = !task[indexPath.row].done
        saveData()
        
        //tableView.reloadData()
        
        
//        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//        }else{
//            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }

    @IBAction func buttonPressed(_ sender: UIBarButtonItem) {
        
        var data = UITextField()
        let alert = UIAlertController(title: "Add Item", message: "", preferredStyle: .alert)
        
        
       // let alertAction = UIAlertAction(title: "Add", style: .default, handler: )
        let alertAction = UIAlertAction(title: "Add", style: .default) { (UIAlertAction) in
            let i = Items()
            i.item = data.text!
            self.task.append(i)
            //self.def.set(self.task, forKey: "ToDoList")
            
          self.saveData()
        }

       
        
        
        alert.addTextField { (textData) in
            textData.placeholder = "Add New Items"
            data = textData
        }
        
        
        alert.addAction(alertAction)
        
        present(alert, animated: true,  completion: nil)
        
        tableView.reloadData()
        
    }
    
    func saveData(){
        let encoder = PropertyListEncoder()
        do{
            let data = try encoder.encode(task)
            try data.write(to: path!)
        }catch{
            print("encoding error : \(error)")
        }
        tableView.reloadData()
    }
    
    func loadData(){
        
        if let data = try? Data(contentsOf: path!){
            let decoder = PropertyListDecoder()
            do{
                
                task =  try decoder.decode([Items].self, from: data)
            }catch {
                print("decoding error : \(error)")
            }
        }
        
        
    }
    
}

