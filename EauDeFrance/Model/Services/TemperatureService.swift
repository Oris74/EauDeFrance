//
//  TemperatureServices.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 14/01/2021.
//

import Foundation


class TemperatureService: NetworkServices {

    static let shared = TemperatureService()

    private var task: URLSessionDataTask?

    private var session = URLSession(configuration: .default)

    init(temperatureSession: URLSession = URLSession(configuration: .default)) {
        self.session = temperatureSession
        super.init()
    }

    private  let temperatureUrl =
        URL(string:
            "https://hubeau.eaufrance.fr/api/v1/temperature")!

    ///entry point for data importation  of exchange rate conversion module
    func getTemperature(callback: @escaping (Utilities.ManageError?, Temperature?) -> Void) {

        let queryItems = buildQueryItems(key: keyGoogleTranslate, text: text, source: source, target: target)

        let request = createRequest(url: temperatureUrl, queryItems: queryItems)

        // prevent two identical tasks
        task?.cancel()

        task = session.dataTask(with: request) {[weak self] (data, response, error) in
            DispatchQueue.main.async {
                self?.carryOutData(
                    TemperatureHubeau?.self,
                    data, response, error,
                    completionHandler: {(temperature, errorCode) in
                    callback(errorCode, temperature)
                })
            }
        }
        task?.resume()
    }
    
    private func buildQueryItems(key: String, text: String, source: String, target: String) -> [URLQueryItem] {
        return [
            URLQueryItem(name: "key", value: key),
            URLQueryItem(name: "q", value: text),
            URLQueryItem(name: "source", value: source),
            URLQueryItem(name: "target", value: target)
        ]
    }
}
