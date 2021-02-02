//
//  Hydrology.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 28/01/2021.
//

import Foundation

class Hydrometry {
//
//    private var jsonStruct : ApiHubeauHeader<HydrometryHubeau>
//
//    private let stationURL = URL(string: "https://hubeau.eaufrance.fr/api/v1/hydrometrie/referentiel/stations?")!
//
//    private let apiFigureURL = URL(string: "https://hubeau.eaufrance.fr/api/v1/hydrometrie/referentiel/observation_tr?")!
//
//
////    override init(networkService: NetworkService) {
////        super.init(networkService: networkService)
////    }
//
//     func getStations(codeDept: String?, callback: @escaping ([StationODF]?, Utilities.ManageError? ) -> Void) {
//
//            let parameters = ["code_departement": codeDept]
//            var stationODF: [StationODF] = []
//            networkService.getAPIData(
//                stationURL, parameters, ApiHubeauHeader<HydrometryHubeau>.self, completionHandler: {[weak self]  (apidata, error) in
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
//    private func bridgeStation(station: HydrometryHubeau ) -> StationODF? {
//        let stationODF: StationODF?
//        stationODF = StationODF.init(
//                     stationID: station.codeStation,
//                     stationLabel: station.libelleStation,
//                     // uriStation: station.uriStation,
//                     //localization: station.localisation,
//                     coordinateX: station.coordonneeXStation,
//                     coordinateY: station.coordonneeYStation,
//                     longitude: station.longitude,
//                     latitude: station.latitude,
//                     townshipID: station.codeCommune,
//                     townshipLabel: station.libelleCommune,
//                     countyID: station.codeDepartement,
//                     countyLabel: station.libelleDepartement,
//                     regionID: station.codeRegion,
//                     regionLabel: station.libelleRegion,
//                     //hydroSectionID: depackedStation.codeTronconHydro,
//                     streamID: station.codeCoursEau,
//                     streamLabel: station.libelleCoursEau,
//                     uriStream: station.uriCoursEau,
//                     //bodyOfWaterID: depackedStation.codeMasseEau,
//                     // bodyOfWaterLabel: depackedStation.libelleMasseEau,
//                     // uriBodyOfWater: depackedStation.uriMasseEau,
//                     //pointKm: depackedStation.pointKm,
//                     altitude: String(format: "0.0", station.altitudeRefAltiStation ?? 0.0),
//                     dateOfUpdtInfos: station.dateMajStation
//                 )
//           
//            return stationODF
//        }
}
