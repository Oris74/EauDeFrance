//
//  PiezometryServiceTestCase.swift
//  EauDeFranceTests
//
//  Created by Laurent Debeaujon on 14/03/2021.
//

import XCTest
@testable import EauDeFrance

class PiezometryTestCase: XCTestCase {

    let zoneTest:String = "-4.2538580575743765,40.298887327258996,7.747512057574454,52.456923772004615"
    let stationService = StationService()

    func testGetStationPiezoGivenAreaShouldPostSuccessCallBackIfNoErrorAndCorrectData() {
        //Given

        let request: [[KeyRequest:String]] = [[.area:zoneTest],[.size:"2000"]]
        guard let dataJSONStation = FakeResponseData.piezometryStationJsonCorrectData else { return }

        let temperature = Piezometry(networkService: NetworkServiceFake(json: dataJSONStation))


        //When
        let expectation = XCTestExpectation(description: "Wait for queue change.")

        temperature.getStation(parameters: request, callback: {( stationList, error) in
        //Then
            XCTAssertEqual(error, nil)
            XCTAssertNotNil(stationList)

            XCTAssertEqual(stationList?[0].stationCode, "06772X0070/F1" )
            if let station = stationList?[0] as? PiezometryODF {
                XCTAssertEqual(station.nbPiezoMeasurement, 1929 )
            }
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetFigurePiezometryGivenStationCodeShouldPostSuccessCallBackIfNoErrorAndCorrectDataValue() {
        //Given
        guard let dataJSONValue = FakeResponseData.piezometryValueJsonCorrectData else { return }
        let piezometry = Piezometry(networkService: NetworkServiceFake(json: dataJSONValue))

        let stationCode =  "06063900"
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change.")

        piezometry.getFigure(stationCode: stationCode, callback: {(measure, error) in
            //Then
            XCTAssertEqual(error, nil)
            XCTAssertNotNil(measure)

            XCTAssertEqual(measure[0].value, FakeResponseData.piezoMeasureOK.value)
            expectation.fulfill()
        })

        wait(for: [expectation], timeout: 0.01)
    }

    func testGetStationPiezometryGivenAreaShouldPostFailedCallbackIfIncorrectResponse() {
        // Given
        let piezometry = Temperature(networkService: NetworkServiceFake(json: FakeResponseData.incorrectData))

        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        let request: [[KeyRequest:String]] = [[.area:zoneTest],[.size:"2000"]]

        piezometry.getStation(parameters: request, callback: {( stationList, error) in
            // Then
            XCTAssertEqual(error, Utilities.ManageError.decodableIssue)
            XCTAssertNil(stationList)
            expectation.fulfill()
        })

        wait(for: [expectation], timeout: 0.01)
    }
}
