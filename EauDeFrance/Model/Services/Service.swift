//
//  Station.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 28/01/2021.
//

//import Foundation
//
//class Service {
//
//    var networkService: NetworkProtocol
//
//    private var stationURL = URL(string: "https://hubeau.eaufrance.fr/api/v1/temperature/station?")!
//
//    private init() {
//        self.networkService = NetworkService.shared
//    }
//    init(networkService: NetworkService) {
//        self.networkService =  networkService
//    }
//    internal func getStations(codeDept: String?, callback: @escaping ([StationODF]?, Utilities.ManageError? ) -> Void) {
//
//            let parameters = ["code_departement": codeDept]
//            var stationODF: [StationODF] = []
//            networkService.getAPIData(
//                stationURL, parameters, ApiHubeauHeader<TemperatureHubeau>.self, completionHandler: {[weak self]  (apidata, error) in
//                    guard let depackedAPIData = apidata, let stations = depackedAPIData.data else {
//                        return callback(nil, error)
//                    }
//
//                    for stationAPI in stations {
//                        if let station = self?.bridgeStation(station: stationAPI) {
//                            stationODF.append(station)
//                        }
//                    }
//                    callback(stationODF, nil)
//                    return
//                })
//        }
//
//    func bridgeStation(station: TemperatureHubeau) ->StationODF? {
//            return nil
//    }
//}
