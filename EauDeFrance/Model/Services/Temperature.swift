//
//  File.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 28/01/2021.
//

import Foundation

class Temperature: ManageService {

    static var shared = Temperature()
    
    let stationURL = URL(string: "https://hubeau.eaufrance.fr/api/v1/temperature/station?")!

    let apiFigureURL = URL(string: "https://hubeau.eaufrance.fr/api/v1/temperature/chronique?")!

    var networkService: NetworkProtocol = NetworkService.shared

    let apiName = "Temperature"
    let serviceName = "Température"

    init(){}
    func getStations(codeDept: String, callback: @escaping ([StationODF]?, Utilities.ManageError? ) -> Void) {

        let parameters = ["code_departement": codeDept]

        networkService.getAPIData(
            stationURL, parameters, ApiHubeauHeader<TemperatureHubeau>.self, completionHandler: {[weak self]  (apidata, error) in
                guard let depackedAPIData = apidata, let stations = depackedAPIData.data else {
                    return callback(nil, error)
                }
                var stationODF: [TemperatureODF] = []
                for stationAPI in stations {
                    if let station = self?.bridgeStation(station: stationAPI) {
                        stationODF.append(station)
                    }
                }
                callback(stationODF, nil)
                return
            })
    }

    private func bridgeStation(station: TemperatureHubeau ) -> TemperatureODF? {
        let stationODF: TemperatureODF?
        stationODF = TemperatureODF.init(
            stationCode: station.codeStation,
            stationLabel: station.libelleStation,
            uriStation: station.uriStation,
            localization: station.localisation,
            //coordinateX: station.coordonneeX,
            //coordinateY: station.coordonneeY,
            streamCode: station.codeCoursEau,
            streamLabel: station.libelleCoursEau,
            uriStream: station.uriCoursEau,
            hydroSectionCode: station.codeTronconHydro,
            longitude: station.longitude,
            latitude: station.latitude,
            townshipCode: station.codeCommune,
            townshipLabel: station.libelleCommune,
            countyCode: station.codeDepartement,
            countyLabel: station.libelleDepartement,
            altitude: String(format: "0.0", station.altitude ?? ""),
            dateUPDT: station.dateMajInfos,
            bodyOfWaterCode: station.codeMasseEau,
            bodyOfWaterLabel: station.libelleMasseEau,
            uriBodyOfWater: station.uriMasseEau,
            regionLabel: station.libelleRegion,
            regionCode: station.codeRegion,
            subBasinCode: station.codeSousBassin,
            basinLabel: station.libelleBassin,
            subBasinLabel: station.libelleSousBassin,
            basinCode: station.codeBassin,
            uriBasin: String(format: "0.0", station.altitude ?? 0.0),
            pointKM: station.dateMajInfos
        )
        return stationODF
    }
}
