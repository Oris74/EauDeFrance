//
//  PiezometryODF.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 31/01/2021.
//

import Foundation

class PiezometryODF: StationODF {
    let startMeasurementDate, endMeasurementDate: String
    var bdLisaCode: [String]
    var urnsBdLisa: [URL]?
    let bssId: String
    let nbPiezoMeasurement: Int
    let depthOfInvestigation: Double
    var bodyOfWaterCode: [String]
    var bodyOfWaterLabel: [String]
    var uriBodyOfWater: [URL]?

    init(stationCode: String,
        stationLabel: String,
        longitude: Double,
        latitude: Double,
        townshipCode: String,
        codePostal: String,
        townshipLabel: String,
        countyCode: String,
        countyLabel: String,
        bodyOfWaterCode: [String],
        bodyOfWaterLabel: [String],
        uriBodyOfWater: [URL]?,
        depthOfInvestigation: Double,
        nbPiezoMeasurement: Int,
        bssId: String,
        urnsBdLisa: [URL]?,
        bdLisaCode: [String],
        startMeasurementDate: String,
        endMeasurementDate: String,
        altitude: String,
        dateUPDT: String) {

        self.bodyOfWaterCode = bodyOfWaterCode
        self.bodyOfWaterLabel = bodyOfWaterLabel
        self.uriBodyOfWater = uriBodyOfWater
        self.depthOfInvestigation = depthOfInvestigation
        self.nbPiezoMeasurement = nbPiezoMeasurement
        self.bssId = bssId
        self.urnsBdLisa = urnsBdLisa
        self.bdLisaCode = bdLisaCode
        self.startMeasurementDate = startMeasurementDate
        self.endMeasurementDate = endMeasurementDate

        super.init(stationCode: stationCode,
             stationLabel: stationLabel,
             longitude: longitude,
             latitude: latitude,
             countyCode: countyCode,
             countyLabel: countyLabel,
             altitude: altitude,
             townshipCode: townshipCode,
             postalCode: codePostal,
             townshipLabel: townshipLabel,
             dateUPDT: dateUPDT
             )
    }

    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
}
