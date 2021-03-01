//
//  PiezometryODF.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 31/01/2021.
//

import Foundation

class PiezometryODF: StationODF {
    let startMeasurementDate, endMeasurementDate: String
    let bdLisaCode: [String]
    let urnsBdLisa: [String]
    let bssId: String
    let nbPiezoMeasurement: Int
    let depthOfInvestigation: Double
    let bodyOfWaterCode: [String]
    let bodyOfWaterLabel: [String]
    let uriBodyOfWater: [String]
    var figure: [PiezometryODFValue]?

    init(stationCode: String,
        stationLabel: String,
        uriStation: String,
        longitude: Double,
        latitude: Double,
        townshipCode: String,
        codePostal: String,
        townshipLabel: String,
        countyCode: String,
        countyLabel: String,
        bodyOfWaterCode: [String],
        bodyOfWaterLabel: [String],
        uriBodyOfWater: [String],
        depthOfInvestigation: Double,
        nbPiezoMeasurement: Int,
        bssId: String,
        urnsBdLisa: [String],
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

        super.init(service: "Piezometrie",
             stationCode: stationCode,
             stationLabel: stationLabel,
             uriStation: uriStation,
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
