//
//  AddStoreTableViewController.swift
//  project
//
//  Created by Amandeep Kaur on 2018-04-03.
//  Copyright © 2018 Student. All rights reserved.
//

import UIKit
import CoreData
import CoreLocation

protocol AddSroreVCDelegate:class {
    func AddVC(_ controller: AddStoreTableViewController, didAddDept dept:Store)
    //func AddVC(_ controller: AddStoreTableViewController, didEditDept dept:Store)
}


class AddStoreTableViewController: UITableViewController, PickStoreIconVCDelegate {
    let ManagerOfLocation = CLLocationManager()
    var location2: CLLocation?
    var managedObjectContext: NSManagedObjectContext!
     weak var delegate: AddSroreVCDelegate?

    @IBOutlet var datePickerCell: UITableViewCell!
    @IBOutlet weak var nameofStore: UITextField!
    
    @IBOutlet weak var location: UITextField!
    
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var longitude: UITextField!
    
    @IBOutlet weak var latitude: UITextField!
    
    @IBOutlet weak var pickImage: UIImageView!
    
    @IBOutlet weak var datePickSwitch: UISwitch!
    
    @IBOutlet weak var dateDueLabel: UILabel!
    var store:Store?
     var storeIconName: String?
    
    var editPlace : Bool = false
    @IBAction func done(_ sender: UIBarButtonItem) {
      
        
        if !editPlace {
        store  = Store(context: managedObjectContext)
        }
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
self.tableView.backgroundColor = UIColor.lightGray
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
    func pickIcon(_ controller: PickStoreImageTableViewController, didPick imagePick: String) {
        self.storeIconName = imagePick
        pickImage.image = UIImage(named: storeIconName!)
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func dateFormat(_ sender: UIDatePicker) {
        let formatdate = DateFormatter()
        formatdate.dateStyle = .short
        formatdate.timeStyle = .none
        dateDueLabel.text = formatdate.string(from: datePicker.date)
    }
    
    @IBAction func switchtoggle(_ sender: UISwitch) {
        tableView.reloadData()
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 6 {
            return datePickerCell
        }
        
        return super.tableView(tableView, cellForRowAt: indexPath)
        
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 6 {
            if datePickSwitch.isOn {
                return 217
            } else {
                return 0
            }
        } else {
            return 44
        }
    }
    


    @IBAction func ForwardGeo(_ sender: UIBarButtonItem) {
        let geoForwardCoder = CLGeocoder()
        
        geoForwardCoder.geocodeAddressString((location.text)!, completionHandler: {
            placemarks, error in
            print("Found the location: \(String(describing: placemarks))")
            if let placemark = placemarks?.last {
                if  let latitude = placemark.location?.coordinate.latitude,
                    let longitude = placemark.location?.coordinate.longitude {
                    self.latitude.text = "\(String(describing: latitude))"
                    self.longitude.text =    " \(String(describing: longitude))"
                    let alert = UIAlertController(title: "Geocode Lookup Result GeoForward:", message:
                        "The location Latitude: \(self.latitude.text!) Longitude: \(self.longitude.text!)" , preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alert.addAction(okAction)
                    self.present(alert, animated: true, completion: nil)
                    
                }
            }
        })
    }
    
  
    @IBAction func ReverseGeo(_ sender: UIBarButtonItem) {
        
        let geoReverseCoder = CLGeocoder()
        
        let latitudeValue : Double? = Double(latitude.text!)
        let longitudeValue : Double? = Double(longitude.text!)
        
        let location = CLLocation(latitude: latitudeValue!, longitude: longitudeValue!)
        geoReverseCoder.reverseGeocodeLocation(location, completionHandler: {
            placemarks, error in
            print("Found The location: \(String(describing: placemarks))")
            if let placepoint = placemarks?.last!{
                var address = ""
                if let street1address = placepoint.subThoroughfare {
                    address = address + street1address + " "
                }
                if let street2address = placepoint.thoroughfare {
                    address = address + street2address + " "
                }
                if let cityPlace = placepoint.locality {
                    address = address + cityPlace + " "
                }
                if let province = placepoint.administrativeArea {
                    address = address + province + " "
                }
                if let postAreacode = placepoint.postalCode{
                    address = address + postAreacode + " "
                }
                self.location.text = address
                let alert = UIAlertController(title: "Geocode Lookup Result GeoReverse:", message:
                    "The location is: \(self.location.text!)" , preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
                
            }
        })
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
        let controller = segue.destination as! PickStoreImageTableViewController
        controller.delegate = self
    }
  
    
    

}
