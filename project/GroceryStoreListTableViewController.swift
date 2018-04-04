//
//  GroceryStoreListTableViewController.swift
//  project
//
//  Created by Student on 2018-04-03.
//  Copyright © 2018 Student. All rights reserved.
//

import UIKit
import CoreData

class GroceryStoreListTableViewController: UITableViewController, AddSroreVCDelegate {
    var grocerylist = [Store]()
    var managedObjectContext: NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundColor = UIColor.lightGray
        let fetchRequest = NSFetchRequest<Store>(entityName: "Store")
        do {
            grocerylist = try managedObjectContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Fetch Error \(error)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return grocerylist.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        // Configure the cell...
        //cell.textLabel?.text = grocerylist[indexPath.row].locName
        //cell.detailTextLabel?.text = grocerylist[indexPath.row].loc
        let label = cell.viewWithTag(102) as! UILabel
        label.text = grocerylist[indexPath.row].locName
        let storeIconName = grocerylist[indexPath.row].imagePick
        let imageView = cell.viewWithTag(101) as! UIImageView
        imageView.image = UIImage(named: storeIconName!)



        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller = segue.destination as! AddStoreTableViewController
        controller.managedObjectContext = managedObjectContext
        controller.delegate = self
    }
    func AddVC(_ controller: AddStoreTableViewController, didAddDept dept:Store) {
        let addRow = grocerylist.count
        grocerylist.append(dept)
        let indexPath = IndexPath(row: addRow, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        navigationController?.popViewController(animated: true)
    }
 

}
