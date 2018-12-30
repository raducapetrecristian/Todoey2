//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Cristi Raduca on 29/12/2018.
//  Copyright © 2018 Cristi Raduca. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {
    let realm = try! Realm()
    var categories : Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
    }
    
    //MARK: - TableView DataSource methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell  {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No categories added yet"
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
                    let newCategory = Category()
                    newCategory.name = textField.text!
                    self.save(category: newCategory)
                }
            }
            
            alert.addAction(action)
            present(alert, animated: true)
    }
    
    //MARK: - Data manipulation
    func save(category: Category){
        do{
            try realm.write {
                realm.add(category)
            }
        }
        catch{
            print("Error saving category context \(error)")
        }
        
        tableView.reloadData()
    }
    
    func loadCategories(){
        categories = realm.objects(Category.self)
        tableView.reloadData()
    }
    
    //MARK: - TableView Delegate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }
    
    
}
