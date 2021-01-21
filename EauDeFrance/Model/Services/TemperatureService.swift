//
//  TemperatureServices.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 14/01/2021.
//

import Foundation
/*
class TemperatureService {

    static let shared = TemperatureService()

    private let apiService: APIProtocol
    private var temperatureODF = [TemperatureODF]()
    private let temperatureURL: URL

    private init() {
        self.apiService = APIService.shared
        self.temperatureURL = URL(string:
                            "https://hubeau.eaufrance.fr/api/v1/temperature/chronique?code_station=04051125&size=5&sort=desc&pretty?")!
}

init(apiService: APIProtocol, station: String) {
    self.apiService =  apiService
    self.temperatureURL = URL(string: "https://hubeau.eaufrance.fr/api/v1/temperature/chronique?")!
}
    private  let temperatureUrl =
        URL(string:
            "https://hubeau.eaufrance.fr/api/v1/temperature")!

    ///entry point for data importation  of exchange rate conversion module
    func getTemperatures(stationID: String, callback: @escaping ( [TemperatureODF]?, Utilities.ManageError?) -> Void) {

        let queryItems = buildQueryItems(stationID: stationID)

        let request = createRequest(url: temperatureUrl, queryItems: queryItems)

        // prevent two identical tasks
        task?.cancel()

        task = session.dataTask(with: request) {[weak self] (data, response, error) in
            DispatchQueue.main.async {
                self?.carryOutData(
                    TemperatureHubeau?.self,
                    data, response, error,
                    completionHandler: {(temperature, errorCode) in
                    callback(temperature, errorCode)
                })
            }
        }
        task?.resume()
    }
    
    private func buildQueryItems(stationID: String) -> [URLQueryItem] {
        return [
            URLQueryItem(name: "code_station", value: stationID)

        ]
    }
}
*/
