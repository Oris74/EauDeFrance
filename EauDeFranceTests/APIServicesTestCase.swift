//
//  APIServicesTestCase.swift
//  EauDeFranceTests
//
//  Created by Laurent Debeaujon on 09/03/2021.
//
import XCTest
@testable import EauDeFrance

class APIServicesTestCase: XCTestCase {
//    private var endpointApiForTest = URL(string:"")!
//
//    func testgetAPIDataGivenJSONWhenDecodeTemperatureHubeauThenFailedAPIDecoded() {
//        // Given
//        let apiService = APIServiceFake(json: FakeResponseData.incorrectData)
//
//        let parameters: [[KeyRequest : String]] = [[.area:""],[.size: "2000"]]
//
//        // When
//        let expectation = XCTestExpectation(description: "Wait for queue change.")
//        apiService.getAPIData(endpointApiForTest, parameters, TemperatureODF?.self, completionHandler: { (apidata, error) in
//            // Then
//            XCTAssertEqual(error, Utilities.ManageError.incorrectDataStruct)
//            XCTAssertNil(apidata)
//            expectation.fulfill()
//        })
//        wait(for: [expectation], timeout: 0.10)
//    }
//    // MARK: - test createRequest
//    func testgetAPIDataGivenJSONWhenDecodeTemperatureODFThenAPIDecoded() {
//        //given
//        let apiService = APIServiceFake(json: FakeResponseData.temperatureStationJsonCorrectData!)
//        let parameters: [[KeyRequest : String]] = [
//            [.stationCode: codeStation],
//            [.sort:"desc"],[.size: "5000"]]
//
//        let parameters = [
//            "q": "chicken, milk, butter, orange","app_id": "8faa6a6a",
//            "app_key":"317afa76457341d40ce4ad77afcdfa8e",
//            "from": String(0),
//            "to": String(10)
//        ] as [String : String]
//        //when
//        let expectation = XCTestExpectation(description: "Wait for queue change.")
//        apiService.getAPIData(endpointApiForTest, parameters, TemperatureODF?.self, completionHandler: { (apidata, error) in
//            XCTAssertNil(error)
//            XCTAssertEqual(apidata, FakeResponseData.responseEdamamOK)
//            expectation.fulfill()
//        })
//        wait(for: [expectation], timeout: 0.10)
//    }
//
//    func testgetAPIDataGivenJSONWhenDecodePiezometryODFThenAPIDecoded() {
//        //given
//        let apiService = APIServiceFake(json: FakeResponseData.piezometryValueJsonCorrectData!)
//        let parameters: [[KeyRequest : String]] = [
//            [.stationCode: codeStation],
//            [.sort:"desc"],[.size: "5000"]]
//
//        //when
//        let expectation = XCTestExpectation(description: "Wait for queue change.")
//        apiService.getAPIData(endpointApiForTest, parameters, PiezometryODF?.self, completionHandler: { (apidata, error) in
//            XCTAssertNil(error)
//            XCTAssertEqual(apidata![0], FakeResponseData.responseRecipeOK)
//            expectation.fulfill()
//        })
//        wait(for: [expectation], timeout: 0.10)
//    }
}

