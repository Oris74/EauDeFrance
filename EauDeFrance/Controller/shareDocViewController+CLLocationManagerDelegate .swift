//
//  shareDocViewController.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 28/02/2021.
//

import UIKit
import CoreLocation

/// extention of ShareDocViewController to manage localization
extension ShareDocViewController: CLLocationManagerDelegate {
    func setupLocationService() {
        if  CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
        } else {
            manageErrors(errorCode: .missingCoordinate)
        }
    }
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }

    /// Return  the closest landmark based on the last geolocalization
    func lookUpCurrentLocation(completionHandler: @escaping (CLPlacemark?)
                                -> Void ) {
        // Use the last reported location.
        if let lastLocation = self.locationManager.location {
            
            // Look up the location and pass it to the completion handler
            geocoder.reverseGeocodeLocation(lastLocation,
                                            completionHandler: { (placemarks, error) in
                                                if error == nil {
                                                    let firstLocation = placemarks?[0]
                                                    completionHandler(firstLocation)
                                                }
                                                else {
                                                    // An error occurred during geocoding.
                                                    completionHandler(nil)
                                                }
                                            })
        }
        else {
            // No location was available.
            completionHandler(nil)
        }
    }
}
