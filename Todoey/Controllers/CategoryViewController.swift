//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Nova on 1/17/24.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import UIKit
import RealmSwift

final class CategoryViewController: SwipeTableViewController {
    // MARK: - Property
    private let realm = try! Realm()
    private var categories: Results<Category>?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        loadCategories()
    }

    // MARK: - Helper
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { _ in
            
            let newCategory = Category()
            newCategory.name = textField.text!
            
            self.save(category: newCategory)
        }
        
        alert.addTextField { field in
            field.placeholder = "Create new Category"
            textField = field
        }
        
        alert.addAction(action)
        
        present(alert, animated: true)
    }
    
    private func save(category: Category) {
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print(error)
        }
        
        self.tableView.reloadData()
    }
    
    private func loadCategories() {
        categories = realm.objects(Category.self)
        
        self.tableView.reloadData()
    }
    
    override func updateModel(at indexPath: IndexPath) {
        if let categoryForDeletion = categories?[indexPath.row] {
            do {
                try realm.write {
                    realm.delete(categoryForDeletion)
                }
            } catch {
                print(error)
            }
        }
    }
    
}

// MARK: - UITableViewDataSource Method
extension CategoryViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        if let category = categories?[indexPath.row] {
            var content = cell.defaultContentConfiguration()
            
            content.text = category.name
            
            cell.contentConfiguration = content
        }
        
        return cell
    }
    
}

// MARK: - UITableViewDelegate Method
extension CategoryViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? TodoListViewController else { return }
        
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        
        destinationVC.selectedCategory = categories?[indexPath.row]
    }
    
}
