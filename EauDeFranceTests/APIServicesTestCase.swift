//
//  APIServicesTestCase.swift
//  EauDeFranceTests
//
//  Created by Laurent Debeaujon on 09/03/2021.
//
import XCTest
@testable import EauDeFrance

class APIServicesTestCase: XCTestCase {
    private var endpointApiForTest = URL(string:"")!

    func testgetAPIDataGivenJSONWhenDecodeTemperatureHubeauThenFailedAPIDecoded() {
        // Given
        let apiService = APIServiceFake(json: FakeResponseData.incorrectData)
        let parameters = [

        ] as [String : String]
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        apiService.getAPIData(endpointApiForTest, parameters, TemperatureODF?.self, completionHandler: { (apidata, error) in
            // Then
            XCTAssertEqual(error, Utilities.ManageError.incorrectDataStruct)
            XCTAssertNil(apidata)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.10)
    }
    // MARK: - test createRequest
    func testgetAPIDataGivenJSONWhenDecodeEdamamThenAPIDecoded() {
        //given
        let apiService = APIServiceFake(json: FakeResponseData.edamamJsonCorrectData!)
        let parameters = [
            "q": "chicken, milk, butter, orange","app_id": "8faa6a6a",
            "app_key":"317afa76457341d40ce4ad77afcdfa8e",
            "from": String(0),
            "to": String(10)
        ] as [String : String]
        //when
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        apiService.getAPIData(endpointApiForTest, parameters, Edamam?.self, completionHandler: { (apidata, error) in
            XCTAssertNil(error)
            XCTAssertEqual(apidata, FakeResponseData.responseEdamamOK)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.10)
    }

    func testgetAPIDataGivenJSONWhenDecodeRecipeEdamamThenAPIDecoded() {
        //given
        let apiService = APIServiceFake(json: FakeResponseData.recipeEdamamJsonCorrectData!)
        let parameters = [
            "r": "http://www.edamam.com/ontologies/edamam.owl#recipe_b79327d05b8e5b838ad6cfd9576b30b6",
            "app_id": "8faa6a6a",
            "app_key":"317afa76457341d40ce4ad77afcdfa8e"
        ] as [String : String]
        //when
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        apiService.getAPIData(endpointApiForTest, parameters, [Recipe]?.self, completionHandler: { (apidata, error) in
            XCTAssertNil(error)
            XCTAssertEqual(apidata![0], FakeResponseData.responseRecipeOK)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.10)
    }
}

