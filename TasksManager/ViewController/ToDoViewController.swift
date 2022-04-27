//
//  ToDoViewController.swift
//  TasksManager
//
//  Created by Yushkevich Ilya on 26.04.22.
//

import UIKit

class ToDoViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  private var toDos: [ToDo] = [ToDo]() {
    didSet {
      tableView.reloadData()
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    NetworkManager.instance.getData { [weak self] items in
      self?.toDos = items
    }
    view.backgroundColor = UIColor.groupTableViewBackground
    tableView.delegate = self
    tableView.dataSource = self
    title = "To Do"
    navigationController?.navigationItem.leftBarButtonItem = UIBarButtonItem(
      barButtonSystemItem: .add,
      target: self,
      action: #selector(refreshTapped)
    )
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = false
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem
  }
  
  @objc
  private func refreshTapped() {
    NetworkManager.instance.getData { [weak self] items in
      self?.toDos = items
    }
  }
  
  // MARK: - Table view data source
}

extension ToDoViewController: UITableViewDelegate, UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    // #warning Incomplete implementation, return the number of sections
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    return toDos.count
  }
  
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    
    let currentItem = toDos[indexPath.row]
    
    cell.textLabel?.text = currentItem.title as? String
    
    if (currentItem.completed) == true{
      cell.accessoryType = .checkmark // добавление картинок
    } else {
      cell.accessoryType = .none
    }
    
    // Configure the cell...
    
    if tableView.isEditing {
      cell.textLabel?.alpha = 0.4
    } else {
      cell.textLabel?.alpha = 1
    }
    
    return cell
  }
  
  
  
  // Override to support conditional editing of the table view.
  func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    // Return false if you do not want the specified item to be editable.
    return true
  }
  
  
  
  // Override to support editing the table view.
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      // Delete the row from the data source
      toDos.remove(at: indexPath.row)
      tableView.deleteRows(at: [indexPath], with: .fade)
    } else if editingStyle == .insert {
      // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
  }
  
  //  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
  //    tableView.deselectRow(at: indexPath, animated: true)
  //
  //    if changeState(at: indexPath.row) {
  //      tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
  //    } else {
  //      tableView.cellForRow(at: indexPath)?.accessoryType = .none
  //    }
  //
  //    tableView.cellForRow(at: indexPath)?.accessoryType
  //  }
  //
  //
  //
  //  // Override to support rearranging the table view.
  //  func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
  //    moveItem(fromIndex: fromIndexPath.row, toIndex: to.row)
  //    tableView.reloadData()
  //  }
  
  func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
    if tableView.isEditing {
      return .none
    } else {
      return .delete
    }
    
  }
  
  func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt IndexPath: IndexPath) -> Bool {
    return false
  }
}
