//
//  MapViewControllerLocation.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 17/01/2021.
//

import UIKit
import CoreLocation

extension MapViewController: CLLocationManagerDelegate {
    func setupLocationService() -> CLLocationCoordinate2D  {

        if  CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorization()
            if  let location = locationManager.location?.coordinate {
                let currentPlace = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
                return currentPlace
            }
        }
            manageErrors(errorCode: .missingCoordinate)
        return CLLocationCoordinate2D(latitude: 46.227638, longitude: 2.213749)
    }

    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }

    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            break
        case .denied:
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .authorizedAlways:
            break
        case .restricted:
            break
        @unknown default:
            break
        }
    }
    
}
