//
//  MapViewController.swift
//  project
//
//  Created by Amandeep Kaur on 2018-04-04.
//  Copyright © 2018 Student. All rights reserved.
//

import UIKit
import MapKit
import CoreData

class MapViewController: UIViewController {
  var managedObjectContext : NSManagedObjectContext!
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.delegate = self
        updateLocations()
    }
    override func viewWillAppear(_ animated: Bool) {
        updateLocations()
    }
    func updateLocations()
    {     //make a request
        //execute the request against the managedObjectContext
        // show the returned locations on the map
        let request = NSFetchRequest<Store>(entityName: "Store")
        let locations = try! managedObjectContext.fetch(request)
        //mapView.addAnnotations(locations)
        //let theRegion = region(for: locations)
        //mapView.setRegion(theRegion, animated: true)
        //mapView.regionThatFits(theRegion)
        
    }
    func region(for annotations: [MKAnnotation]) -> MKCoordinateRegion {
        let region: MKCoordinateRegion
        
        switch annotations.count {
        case 0:
            region = MKCoordinateRegionMakeWithDistance(
                mapView.userLocation.coordinate, 100000, 100000)
            
        case 1:
            let annotation = annotations[annotations.count - 1]
            region = MKCoordinateRegionMakeWithDistance(annotation.coordinate, 100000, 100000)
            
        default:
            var topLeft = CLLocationCoordinate2D(latitude: -90, longitude: 180)
            var bottomRight = CLLocationCoordinate2D(latitude: 90, longitude: -180)
            
            for annotation in annotations {
                topLeft.latitude = max(topLeft.latitude, annotation.coordinate.latitude)
                topLeft.longitude = min(topLeft.longitude, annotation.coordinate.longitude)
                bottomRight.latitude = min(bottomRight.latitude, annotation.coordinate.latitude)
                bottomRight.longitude = max(bottomRight.longitude, annotation.coordinate.longitude)
            }
            
            let center = CLLocationCoordinate2D(latitude: topLeft.latitude - (topLeft.latitude - bottomRight.latitude) / 2, longitude: topLeft.longitude - (topLeft.longitude - bottomRight.longitude) / 2)
            
            let extraSpace = 1.1
            let span = MKCoordinateSpan(latitudeDelta: abs(topLeft.latitude - bottomRight.latitude) * extraSpace, longitudeDelta: abs(topLeft.longitude - bottomRight.longitude) * extraSpace)
            
            region = MKCoordinateRegion(center: center, span: span)
        }
        
        return mapView.regionThatFits(region)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is Store else {
            return nil
        }
        let identifier = "Location"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        if annotationView == nil {
            let pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            pinView.isEnabled = true
            pinView.canShowCallout = true
            pinView.animatesDrop = true
            //pinView.pinTintColor = UIColor(red: 0.32, green: 0.82, blue: 0.4, alpha: 1)
            //pinView.tintColor = UIColor(white: 0.0, alpha: 0.5)
            /* let rightButton = UIButton(type: .detailDisclosure)
             rightButton.addTarget(self, action: #selector(showLocationDetails), for: .touchUpInside)
             pinView.rightCalloutAccessoryView = rightButton
             */
            annotationView = pinView
        }
        if let annotationView = annotationView {
            annotationView.annotation = annotation
            //  let button = annotationView.rightCalloutAccessoryView as! UIButton
            // if let index = locations.index(of: annotation as! Location) {
            //   button.tag = index
        }
        return annotationView
    }
}
