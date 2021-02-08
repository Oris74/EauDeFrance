//
//  EauDeFranceStruct.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 13/01/2021.
//

import Foundation

class HydrometryODF: StationODF {
    let siteCode: String?
    let siteLabel:String?
    let stationType: String?
    let coordonnateXStation: Int?
    let coordonnateYStation: Int?
    let projectionCode: Int?
    let localStationInfluence : Int?
    let stationCommentary: String?
    let altiSiteSystemCode: Int?
    let regionCode: String?
    let regionLabel: String?
    let streamCode, streamLabel: String?
    let uriStream: String?
    let stationDescription: String?
    let openingStationDate: String?
    let closingStationDate: String?
    let localStationInfluenceCommentary: String?
    let stationRegimeCode: Int?
    let dataStationQualification: Int?
    let finalityStationCode: Int?
    let contextTypeStationLawStat: Int?
    let stationLawType: Int?
    let sandreNetworkStationCode: [String]?
    let altiRefStationActivationDate: String?
    let altiStationRefUpdateDate: String?
    let inService: Bool?

    init(stationCode: String,
         stationLabel: String,
         longitude: Double,
         latitude: Double,
         townshipCode: String,
         townshipLabel: String,
         countyCode: String,
         countyLabel: String,
         altitude: String,
         dateUPDT: String,
         siteCode: String?,
         siteLabel:String?,
         stationType: String?,
         coordonnateXStation: Int?,
         coordonnateYStation: Int?,
         projectionCode: Int?,
         localStationInfluence : Int?,
         stationCommentary: String?,
         altiSiteSystemCode: Int?,
         regionCode: String?,
         regionLabel: String?,
         streamCode: String?,
         streamLabel: String?,
         uriStream: String?,
         stationDescription: String?,
         openingStationDate: String?,
         closingStationDate: String?,
         localStationInfluenceCommentary: String?,
         stationRegimeCode: Int?,
         dataStationQualification: Int?,
         finalityStationCode: Int?,
         contextTypeStationLawStat: Int?,
         stationLawType: Int?,
         sandreNetworkStationCode: [String]?,
         altiRefStationActivationDate: String?,
         altiStationRefUpdateDate: String?,
         inService: Bool?) {
        self.streamCode = streamCode
        self.streamLabel = streamLabel
        self.uriStream = uriStream
        self.regionLabel =  regionLabel
        self.regionCode = regionCode
        self.siteCode = siteCode
        self.siteLabel = siteLabel
        self.stationType  = stationType
        self.coordonnateXStation = coordonnateXStation
        self.coordonnateYStation = coordonnateYStation
        self.projectionCode  = projectionCode
        self.localStationInfluence = localStationInfluence
        self.stationCommentary = stationCommentary
        self.altiSiteSystemCode = altiSiteSystemCode
        self.stationDescription = stationDescription
        self.openingStationDate = openingStationDate
        self.closingStationDate = closingStationDate
        self.localStationInfluenceCommentary = localStationInfluenceCommentary
        self.stationRegimeCode = stationRegimeCode
        self.dataStationQualification = dataStationQualification
        self.finalityStationCode = finalityStationCode
        self.contextTypeStationLawStat = contextTypeStationLawStat
        self.stationLawType = stationLawType
        self.sandreNetworkStationCode = sandreNetworkStationCode
        self.altiRefStationActivationDate = altiRefStationActivationDate
        self.altiStationRefUpdateDate = altiStationRefUpdateDate
        self.inService = inService
        super.init( service: "hydrometrie",
                    stationCode: stationCode,
                    stationLabel: stationLabel,
                    longitude: longitude,
                    latitude: latitude,
                    townshipCode: townshipCode,
                    townshipLabel: townshipLabel,
                    countyCode: countyCode,
                    countyLabel: countyLabel,
                    altitude: altitude,
                    dateUPDT: dateUPDT)
    }

    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
}
