//
//  MapViewControllerLocation.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 17/01/2021.
//

import UIKit
import CoreLocation

extension MapViewController: CLLocationManagerDelegate {
    func setupLocationService() {
        if  CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorization()
        } else {
            manageErrors(errorCode: .missingCoordinate)
        }
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
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){

        guard let location = locations.last else { return }

        self.currentPlace = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        spanLocationMap(coordinate: currentPlace, spanLat: 1, spanLong: 1)
    }
}
