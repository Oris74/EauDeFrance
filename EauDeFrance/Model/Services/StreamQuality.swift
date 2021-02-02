//
//  StreamQuality.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 29/01/2021.
//

import Foundation

class StreamQuality {
//
//    private var stationURL = URL(string: "https://hubeau.eaufrance.fr/api/v1/qualite_rivieres/station_pc?")!
//
//    private var apiFigureURL = URL(string: "https://hubeau.eaufrance.fr/api/v1/qualite_rivieres/analyse_pc??")!
//
////    override init(networkService: NetworkService) {
////        super.init(networkService: networkService)
////    }
//
//    override func getStations(codeDept: String?, callback: @escaping ([StationODF]?, Utilities.ManageError? ) -> Void) {
//
//        let parameters = ["code_departement": codeDept]
//        var stationODF: [StationODF] = []
//        networkService.getAPIData(
//            stationURL, parameters, ApiHubeauHeader<StreamQualityHubeau>.self, completionHandler: {[weak self]  (apidata, error) in
//                guard let depackedAPIData = apidata, let stations = depackedAPIData.data else {
//                    return callback(nil, error)
//                }
//
//                for stationAPI in stations {
//                    if let station = self?.bridgeStation(station: stationAPI) {
//                        stationODF.append(station)
//                    }
//                }
//                callback(stationODF, nil)
//                return
//            })
//    }
//    private func bridgeStation(station: StreamQualityHubeau)-> StationODF? {
//        let stationODF: StationODF?
//        stationODF = StationODF.init(
//            stationID: station.codeStation,
//            stationLabel: station.libelleStation,
//            uriStation: station.uriStation,
//            localization: station.localisationPrecise,
//            coordinateX: station.coordonneeX,
//            coordinateY: station.coordonneeY,
//            longitude: station.longitude,
//            latitude: station.latitude,
//            townshipID: station.codeCommune,
//            townshipLabel: station.libelleCommune,
//            countyID: station.codeDepartement,
//            countyLabel: station.libelleDepartement,
//            regionID: station.codeRegion,
//            regionLabel: station.libelleRegion,
//            hydroSectionID: nil, //station..codeTronconHydro,
//            streamID: station.codeCoursEau,
//            streamLabel: station.nomCoursEau,
//            uriStream: station.uriCoursEau,
//            uriBodyOfWater: nil, bodyOfWaterLabel: nil, bodyOfWaterID: nil,//station.uriMasseDeau,
//            pointKm: station.pointKilometrique,
//            altitude: station.altitudePointCaracteristique,
//            dateOfUpdtInfos: station.dateMajInformation
//        )
//        return stationODF
//    }
}
