//
//  ViewController.swift
//  Todoey
//
//  Created by Cristi Raduca on 25/12/2018.
//  Copyright © 2018 Cristi Raduca. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    var itemArray = ["Find Mike", "ceva", "Altceva"]
    
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        if let items = defaults.array(forKey: "ToDoListItemArray") as? [String] {
            itemArray = items
        }
    }

    //MARK: - TableView Data Source methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        cell.accessoryType = .none
        return cell
    }
    
    //MARK: - TableView Delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark
        {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        else
        {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: - Add new items
    
    @IBAction func AddButtonPressed(_ sender: UIBarButtonItem) {
    
        var textField = UITextField()
        let alert = UIAlertController(title: "Add a new item", message: "", preferredStyle: .alert)
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Type here"
            textField = alertTextField
        }
        
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            //What will happen when the user press the Add item
            if textField.text != nil{
                self.itemArray.append(textField.text!)
                self.defaults.set(self.itemArray, forKey: "ToDoListItemArray")
                self.tableView.reloadData()
            }
        }
       
        alert.addAction(action)
        present(alert, animated: true) {
            
        }
    }
}
