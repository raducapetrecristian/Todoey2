//
//  ViewController.swift
//  Todoey
//
//  Created by Cristi Raduca on 25/12/2018.
//  Copyright © 2018 Cristi Raduca. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem1 = Item()
        newItem1.name = "Natasa"
        itemArray.append(newItem1)
        
        let newItem2 = Item()
        newItem2.name = "Francesca"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.name = "Roberta"
        itemArray.append(newItem3)
        
        if let items = defaults.array(forKey: "ToDoListItemArray") as? [Item] {
            itemArray = items
        }
    }

    //MARK: - TableView Data Source methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row].name
        cell.accessoryType = .none
        if itemArray[indexPath.row].done == true{
            cell.accessoryType = .checkmark
        }
        else
        {
            cell.accessoryType = .none
        }
        return cell
    }
    
    //MARK: - TableView Delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        tableView.reloadData()
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
                let newItem = Item()
                newItem.name = textField.text!
                self.itemArray.append(newItem)
                self.defaults.set(self.itemArray, forKey: "ToDoListItemArray")
                self.tableView.reloadData()
            }
        }
       
        alert.addAction(action)
        present(alert, animated: true) {
            
        }
    }
}
