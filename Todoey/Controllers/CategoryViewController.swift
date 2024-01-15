//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Toy on 12/21/23.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import UIKit
import CoreData

final class CategoryViewController: UITableViewController {
    
    private var categories = [Category]()
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()

        loadCategories()
    }

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { _ in
            
            let newCategory = Category(context: self.context)
            newCategory.name = textField.text!
            
            self.categories.append(newCategory)
            
            self.saveCategories()
        }
        
        alert.addTextField { field in
            field.placeholder = "Create new Category"
            textField = field
        }
        
        alert.addAction(action)
        
        present(alert, animated: true)
    }
    
    private func saveCategories() {
        do {
            try context.save()
        } catch {
            print(error)
        }
        
        self.tableView.reloadData()
    }
    
    private func loadCategories() {
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        
        do {
            categories = try context.fetch(request)
        } catch {
            print(error)
        }
        
        self.tableView.reloadData()
    }

}

extension CategoryViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        
        content.text = categories[indexPath.row].name
        
        cell.contentConfiguration = content
        
        return cell
    }
    
}

extension CategoryViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? TodoListViewController else { return }
        
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        
        destinationVC.selectedCategory = categories[indexPath.row]
    }
    
}
