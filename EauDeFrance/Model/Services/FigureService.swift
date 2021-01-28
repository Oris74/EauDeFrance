//
//  FigureService.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 26/01/2021.
//

import Foundation
class FigureService {

    static let shared = FigureService()

    private(set) var station:StationODF?
    private var networkService: NetworkProtocol

    var stationService = StationService.shared

    private init() {
        self.networkService = NetworkService.shared
    }

    init(networkService: NetworkService, service: Service) {
        self.networkService =  networkService
        //self.service = service
    }

//    internal func getFigures( parameter: String?, callback: @escaping ([FigureServiceODF]?, Utilities.ManageError? ) -> Void) {
//
//        let parameters = ["code_departement": "74"]
//        let apiURL = stationService.service.getApiURL()
//        print(apiURL)
//        //let structAPI = service.getApiStruct()
//        networkService.getAPIData(
//            apiURL, parameters, ApiHubeauHeader<HydrometryHubeau>?.self, completionHandler: {[weak self]  (apidata, error) in
//                guard let depackedAPIData = apidata, let stations = depackedAPIData.data else {
//                    return callback(nil, error)
//                }
//
//                for stationAPI in stations {
//                    if let station = self?.service.bridgeFigure(resultAPI: stationAPI) {
//                        self?.stations.append(station)
//                    }
//                }
//                callback(self?.stations, nil)
//                return
//            })
//    }
}
