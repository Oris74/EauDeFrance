//
//  StationService.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 14/01/2021.
//

import Foundation
class StationService {

    static let shared = StationService()

    private let apiService: APIProtocol
    private var stations = [StationODF]()

    var service: Service
    
    private var stationURL: URL? {
     //   switch service.api() {
        switch String(describing:service) {
        case "temperature":
            //apiStruct = TemperatureHubeau.self as AnyObject
            return URL(string: "https://hubeau.eaufrance.fr/api/v1/\(String(describing:service))/station?")!
        case "qualite_rivieres":
            return URL(string: "https://hubeau.eaufrance.fr/api/v1/\(String(describing:service))/station_pc??")!
        case "niveau_nappes":
            return URL(string: "https://hubeau.eaufrance.fr/api/v1/\(String(describing:service))/stations?")!
        case "hydrometrie": return URL(string: "https://hubeau.eaufrance.fr/api/v1/\(String(describing:service))/referentiel/stations?")!
        default:
            return nil
        }
    }

    private init() {
        self.service = .hydrometrie
        self.apiService = APIService.shared
    }

    init(apiService: APIProtocol, service: Service) {
        self.apiService =  apiService
        self.service = service
    }

    internal func getStations(codeDept: String?, callback: @escaping ([StationODF]?, Utilities.ManageError? ) -> Void) {

        let parameters = ["code_departement": codeDept]
        self.stations = []

        apiService.getAPIData(
            stationURL, parameters, ApiHubeauHeader<HydrometryHubeau>?.self, completionHandler: {[weak self]  (apidata, error) in
                guard let depackedAPIData = apidata, let stations = depackedAPIData.data else {
                    return callback(nil, error)
                }

                for stationAPI in stations {
                    if let station = self?.bridgeStation(resultAPI: stationAPI) {
                        self?.stations.append(station)
                    }
                }
                callback(self?.stations, nil)
                return
            })
    }
    private func bridgeStation(resultAPI: Any ) -> StationODF? {
        let stationODF: StationODF?

        switch resultAPI {
        case let depackedStation as TemperatureHubeau:
            stationODF = StationODF.init(
                service: String(describing:service),
                stationID: depackedStation.codeStation,
                stationLabel: depackedStation.libelleStation,
                uriStation: depackedStation.uriStation,
                localization: depackedStation.localisation,
                coordinateX: depackedStation.coordonneeX,
                coordinateY: depackedStation.coordonneeY,
                longitude: depackedStation.longitude,
                latitude: depackedStation.latitude,
                townshipID: depackedStation.codeCommune,
                townshipLabel: depackedStation.libelleCommune,
                countyID: depackedStation.codeDepartement,
                countyLabel: depackedStation.libelleDepartement,
                regionID: depackedStation.codeRegion,
                regionLabel: depackedStation.libelleRegion,
                hydroSectionID: depackedStation.codeTronconHydro,
                streamID: depackedStation.codeCoursEau,
                streamLabel: depackedStation.libelleCoursEau,
                uriStream: depackedStation.uriCoursEau,
               // bodyOfWaterID: depackedStation.codeMasseEau,
               // bodyOfWaterLabel: depackedStation.libelleMasseEau,
               // uriBodyOfWater: depackedStation.uriMasseEau,
                pointKm: depackedStation.pointKm,
                altitude: depackedStation.altitude,
                dateOfUpdtInfos: depackedStation.dateMajInfos
            )
        case let depackedStation as HydrometryHubeau:
            stationODF = StationODF.init(
                service: String(describing:service),
                stationID: depackedStation.codeStation,
                stationLabel: depackedStation.libelleStation,
               // uriStation: depackedStation.uriStation,
                //localization: depackedStation.localisation,
                coordinateX: depackedStation.coordonneeXStation,
                coordinateY: depackedStation.coordonneeYStation,
                longitude: depackedStation.longitude,
                latitude: depackedStation.latitude,
                townshipID: depackedStation.codeCommune,
                townshipLabel: depackedStation.libelleCommune,
                countyID: depackedStation.codeDepartement,
                countyLabel: depackedStation.libelleDepartement,
                regionID: depackedStation.codeRegion,
                regionLabel: depackedStation.libelleRegion,
                //hydroSectionID: depackedStation.codeTronconHydro,
                streamID: depackedStation.codeCoursEau,
                streamLabel: depackedStation.libelleCoursEau,
                uriStream: depackedStation.uriCoursEau,
                //bodyOfWaterID: depackedStation.codeMasseEau,
               // bodyOfWaterLabel: depackedStation.libelleMasseEau,
               // uriBodyOfWater: depackedStation.uriMasseEau,
                //pointKm: depackedStation.pointKm,
               // altitude: depackedStation.altitudeRefAltiStation,
                dateOfUpdtInfos: depackedStation.dateMajStation
            )
      /*  case let depackedStation as PiezometryHubeau:
            stationODF = StationODF.init(
                service: String(describing:service),
                stationID: depackedStation.codeStation,
                stationLabel: depackedStation.libelleStation,
                uriStation: depackedStation.uriStation,
                localization: depackedStation.localisation,
                coordinateX: depackedStation.coordonneeX,
                coordinateY: depackedStation.coordonneeY,
                longitude: depackedStation.longitude,
                latitude: depackedStation.latitude,
                townshipID: depackedStation.codeCommune,
                townshipLabel: depackedStation.libelleCommune,
                countyID: depackedStation.codeDepartement,
                countyLabel: depackedStation.libelleDepartement,
                regionID: depackedStation.codeRegion,
                regionLabel: depackedStation.libelleRegion,
                hydroSectionID: depackedStation.codeTronconHydro,
                streamID: depackedStation.codeCoursEau,
                streamLabel: depackedStation.libelleCoursEau,
                uriStream: depackedStation.uriCoursEau,
                bodyOfWaterID: depackedStation.codeMasseEau,
                bodyOfWaterLabel: depackedStation.libelleMasseEau,
                uriBodyOfWater: depackedStation.uriMasseEau,
                pointKm: depackedStation.pointKm,
                altitude: depackedStation.altitude,
                dateOfUpdtInfos: depackedStation.dateMajInfos)
*/

      /*  case let depackedStation as StreamQualiy:
            stationODF = StationODF.init(
                service: String(describing:service),
                stationID: depackedStation.codeStation,
                stationLabel: depackedStation.libelleStation,
                uriStation: depackedStation.uriStation,
                localization: depackedStation.localisation,
                coordinateX: depackedStation.coordonneeX,
                coordinateY: depackedStation.coordonneeY,
                longitude: depackedStation.longitude,
                latitude: depackedStation.latitude,
                townshipID: depackedStation.codeCommune,
                townshipLabel: depackedStation.libelleCommune,
                countyID: depackedStation.codeDepartement,
                countyLabel: depackedStation.libelleDepartement,
                regionID: depackedStation.codeRegion,
                regionLabel: depackedStation.libelleRegion,
                hydroSectionID: depackedStation.codeTronconHydro,
                streamID: depackedStation.codeCoursEau,
                streamLabel: depackedStation.libelleCoursEau,
                uriStream: depackedStation.uriCoursEau,
                bodyOfWaterID: depackedStation.codeMasseEau,
                bodyOfWaterLabel: depackedStation.libelleMasseEau,
                uriBodyOfWater: depackedStation.uriMasseEau,
                pointKm: depackedStation.pointKm,
                altitude: depackedStation.altitude,
                dateOfUpdtInfos: depackedStation.dateMajInfos
            )*/
        default:
            stationODF = nil
        }
        return stationODF
    }
}
