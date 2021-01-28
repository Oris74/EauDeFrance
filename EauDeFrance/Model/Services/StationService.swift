//
//  StationService.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 14/01/2021.
//

import Foundation

class StationService {

    static let shared = StationService()

    private var networkService: NetworkProtocol

    var service: Service
    //var place: Place

    private init() {
        self.service = .hydrometrie
        self.networkService = NetworkService.shared
    }

    init(networkService: NetworkService, service: Service) {
        self.networkService =  networkService
        self.service = service
    }

    internal func getStations(codeDept: String?, callback: @escaping ([StationODF]?, Utilities.ManageError? ) -> Void) {

        let parameters = ["code_departement": codeDept]
        var stationODF: [StationODF] = []

        let apiURL = service.getApiURL()
        print(apiURL)
        //let structAPI = service.getApiStruct()
        networkService.getAPIData(
            apiURL, parameters, ApiHubeauHeader<HydrometryHubeau>?.self, completionHandler: {[weak self]  (apidata, error) in
                guard let depackedAPIData = apidata, let stations = depackedAPIData.data else {
                    return callback(nil, error)
                }

                for stationAPI in stations {
                    if let station = self?.service.bridgeStation(resultAPI: stationAPI) {
                        stationODF.append(station)
                    }
                }
                callback(stationODF, nil)
                return
            })
    }
}
