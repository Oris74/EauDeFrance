//
//  share.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 12/02/2021.
//

import UIKit
import MapKit

extension ShareDocViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
            guard let newLocation = userLocation.location else { return }

            let currentTime = Date()
            let lastLocation = self.currentLocation
            currentLocation = newLocation

            // Only get new placemark information if you don't have a previous location,
            // if the user has moved a meaningful distance from the previous location, such as 1000 meters,
            // and if it's been 60 seconds since the last geocode request.
            if newLocation.distance(from: lastLocation) <= 1000,
                let lastTime = lastGeocodeTime,
                currentTime.timeIntervalSince(lastTime) < 60 {
                return
            }

            // Convert the user's location to a user-friendly place name by reverse geocoding the location.
            lastGeocodeTime = currentTime
            geocoder.reverseGeocodeLocation(newLocation) { (placemarks, error) in
                guard error == nil else {
                    self.manageErrors(errorCode: Utilities.ManageError.missingCoordinate)
                    return
                }

                // Most geocoding requests contain only one result.
                if let firstPlacemark = placemarks?.first {
                    self.markPlace.text = firstPlacemark.name
                    self.note.text = "\(firstPlacemark.postalCode ?? "Code Postal") \(firstPlacemark.locality ?? "Localité")\n \(String(describing: firstPlacemark.timeZone) )"
                }
            }
        }

    func spanLocationMap(coordinate: CLLocationCoordinate2D, spanLat: Double, spanLong: Double) {

        let region = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
        mapView.setRegion(region, animated: true)
    }

    internal func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? StationODF else { return nil }
        let identifier = "stationODF"

        var view: StationAnnotationView

        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            as? StationAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView

        } else {
            view = StationAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: 0, y: 60)
        }
        return view
    }
}
