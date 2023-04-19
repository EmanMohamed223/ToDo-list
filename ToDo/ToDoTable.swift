//
//  ToDoTable.swift
//  ToDo
//
//  Created by Eman on 26/01/2023.
//

import UIKit
import UserNotifications
class ToDoTable: UITableViewController {
    var todos = [ToDo]()
    override func viewDidLoad() {
        super.viewDidLoad()
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound , .badge] , completionHandler: { success , error in
            if success {
            }
            else if let error = error { print( error.localizedDescription)}
        })
        self.navigationItem.leftBarButtonItem = editButtonItem
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        ToDo.loadToDos()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return todos.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let temp = todos[indexPath.row]
        cell.textLabel?.text = temp.title
        // Configure the cell...

        return cell
    }
    @IBAction func unwindToToDoList(segue: UIStoryboardSegue) {
//        guard segue.identifier == "save" else { return }
//        let sourceViewController = segue.source as!
//        AddToDO
//        if let todo = sourceViewController.todo {
//            let newIndexPath = IndexPath(row: todos.count, section: 0)
//            todos.append(todo)
//            let contet = UNMutableNotificationContent()
//            contet.title = todo.title
//            contet.sound = .default
//            contet.body = todo.notes ?? ""
//            let targetDate = todo.dueDate
//            let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year , .month , .day , .hour , .minute , .second], from: targetDate), repeats: false)
//            let request = UNNotificationRequest(identifier: "id", content: contet, trigger: trigger)
//            UNUserNotificationCenter.current().add(request , withCompletionHandler: {error in
//                if error != nil {print(error?.localizedDescription)}
//            })
//            tableView.insertRows(at: [newIndexPath], with: .automatic)
//        }
//        guard segue.identifier == "save",
//            let sourceViewController = segue.source
//               as? AddToDO,
//            let todo = sourceViewController.todo else { return }
//        print(tableView.indexPathForSelectedRow)
//        if let selectedIndexPath = tableView.indexPathForSelectedRow {
//            todos[selectedIndexPath.row] = todo
//            tableView.reloadRows(at: [selectedIndexPath], with: .none)
//        } else {
//            let newIndexPath = IndexPath(row: todos.count, section: 0)
//            todos.append(todo)
//            tableView.insertRows(at: [newIndexPath], with: .automatic)
//        }
        
        
        //todos.firstIndex(of: todo)
        
        
        guard segue.identifier == "save" else { return }
            let sourceViewController = segue.source as! AddToDO
            if let todo = sourceViewController.todo {
                if let indexOfExistingToDo = todos.firstIndex(of: todo) {
                    todos[indexOfExistingToDo] = todo
                    tableView.reloadRows(at: [IndexPath(row:
                       indexOfExistingToDo, section: 0)], with: .automatic)
                } else {
                    let newIndexPath = IndexPath(row: todos.count, section: 0)
                    todos.append(todo)
                    ToDo.saveToDos(todos)
                    let contet = UNMutableNotificationContent()
                               contet.title = todo.title
                               contet.sound = .default
                            contet.body = todo.notes ?? ""
                            let targetDate = todo.dueDate
                                let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year , .month , .day , .hour , .minute , .second], from: targetDate), repeats: false)
                              let request = UNNotificationRequest(identifier: "id", content: contet, trigger: trigger)
                                UNUserNotificationCenter.current().add(request , withCompletionHandler: {error in
                                    if error != nil {print(error?.localizedDescription)}
                                })
                    tableView.insertRows(at: [newIndexPath], with: .automatic)
                   
                    ToDo.loadToDos()

                }
            }
        
    }

    @IBSegueAction func edit(_ coder: NSCoder, sender: Any?) -> AddToDO? {
        guard let cell = sender as? UITableViewCell, let indexPath =
                             tableView.indexPath(for: cell) else {
                              return nil
                          }
                         tableView.deselectRow(at: indexPath, animated: true)

                 let detailController = AddToDO(coder:
                    coder)
                 detailController?.todo = todos[indexPath.row]
                 return detailController
             
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

   
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            todos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            ToDo.saveToDos(todos)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    func notification ()
    {
        let contet = UNMutableNotificationContent()
        contet.title = "hello nofification"
        contet.sound = .default
        contet.body = "blablablablbalbalbalbalbalbalbalbalbalablablabalbalbala"
        let targetDate = Date().addingTimeInterval(10)
        let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year , .month , .day , .hour , .minute , .second], from: targetDate), repeats: false)
        let request = UNNotificationRequest(identifier: "id", content: contet, trigger: trigger)
        UNUserNotificationCenter.current().add(request , withCompletionHandler: {error in
            if error != nil {print(error?.localizedDescription)}
        })
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
//    override func tableView(_ tableView: UITableView,
//       commit editingStyle: UITableViewCell.EditingStyle,
//       forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            todos.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .automatic)
//            ToDo.saveToDos(todos)
//        }
//    }
    
}
