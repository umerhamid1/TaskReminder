//
//  CategoryViewController.swift
//  TaskReminder
//
//  Created by umer hamid on 9/8/19.
//  Copyright © 2019 umer hamid. All rights reserved.
//

import UIKit
//import CoreData
import RealmSwift

class CategoryViewController: UITableViewController {

    let realm = try! Realm()
    var array : Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loadData()
    }
    
   
    //let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       // return array[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
        
       
        
        cell.textLabel?.text = array?[indexPath.row].work ?? "no Category is added"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "showList1", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showList1"{
            
            let categoryVC = segue.destination as! ToDoListViewController
            
            if let indexpath = tableView.indexPathForSelectedRow{
                categoryVC.selectCategory = array?[indexpath.row]

            }
            
            
            
        }
    }
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        
        var textData = UITextField()
        
        let alert = UIAlertController(title: "Add", message: "add Category", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (UIAlertAction) in
            
            let cate = Category()
            cate.work = textData.text!
            //self.array.append(cate)
            
            
            self.save(category : cate)
        }
        
        alert.addTextField { (UITextField) in
            UITextField.placeholder = "Add Category"
            textData = UITextField
        }
        
        alert.addAction(action)
        
        present(alert , animated: true , completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func save(category : Category){
        
        do{
            
           try realm.write {
                realm.add(category)
            }
        }catch{
            print("error during add realm data: \(error)")
        }
        
        self.tableView.reloadData()
    }

    func loadData(){
      
//        let fetchData : NSFetchRequest<Category> = Category.fetchRequest()
//        do {
//          array =   try context.fetch(fetchData)
//        }catch{
//            print("error during retrieving data : \(error)")
//        }
        
        array = realm.objects(Category.self)
         tableView.reloadData()
    }
}
