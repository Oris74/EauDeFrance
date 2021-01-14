//
//  StationService.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 14/01/2021.
//

import Foundation
class StationService: NetworkServices {

    static let shared = StationService()
    static var service: string

    private var station = [Station]()

    private var task: URLSessionDataTask?

    private var session = URLSession(configuration: .default)

    private override init(){
        self.service = "temperature"
    }

    init(session: URLSession = URLSession(configuration: .default), service: String) {
        self.session = session
        self.service = service
        super.init()
    }

    private  let stationUrl =
        URL(string:
                "https://hubeau.eaufrance.fr/api/v1/\( service)/station?")!


    ///entry point for data importation  of exchange rate conversion module
    func getStations(codeDept:String?, area: BoxZone? callback: @escaping (Utilities.ManageError?, Station?) -> Void) {

        let queryItems = [URLQueryItem(name: "code_departement", value: codeDept)]        //buildQueryItems(text: text, source: source, target: target)

        let request = createRequest(url: stationUrl, queryItems: queryItems)

        // prevent two identical tasks
        task?.cancel()

        task = session.dataTask(with: request) {[weak self] (data, response, error) in
            DispatchQueue.main.async {
                self?.carryOutData(
                    Station?.self,
                    data, response, error,
                    completionHandler: {(station, errorCode) in
                        callback(errorCode, station)
                    })
            }
        }
        task?.resume()
    }

    private func buildQueryItems(codeDept: String) -> [URLQueryItem] {
        return [
            URLQueryItem(name: "code_departement", value: codeDept),
            URLQueryItem(name: "source", value: source),
            URLQueryItem(name: "target", value: target)
        ]
    }
}
