//
//  TableViewController.swift
//  ToDoWithCoreData
//
//  Created by Михаил Красильник on 06.02.2021.
//

import UIKit
import CoreData

class TableViewController: UITableViewController {

    var tasks: [Task] = []
    let viewContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let cellId = "myCell"

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tasks = TaskDatabaseManager.getTasks(viewContext: viewContext)
        tableView.register(TaskCell.self, forCellReuseIdentifier: cellId)
    }
    
    @IBAction func saveTask(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "New Task", message: "Please add a new Task.", preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in

            let textFieldTitle = alert.textFields?.first
            let textFieldBody = alert.textFields?.last
            if let newTasksTitle = textFieldTitle?.text {
                let body = textFieldBody?.text
                
                TaskDatabaseManager.saveTask(withTitle: newTasksTitle, body: body, viewContext: self.viewContext) { (task) in
                    self.tasks.append(task)
                    self.tableView.reloadData()
                }
            }
        }
        
        alert.addTextField { (textField) in
            textField.placeholder = "Enter the name of the new task"
        }
        
        alert.addTextField { (textField) in
            textField.placeholder = "Enter your task"
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive) { _ in }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! TaskCell
        cell.awakeFromNib()
        
        let task = tasks[indexPath.row]
        
        cell.title.text = task.title
        
        if task.body != nil {
            cell.body.text = task.body
        }
        

        return cell
    }

    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let indexOfRow = indexPath.row
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (_, _, _) in
            
            if TaskDatabaseManager.deleteTask(viewContext: self.viewContext, index: indexOfRow) {
                self.tasks.remove(at: indexOfRow)
                self.tableView.deleteRows(at: [indexPath], with: .bottom)
            }
        }
        
        let swipeActions = UISwipeActionsConfiguration(actions: [deleteAction])
        
        return swipeActions
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 100
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
}
