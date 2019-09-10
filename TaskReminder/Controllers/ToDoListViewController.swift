//
//  ViewController.swift
//  TaskReminder
//
//  Created by umer hamid on 8/25/19.
//  Copyright © 2019 umer hamid. All rights reserved.
//

import UIKit
import CoreData

class ToDoListViewController: UITableViewController  {

    
 
    
    
    var task = [Items]()
     let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var selectCategory : Category? {
        didSet{
            
            loadData()
            

        }
    }
    
  //  let def = UserDefaults.standard
    
  //  let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Item.plist")
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
       
        
//        if let i =  def.array(forKey: "ToDoList") as? [Items] {
//            task = i
//        }
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return task.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoListCell", for: indexPath)
        
        let i = task[indexPath.row]
       // cell.textLabel?.text = task[cell]
        cell.textLabel?.text = i.task
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
        
      //  task[indexPath.row].setValue("completed", forKey: "done") // update  data
      //  context.delete(task[indexPath.row]) // delete item in database
      //  task.remove(at: indexPath.row) // deleete item from temporary area
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
            
           
            let i = Items(context: self.context)
            i.task = data.text!
            i.done = false
            i.parentsCategory = self.selectCategory
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
        do{
           try self.context.save()
        }catch{
            print("encoding error : \(error)")
        }
        tableView.reloadData()
    }
    
    func loadData(with fetchData : NSFetchRequest<Items> = Items.fetchRequest() , predicate : NSPredicate? = nil){

       // let fetchData : NSFetchRequest<Items> = Items.fetchRequest()
        
        let data = NSPredicate(format: "parentsCategory.work MATCHES %@",  selectCategory!.work!)
        
        
        if let compoundPrediate = predicate {
            fetchData.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [data, compoundPrediate])
        }else{
            fetchData.predicate = data
        }
        
        
        //fetchData.predicate = data
        
            do{
              task =  try context.fetch(fetchData)
            }
            catch{
                print("ERROR DURING LOADING : \(error)")
            }
        
        tableView.reloadData()
        }
    
        
}

extension ToDoListViewController : UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let fetchdata : NSFetchRequest<Items> = Items.fetchRequest()
        
        let predicate = NSPredicate(format: "task CONTAINS[cd] %@", searchBar.text!)
        
        
        
        fetchdata.sortDescriptors = [NSSortDescriptor(key: "task", ascending: true)]
        
        loadData(with : fetchdata , predicate: predicate)
        

        
//        do{
//            task =  try context.fetch(fetchdata)
//        }
//        catch{
//            print("ERROR DURING LOADING : \(error)")
//        }
//
//        tableView.reloadData()
        
        
        
        
        
        // print(searchBar.text!)
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
       if searchBar.text!.count == 0 {
        
        loadData()
        
        DispatchQueue.main.async {
            searchBar.resignFirstResponder()
        }
        
        
        
        }
    }
    
}
