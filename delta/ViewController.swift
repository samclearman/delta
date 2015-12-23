//
//  ViewController.swift
//  delta
//
//  Created by Sam Clearman on 10/29/15.
//  Copyright © 2015 Sam Clearman. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var locationManager = CLLocationManager()
    var heading = 0.0
    var course = 0.0
    var speed = 0.0
    
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var courseLabel: UILabel!
    @IBOutlet weak var compassView: CompassView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.checkLocationAuth()
        self.startSpeedTracking()
        self.update()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func update() {
        if self.speed < 0 {
            speedLabel.text = "-- mph"
        } else {
            speedLabel.text = String(format: "%.1f mph", self.speed)
        }
        if self.course < 0 {
            courseLabel.text = "--º"
        } else {
            courseLabel.text = String(format: "%.0fº", self.course)
        }
        compassView.heading = self.heading
        compassView.course = self.course
        compassView.setNeedsDisplay()
    }
    
    func checkLocationAuth() {
        let status = CLLocationManager.authorizationStatus()
        switch status {
            case CLAuthorizationStatus.NotDetermined:
                self.locationManager.requestWhenInUseAuthorization()
            default: break
        }
    }
    
    func startSpeedTracking() {
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        locationManager.startUpdatingHeading()
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.first!
        self.course = location.course
        self.speed = location.speed * 0.000621371 * 3600 // convert to mph
        self.update()
    }
    
    func locationManager(manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        self.heading = newHeading.trueHeading
    }

}

