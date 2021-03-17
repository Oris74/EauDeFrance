//
//  TemperatureServiceTestCase.swift
//  EauDeFranceTests
//
//  Created by Laurent Debeaujon on 14/03/2021.
//

import XCTest
@testable import EauDeFrance

class TemperatureTestCase: XCTestCase {
    let zoneTest:String = "-4.2538580575743765,40.298887327258996,7.747512057574454,52.456923772004615"
    let stationService = StationService()

    func testGetStationTemperatureGivenAreaShouldPostFailedCallbackIfIncorrectResponse() {
        // Given
        let temperature = Temperature(networkService: NetworkServiceFake(json: FakeResponseData.incorrectData))

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        let request: [[KeyRequest:String]] = [[.area:zoneTest],[.size:"2000"]]

        temperature.getStation(parameters: request, callback: {( stationList, error) in
            // Then
            XCTAssertEqual(error, Utilities.ManageError.decodableIssue)
            XCTAssertNil(stationList)
            expectation.fulfill()
        })

        wait(for: [expectation], timeout: 0.01)
    }

    func testGetStationTemperatureGivenAreaShouldPostSuccessCallBackIfNoErrorAndCorrectData() {
        //Given

        let request: [[KeyRequest:String]] = [[.area:zoneTest],[.size:"2000"]]
        guard let dataJSONStation = FakeResponseData.temperatureStationJsonCorrectData else { return }

        let temperature = Temperature(networkService: NetworkServiceFake(json: dataJSONStation))


        //When
        let expectation = XCTestExpectation(description: "Wait for queue change.")

        temperature.getStation(parameters: request, callback: {( stationList, error) in
            //Then
            XCTAssertEqual(error, nil)
            XCTAssertNotNil(stationList)

            XCTAssertEqual(stationList?[0].stationCode, "06070100" )
            if let stationList = stationList {
                if let stationTest = stationList[0] as? TemperatureODF {
                    XCTAssertEqual(stationTest.streamLabel, "Le Fier" )
                }
            }
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetFigureTemperatureGivenStationCodeShouldPostSuccessCallBackIfNoErrorAndCorrectDataValue() {
        //Given
        guard let dataJSONValue = FakeResponseData.temperatureValueJsonCorrectData else { return }
        let temperature = Temperature(networkService: NetworkServiceFake(json: dataJSONValue))

        let stationCode =  "06063900"
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        temperature.getFigure(stationCode: stationCode, callback: {(measure, error) in
            //Then
            XCTAssertEqual(error, nil)
            XCTAssertNotNil(measure)

            XCTAssertEqual(measure[0].value, FakeResponseData.temperatureMeasureOK.value)
            expectation.fulfill()
        })

        wait(for: [expectation], timeout: 0.01)
    }


    func testGetFigurePiezometryGivenStationShouldPostSuccessCallbackThenNovalueReturned() {
        guard let dataJSONValue = FakeResponseData.noValueJsonCorrectData else { return }
        let temperature = Temperature(networkService: NetworkServiceFake(json: dataJSONValue))

        let stationCode =  "06063900"
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change.")

        temperature.getFigure(stationCode: stationCode, callback: {(measure, error) in
            //Then
            XCTAssertEqual(error, Utilities.ManageError.missingData)
            XCTAssertEqual(measure, FakeResponseData.measureNoValueReturned)

            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetFigureTemperatureGivenStationCodeShouldPostFailedCallBackIfIncorrectResponse() {
        //Given

        let temperature = Temperature(networkService: NetworkService(networkSession: URLSessionFake(
                                                                        data: FakeResponseData.temperatureValueJsonCorrectData,
                                                                        response: FakeResponseData.responseKO,
                                                                        error: nil)))
        let stationCode =  "06063900"

        //When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        temperature.getFigure(stationCode: stationCode, callback: {(measure, error) in
            //Then
            XCTAssertEqual(error, Utilities.ManageError.internalServerError)
            XCTAssertEqual(measure, [])

            expectation.fulfill()
        })

        wait(for: [expectation], timeout: 1.0)
    }
}
