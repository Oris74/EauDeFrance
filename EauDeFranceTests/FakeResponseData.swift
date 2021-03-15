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

    static var piezometryStationJsonCorrectData: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "PiezometryStation", withExtension: "json")!
        return try? Data(contentsOf: url)
    }

    static var piezometryValueJsonCorrectData: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "PiezometryValue", withExtension: "json")!
        return try? Data(contentsOf: url)
    }

    static let incorrectData = "erreur".data(using: .utf8)!

    // MARK: - Response Edamam
    static let responseStationODFOK = StationODF(
             stationCode: "06070100",
             stationLabel: "FIER A POISY 1",
             longitude: 6.05677282,
             latitude: 45.898921858,
             countyCode: "74",
             countyLabel: "HAUTE-SAVOIE",
             altitude: "390.0",
             townshipCode: "74152",
             postalCode: "74330",
             townshipLabel: "LOVAGNY",
             dateUPDT: "2019-07-08"
    )

    // MARK: - Response TemperatureODF
    static let responseTemperatureODFOK = TemperatureODF(
             stationCode: "06070100",
             stationLabel: "FIER A POISY 1",
             localization: "Dans le TCC de Chavaroche,  900 m en aval du barrage",
             streamCode: "V12-0400",
             streamLabel: "Le Fier",
             uriStream: URL(string:"http://id.eaufrance.fr/CEA/V0--0200"),
             hydroSectionCode: "V1240400",
             longitude: 6.05677282,
             latitude: 45.898921858,
             townshipCode: "74152",
             postalCode: "74330",
             townshipLabel: "LOVAGNY",
             countyCode: "74",
             countyLabel: "HAUTE-SAVOIE",
             altitude: "390.0",
             dateUPDT: "2019-07-08",
             bodyOfWaterCode: "DR530",
             bodyOfWaterLabel: "Le Fier de la confluence avec la Filliére jusqu'au Rhône",
             uriBodyOfWater: URL(string: "http://id.eaufrance.fr/MDO/DR530"),
             regionLabel: "AUVERGNE-RHONE-ALPES",
             regionCode: "84",
             subBasinCode: "FRD_HRHO",
             basinLabel:"Le Rhône et les cours d'eau côtiers méditerranéens",
             subBasinLabel: "Haut Rhône",
             basinCode: "D",
             uriBasin: URL(string:"http://id.eaufrance.fr/SEH/D"),
             pointKM: ""
             )

    // MARK: - Response Recipe


    static let piezoMeasureOK = Measure(timestamp: "2021-02-17T00:00:00Z", value: 21.6, unit: "m (ngf)" )

    static let temperatureMeasureOK = Measure(timestamp: "2011-11-29T01:00:00Z", value: 5.462, unit: "°C" )
}
