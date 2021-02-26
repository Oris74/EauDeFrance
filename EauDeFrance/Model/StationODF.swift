//
//  StationService.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 14/01/2021.
//

import Foundation
import MapKit

class StationODF:NSObject, Decodable {
    let service: String
    let stationCode, stationLabel: String
    let uriStation: String
    let longitude, latitude: Double
    let countyCode, countyLabel: String
    var townshipCode, townshipLabel: String 
    var altitude: String 
    var dateUPDT: String 

//    init(service: String, stationCode: String, stationLabel: String,
//         uriStation: String? = nil,
//         longitude: Double, latitude: Double,
//         townshipCode: String, townshipLabel: String,
//         countyCode: String, countyLabel: String,
//         altitude: String,
//        dateUPDT: String) {
//        self.service = service
//        self.stationCode = stationCode
//        self.stationLabel = stationLabel
//        self.uriStation = uriStation
//        self.longitude = longitude
//        self.latitude = latitude
//        self.townshipCode = townshipCode
//        self.townshipLabel = townshipLabel
//        self.countyCode = countyCode
//        self.countyLabel = countyLabel
//        self.altitude = altitude
//        self.dateUPDT = dateUPDT
//    }
    
    init(service: String,
         stationCode: String,
         stationLabel: String,
         uriStation: String,
         longitude: Double,
         latitude: Double,
         countyCode: String,
         countyLabel: String,
         altitude: String,
         townshipCode: String,
         townshipLabel: String,
         dateUPDT: String) {

        self.service = service
        self.stationCode = stationCode
        self.uriStation = uriStation
        self.longitude = longitude
        self.latitude = latitude
        self.countyCode = countyCode
        self.countyLabel = countyLabel
        self.stationLabel = stationLabel
        self.townshipCode = townshipCode
        self.townshipLabel = townshipLabel
        self.altitude = altitude
        self.dateUPDT = dateUPDT
    }
}
