//
//  EauDeFranceStruct.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 13/01/2021.
//

import Foundation

class TemperatureODF: StationODF {
    let localization: String
    let regionCode: String
    let regionLabel: String
    let hydroSectionCode: String
    let streamCode, streamLabel: String
    let uriStream: URL?
    let bodyOfWaterCode: String
    let bodyOfWaterLabel: String
    let uriBodyOfWater: URL?
    let subBasinCode: String
    let basinLabel: String
    let subBasinLabel: String
    let basinCode: String
    let uriBasin: URL?
    let pointKM: String
   
    init(stationCode: String,
         stationLabel: String,
         localization: String,
         streamCode: String,
         streamLabel: String,
         uriStream: URL?,
         hydroSectionCode: String,
         longitude: Double,
         latitude: Double,
         townshipCode: String,
         postalCode: String,
         townshipLabel: String,
         countyCode: String,
         countyLabel: String,
         altitude: String,
         dateUPDT: String,
         bodyOfWaterCode: String,
         bodyOfWaterLabel: String,
         uriBodyOfWater: URL?,
         regionLabel: String,
         regionCode: String,
         subBasinCode: String,
         basinLabel:String,
         subBasinLabel: String,
         basinCode: String,
         uriBasin: URL?,
         pointKM: String
         ) {

        self.streamCode = streamCode
        self.streamLabel = streamLabel
        self.uriStream = uriStream
        self.localization = localization
        self.regionCode = regionCode
        self.regionLabel = regionLabel
        self.hydroSectionCode = hydroSectionCode
        self.bodyOfWaterCode = bodyOfWaterCode
        self.bodyOfWaterLabel = bodyOfWaterLabel
        self.uriBodyOfWater = uriBodyOfWater
        self.subBasinCode = subBasinCode
        self.basinLabel = basinLabel
        self.subBasinLabel = subBasinLabel
        self.basinCode = basinCode
        self.uriBasin = uriBasin
        self.pointKM = pointKM

        super.init(stationCode: stationCode,
                   stationLabel: stationLabel,
                   longitude: longitude,
                   latitude: latitude,
                   countyCode: countyCode,
                   countyLabel: countyLabel,
                   altitude: altitude,
                   townshipCode: townshipCode,
                   postalCode: postalCode,
                   townshipLabel: townshipLabel,
                   dateUPDT: dateUPDT)
    }

    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
}
