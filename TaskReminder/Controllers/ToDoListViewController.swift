//
//  ViewController.swift
//  TaskReminder
//
//  Created by umer hamid on 8/25/19.
//  Copyright © 2019 umer hamid. All rights reserved.
//

import UIKit
//import CoreData
import RealmSwift
class ToDoListViewController: UITableViewController  {

    let realm = try! Realm()
 
    
    
    var task : Results<Items>?
    // let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
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
        
        
        return task?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoListCell", for: indexPath)
        
       if let i = task?[indexPath.row] {
            cell.textLabel?.text = i.task
            cell.accessoryType = i.done ? .checkmark : .none
       }else{
            cell.textLabel?.text = "no Data Added"
        }
        //?? "daata is not added"
       // cell.textLabel?.text = task[cell]
        
      //1  tableView.reloadData()
        
//        if task[indexPath.row].done == true{
//            cell.accessoryType = .checkmark
//        }else{
//            cell.accessoryType = .none
//
//        }
        
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if let task = task?[indexPath.row]{
            do{
                try realm.write {
                    //realm.delete(task) for delete data
                    task.done = !task.done
            }
            }catch{
                print("error while saving done \(error)")
            }
        }
        
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
       // task[indexPath.row].done = !task[indexPath.row].done
       // saveData()
        
      tableView.reloadData()
        
        
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
            if let select = self.selectCategory{
                do{
                    try self.realm.write {
                        let i = Items()
                        i.task = data.text!
                        i.done = false
                        i.createDate = Date()
                        select.items.append(i)
                    }
                }catch{
                    print("error during save data in Items : \(error)")
                }
            }
           
           // i.parentsCategory = self.selectCategory
          //  self.task.append(i)
            //self.def.set(self.task, forKey: "ToDoList")
            
            self.tableView.reloadData()
            
        }

       
        
        
        alert.addTextField { (textData) in
            textData.placeholder = "Add New Items"
            data = textData
        }
        
        
        alert.addAction(alertAction)
        
        present(alert, animated: true,  completion: nil)
        
        tableView.reloadData()
        
    }
    
    func saveData(items : Items){
        do{
           try realm.write {
            
                realm.add(items)
            }
        }catch{
            print("encoding error : \(error)")
        }
        tableView.reloadData()
    }
    
    func loadData(){

        
        task = selectCategory?.items.sorted(byKeyPath: "task", ascending: true)
        
       // let fetchData : NSFetchRequest<Items> = Items.fetchRequest()

//        let data = NSPredicate(format: "parentsCategory.work MATCHES %@",  selectCategory!.work!)

//
//        if let compoundPrediate = predicate {
//            fetchData.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [data, compoundPrediate])
//        }else{
//            fetchData.predicate = data
//        }


        //fetchData.predicate = data

//            do{
//              task =  try context.fetch(fetchData)
//            }
//            catch{
//                print("ERROR DURING LOADING : \(error)")
//            }

        tableView.reloadData()
        }

    
}

extension ToDoListViewController : UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        task = task?.filter("task CONTAINS[cd] %@", searchBar.text! ).sorted(byKeyPath: "createDate", ascending: true)
        
        //let fetchdata : NSFetchRequest<Items> = Items.fetchRequest()

        //let predicate = NSPredicate(format: "task CONTAINS[cd] %@", searchBar.text!)



        //fetchdata.sortDescriptors = [NSSortDescriptor(key: "task", ascending: true)]

        //loadData(with : fetchdata , predicate: predicate)



//        do{
//            task =  try context.fetch(fetchdata)
//        }
//        catch{
//            print("ERROR DURING LOADING : \(error)")
//        }
//
       tableView.reloadData()





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
