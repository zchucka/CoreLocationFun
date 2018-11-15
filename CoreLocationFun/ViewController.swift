//
//  ViewController.swift
//  CoreLocationFun
//
//  Created by Chucka, Zachary Tyler on 11/15/18.
//  Copyright © 2018 Chucka, Zachary Tyler. All rights reserved.
//

import UIKit
import CoreLocation
//Mark: - Location Services
/* CLLocationManager: class used to get the user's location and updates
 CLGeocoder: class used to convert address/place -> coordinates and coordinates -> address/place
 task: create a UI that has three labels: latitude, longitude, and place name
 set up outlets as well
 */
class ViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet var latitudeLabel: UILabel!
    @IBOutlet var longitudeLabel: UILabel!
    @IBOutlet var placeLabel: UILabel!
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // check to make sure user has location enabled
        if CLLocationManager.locationServicesEnabled()
        {
            print("Location Services enabled")
            setupLocationServices()
        } else {
            // the user turned off location, phone is in airplane mode, lack of hardware, hardware failure,...
            print("Location Services disabled")
        }
    }
    
    func setupLocationServices() {
        // location manager needs a CLLocationManagerDelegate to notify about errors and location updates, authorization updates, etc
        locationManager.delegate = self
        // we need to get the users authorization to access their location
        // we need a k/v pair in info.plist
        // there are two different ways to access location
        // 1. when-in-use: our app only gets location updates when the app is running
        // 2. always: our app always gets location updates... OS will launch our app if it has a location update for it
        // 1 is the preferred method, use if app  doesn't require always location access (GPS needs always)
        // we will only use when-in-use in this class
        locationManager.requestWhenInUseAuthorization()
        // two ways to get location updates
        // 1. requestLocation() one time update
        // 2. startUpdatingLocation() continual updates until you call stopUpdatingLocation()
        //locationManager.requestLocation()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations)
        latitudeLabel.text = "Latitude: \(locations[0].coordinate.latitude)"
        longitudeLabel.text = "Longitude: \(locations[0].coordinate.longitude)"
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

