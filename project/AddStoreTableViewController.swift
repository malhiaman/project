//
//  AddStoreTableViewController.swift
//  project
//
//  Created by Student on 2018-04-03.
//  Copyright © 2018 Student. All rights reserved.
//

import UIKit
import CoreData

protocol AddSroreVCDelegate:class {
    func AddVC(_ controller: AddStoreTableViewController, didAddDept dept:Store)
    //func AddVC(_ controller: AddStoreTableViewController, didEditDept dept:Store)
}


class AddStoreTableViewController: UITableViewController, PickStoreIconVCDelegate {
    
    var managedObjectContext: NSManagedObjectContext!
     weak var delegate: AddSroreVCDelegate?

    @IBOutlet weak var nameofStore: UITextField!
    
    @IBOutlet weak var location: UITextField!
    
    
    @IBOutlet weak var longitude: UITextField!
    
    @IBOutlet weak var latitude: UITextField!
    
    @IBOutlet weak var pickImage: UIImageView!
    
    @IBOutlet weak var datePickSwitch: UISwitch!
    
    @IBOutlet weak var dateDueLabel: UILabel!
    var store:Store?
     var storeIconName: String?
    
    var editPlace : Bool = false
    @IBAction func done(_ sender: UIBarButtonItem) {
      
        
        
        store  = Store(context: managedObjectContext)
        store!.locName = nameofStore.text
        store!.loc = location.text
        if let icon = storeIconName {
            store!.imagePick = icon
        }
        
      
        do {
            try managedObjectContext.save()
        } catch {
            print("Core Data Error")
        }
        if !editPlace {
         delegate?.AddVC(self, didAddDept: store!)
        
        }
        navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
        return 7
    }
    func pickIcon(_ controller: PickStoreImageTableViewController, didPick imagePic: String) {
        self.storeIconName = imagePic
        pickImage.image = UIImage(named: storeIconName!)
        navigationController?.popViewController(animated: true)
        
        
        
        
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
