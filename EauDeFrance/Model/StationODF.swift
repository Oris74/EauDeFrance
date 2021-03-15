//
//  StationService.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 14/01/2021.
//

import Foundation
import MapKit

class StationODF:NSObject, Decodable {
    let stationCode, stationLabel: String
    let longitude, latitude: Double
    let countyCode, countyLabel: String
    let townshipCode: String
    let postalCode: String
    let townshipLabel: String
    let altitude: String
    let dateUPDT: String

    init(stationCode: String,
         stationLabel: String,
         longitude: Double,
         latitude: Double,
         countyCode: String,
         countyLabel: String,
         altitude: String,
         townshipCode: String,
         postalCode: String,
         townshipLabel: String,
         dateUPDT: String) {

        self.stationCode = stationCode
        self.longitude = longitude
        self.latitude = latitude
        self.countyCode = countyCode
        self.countyLabel = countyLabel
        self.stationLabel = stationLabel
        self.townshipCode = townshipCode
        self.postalCode = postalCode
        self.townshipLabel = townshipLabel
        self.altitude = altitude
        self.dateUPDT = dateUPDT
    }
}
