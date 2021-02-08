//
//  QualityStreamODF.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 31/01/2021.
//

import Foundation

class QualityStreamODF: StationODF {

    let hardness: String?
    //let coordonneeX: String?
    //let coordonneeY: String?
    //let projectionTypeCode: String?
    //let projectionLabel: String?

    let regionCode: String?
    let regionLabel: String?

    let streamCode, streamLabel: String?
    let uriStream: String?
    let bodyOfWaterCode: String?
    let bodyOfWaterLabel: String?
    let uriBodyOfWater: String?
    let subBasinCode: String?
    let basinLabel: String?
    let subBasinLabel: String?
    let basinCode: String?
    let uriBasin: String?
    let hydroEntityType: String?
    let comment:String?
    let creationDate:String?
    let endDate: String?
    let finality: String?
    let preciseLocation: String?
    let nature: String?
    let pointKM: String?

    init(hardness: String?,
         streamCode: String? ,
         streamLabel: String? ,
         uriStream: String? ,
         stationCode: String,
         stationLabel: String,
         uriStation: String,
         longitude: Double,
         latitude: Double,
         townshipCode: String,
         townshipLabel: String,
         countyCode: String,
         countyLabel: String,
         altitude: String,
         dateUPDT: String,
         bodyOfWaterCode: String?,
         bodyOfWaterLabel: String?,
         uriBodyOfWater: String? ,
         regionLabel: String?,
         regionCode: String?,
         subBasinCode: String?,
         basinLabel:String?,
         subBasinLabel: String?,
         basinCode: String?,
         uriBasin: String?,
         pointKM: String?,
         hydroEntityType: String?,
         comment: String?,
         creationDate: String?,
         endDate: String?,
         finality: String?,
         preciseLocation: String?,
         nature: String?) {
        self.hardness = hardness
        self.streamCode = streamCode
        self.streamLabel = streamLabel
        self.uriStream = uriStream
        self.regionCode = regionCode
        self.regionLabel = regionLabel
        self.hydroEntityType = hydroEntityType
        self.comment = comment
        self.bodyOfWaterCode = bodyOfWaterCode
        self.bodyOfWaterLabel = bodyOfWaterLabel
        self.uriBodyOfWater = uriBodyOfWater
        self.subBasinCode = subBasinCode
        self.basinLabel = basinLabel
        self.subBasinLabel = subBasinLabel
        self.basinCode = basinCode
        self.uriBasin = uriBasin
        self.creationDate = creationDate
        self.endDate = endDate
        self.finality = finality
        self.preciseLocation = preciseLocation
        self.nature = nature
        self.pointKM = pointKM

        super.init(service: "qualite_rivieres", stationCode: stationCode, stationLabel: stationLabel, uriStation: uriStation, longitude: longitude, latitude: latitude, townshipCode: townshipCode, townshipLabel: townshipLabel, countyCode: countyCode, countyLabel: countyLabel, altitude: altitude, dateUPDT: dateUPDT)
    }
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
}
