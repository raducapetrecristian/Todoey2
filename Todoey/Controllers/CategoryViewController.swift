//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Cristi Raduca on 29/12/2018.
//  Copyright © 2018 Cristi Raduca. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {

    var categoryArray = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadItems()
    }
    
    //MARK: - TableView DataSource methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell  {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = categoryArray[indexPath.row].name
        return cell
    }
    
    
    //MARK: - Add a new category
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
            var textField = UITextField()
            let alert = UIAlertController(title: "Add a new category", message: "", preferredStyle: .alert)
            
            alert.addTextField { (alertTextField) in
                alertTextField.placeholder = "Add a new category"
                textField = alertTextField
            }
            
            let action = UIAlertAction(title: "Add category", style: .default) { (action) in
                //What will happen when the user press the Add item
                if textField.text != nil{
                    let newCategory = Category(context: self.context)
                    newCategory.name = textField.text
                    self.categoryArray.append(newCategory)
                    self.saveCategories()
                }
            }
            
            alert.addAction(action)
            present(alert, animated: true)
    }
    
    //MARK: - Data manipulation
    func saveCategories(){
        do{
            try context.save()
        }
        catch{
            print("Error saving category context \(error)")
        }
        
        tableView.reloadData()
    }
    
    func loadItems(with request : NSFetchRequest<Category> = Category.fetchRequest()){
        do{
            categoryArray = try context.fetch(request)
        }
        catch {
            print("Error fetching data from category context \(error)")
        }
        tableView.reloadData()
    }
    
    //MARK: - TableView Delegate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categoryArray[indexPath.row]
        }
    }
    
    
}
