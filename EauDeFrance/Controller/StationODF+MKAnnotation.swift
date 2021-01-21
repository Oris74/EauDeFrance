//
//  Poi.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 17/01/2021.
//
import MapKit

/// MARK: StationODF compatible with map annotation View
extension StationODF: MKAnnotation {
    var title :String? {
        return stationID
    }
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude ?? 0, longitude: longitude ?? 0)
    }
    var info: String? {
        return stationLabel
    }
}
