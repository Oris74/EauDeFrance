//
//  StationService.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 14/01/2021.
//

import Foundation
import MapKit

class StationODF: NSObject {
    let service: Service
    let stationID, stationLabel: String?
    let uriStation: String?
    let localization: String?
    let coordinateX, coordinateY: Int?
    //let codeTypeProjection: Int?
    let longitude, latitude: Double?
    let townshipID, townshipLabel, countyID, countyLabel: String?
    let regionID, regionLabel: String?
    //let hydroSectionID: String?
    let streamID: String?
    let streamLabel: String?
    let uriStream: String?
    let bodyOfWaterID: [String]?
    let bodyOfWaterLabel: [String]?
    let uriBodyOfWater: [String]?
   // let codeSousBassin, libelleSousBassin, codeBassin, libelleBassin: String?
    //let uriBassin: String?
    let pointKm: String?
    let altitude: String?
    let dateOfUpdtInfos: String?
    //let geometry: Geometry?
    
    init(service: Service,
         stationID:String?, stationLabel: String?,
         uriStation: String? = nil, localization: String? = nil,
         coordinateX: Int? = 0, coordinateY: Int? = 0,
         longitude: Double?, latitude: Double?,
         townshipID: String?, townshipLabel: String?,
         countyID: String?, countyLabel: String?,
         regionID: String?, regionLabel: String?,
         hydroSectionID: String? = nil,
         streamID: String?, streamLabel: String?, uriStream: String?,
         uriBodyOfWater: [String]? = nil, bodyOfWaterLabel: [String]? = nil,
         bodyOfWaterID: [String]? = nil,
         pointKm: String? = nil,
         altitude: String? = nil,
         dateOfUpdtInfos: String?) {
        self.service = service
        self.stationID = stationID
        self.stationLabel = stationLabel
        self.uriStation = uriStation
        self.localization = localization
        self.coordinateX = coordinateX
        self.coordinateY = coordinateY
        self.longitude = longitude
        self.latitude = latitude
        self.townshipID = townshipID
        self.townshipLabel = townshipLabel
        self.countyID = countyID
        self.countyLabel = countyLabel
        self.regionID = regionID
        self.regionLabel = regionLabel
        self.streamID = streamID
        self.streamLabel = streamLabel
        self.uriStream = uriStream
        self.uriBodyOfWater = uriBodyOfWater
        self.bodyOfWaterLabel = bodyOfWaterLabel
        self.bodyOfWaterID = bodyOfWaterID
        self.pointKm = pointKm
        self.altitude = altitude
        self.dateOfUpdtInfos = dateOfUpdtInfos
    }
}


