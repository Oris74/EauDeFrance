//
//  FakeResponseData.swift
//  EauDeFranceTests
//
//  Created by Laurent Debeaujon on 09/03/2021.
//

import Foundation
@testable import EauDeFrance

class FakeResponseData {
    // MARK: - Data
    static var temperatureStationJsonCorrectData: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "TemperatureStation", withExtension: "json")!
        return try? Data(contentsOf: url)
    }

    static var temperatureValueJsonCorrectData: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "TemperatureValue", withExtension: "json")!
        return try? Data(contentsOf: url)
    }

    static let incorrectData = "erreur".data(using: .utf8)!

    // MARK: - Response Edamam
    static let responseStationODFOK = StationODF(
             service: "",
             stationCode: "",
             stationLabel: "",
             uriStation: "",
             longitude: 0.0,
             latitude: 0.0,
             countyCode: "",
             countyLabel: "",
             altitude: "",
             townshipCode: "",
             postalCode: "",
             townshipLabel: "",
             dateUPDT: ""
    )

    // MARK: - Response TemperatureODF
    static let responseTemperatureODFOK = TemperatureODF(
             stationCode: "",
             stationLabel: "",
             uriStation: "",
             localization: "",
             streamCode: "",
             streamLabel: "",
             uriStream: "",
             hydroSectionCode: "",
             longitude: 0.0,
             latitude: 0.0,
             townshipCode: "",
             postalCode: "",
             townshipLabel: "",
             countyCode: "",
             countyLabel: "",
             altitude: "",
             dateUPDT: "",
             bodyOfWaterCode: "",
             bodyOfWaterLabel: "",
             uriBodyOfWater: "",
             regionLabel: "",
             regionCode: "",
             subBasinCode: "",
             basinLabel:"",
             subBasinLabel: "",
             basinCode: "",
             uriBasin: "",
             pointKM: ""
             )

    // MARK: - Response Recipe
//    static let responseValueOK = TemperatureODFValue(
//
//    )
}
