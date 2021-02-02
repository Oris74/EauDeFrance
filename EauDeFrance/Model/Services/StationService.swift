//
//  StationService.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 14/01/2021.
//

import Foundation

class StationService  {

    static var shared = StationService()

    var temperature:Temperature?
    var piezometry: Piezometry?

    var current: ManageService

    init() {
        self.current = Temperature()
    }


  //  internal func getStations(codeDept: String?, callback: @escaping ([StationODF]?, Utilities.ManageError? ) -> Void) {
//
//        let parameters = ["code_departement": codeDept]
//        var stationODF: [StationODF] = []
//        //let structAPI = service.getApiStruct()
//        let service = Temperature()
//        let api = service.apiStruct
//        networkService.getAPIData(
//            service.stationURL, parameters, ApiHubeauHeader, completionHandler: {[weak self]  (apidata, error) in
//                guard let depackedAPIData = apidata, let stations = depackedAPIData.data else {
//                    return callback(nil, error)
//                }
//
//                for stationAPI in stations {
//                    if let station = self?.service.bridgeStation(resultAPI: stationAPI) {
//                        stationODF.append(station)
//                    }
//                }
//                callback(stationODF, nil)
//                return
//            })
//    }
}
