//
//  Poi.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 17/01/2021.
//
import Foundation
import MapKit

/// MARK: StationODF compatible with map annotation View
extension StationODF: MKAnnotation {
    var title :String? {
        return stationLabel
    }
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude , longitude: longitude )
    }
    var info: String? {
        return (postalCode + " " + townshipLabel).uppercased()
    }
}
