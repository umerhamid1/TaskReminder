//
//  CategoryViewController.swift
//  TaskReminder
//
//  Created by umer hamid on 9/8/19.
//  Copyright © 2019 umer hamid. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loadData()
    }
    
    var array = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       // return array[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
        
       
        
        cell.textLabel?.text = array[indexPath.row].work
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "showList1", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showList1"{
            
            let categoryVC = segue.destination as! ToDoListViewController
            
            if let indexpath = tableView.indexPathForSelectedRow{
                categoryVC.selectCategory = array[indexpath.row]

            }
            
            
            
        }
    }
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        
        var textData = UITextField()
        
        let alert = UIAlertController(title: "Add", message: "add Category", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (UIAlertAction) in
            
            let cate = Category(context: self.context)
            cate.work = textData.text!
            self.array.append(cate)
            
            
            self.saveData()
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
    func saveData(){
        
        do{
            try self.context.save()
            print("saved Data")
        }catch{
            print("encoding error : \(error)")
        }
        
        self.tableView.reloadData()
    }

    func loadData(){
      
        let fetchData : NSFetchRequest<Category> = Category.fetchRequest()
        do {
          array =   try context.fetch(fetchData)
        }catch{
            print("error during retrieving data : \(error)")
        }
        tableView.reloadData()
    }
}
