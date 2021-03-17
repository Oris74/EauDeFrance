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
    
    static var noValueJsonCorrectData: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "NoValue", withExtension: "json")!
        return try? Data(contentsOf: url)
    }
    static let incorrectData = "erreur".data(using: .utf8)!
    
    static let wrongEndPoint = URL(string: "http://openclassrooms.com")!
    
    // MARK: - Response
    
    static let piezoMeasureOK = Measure(timestamp: "2021-02-17T00:00:00Z", value: 21.6, unit: "m (ngf)" )
    
    static let temperatureMeasureOK = Measure(timestamp: "2011-11-29T01:00:00Z", value: 5.462, unit: "°C" )
    
    static let measureNoValueReturned: [Measure] = []
    
    static let responseKO = HTTPURLResponse(
        url: URL(string: "https://hubeau.eaufrance.fr/api/v1/temperature/chronique?")!,
        statusCode: 500, httpVersion: nil, headerFields: [:])!
    
}
