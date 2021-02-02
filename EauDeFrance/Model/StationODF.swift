//
//  StationService.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 14/01/2021.
//

import Foundation
import MapKit

class StationODF:NSObject, Decodable {
    let stationCode, stationLabel: String?
    let uriStation: String?
    let longitude, latitude: Double?
    let townshipCode, townshipLabel, countyCode, countyLabel: String?
    let altitude: String?
    let dateUPDT: String?

    init(
         stationCode: String?, stationLabel: String?,
         uriStation: String? = nil,
         longitude: Double?, latitude: Double?,
         townshipCode: String?, townshipLabel: String?,
         countyCode: String?, countyLabel: String?,
         altitude: String? = nil,
        dateUPDT: String?) {
        self.stationCode = stationCode
        self.stationLabel = stationLabel
        self.uriStation = uriStation
        self.longitude = longitude
        self.latitude = latitude
        self.townshipCode = townshipCode
        self.townshipLabel = townshipLabel
        self.countyCode = countyCode
        self.countyLabel = countyLabel
        self.altitude = altitude
        self.dateUPDT = dateUPDT
    }
}
