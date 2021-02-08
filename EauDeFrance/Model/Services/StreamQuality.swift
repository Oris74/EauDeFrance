//
//  StreamQuality.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 29/01/2021.
//

import Foundation

class StreamQuality: ManageService {
    static var shared = StreamQuality()
    
    internal var stationURL = URL(string: "https://hubeau.eaufrance.fr/api/v1/qualite_rivieres/station_pc?")!

    internal var apiFigureURL = URL(string: "https://hubeau.eaufrance.fr/api/v1/qualite_rivieres/analyse_pc??")!

    let serviceName = "Qualité rivières"
    let apiName = "qualite_rivieres"

    var networkService: NetworkProtocol = NetworkService.shared

   init() {
    }

    func getStations(codeDept: String, callback: @escaping ([StationODF]?, Utilities.ManageError? ) -> Void) {

        let parameters = ["code_departement": codeDept]
        var stationODF: [StationODF] = []
        networkService.getAPIData(
            stationURL, parameters, ApiHubeauHeader<QualityStreamHubeau>?.self, completionHandler: {[weak self]  (apidata, error) in
                guard let depackedAPIData = apidata, let stations = depackedAPIData.data else {
                    return callback(nil, error)
                }

                for stationAPI in stations {
                    if let station = self?.bridgeStation(station: stationAPI) {
                        stationODF.append(station)
                    }
                }
                callback(stationODF, nil)
                return
            })
    }
    private func bridgeStation(station: QualityStreamHubeau)-> QualityStreamODF? {
        let stationODF: QualityStreamODF?
            stationODF = QualityStreamODF.init(
                hardness: station.durete,
                streamCode: station.codeCoursEau,
                streamLabel: station.nomCoursEau,
                uriStream: station.uriCoursEau,
                stationCode: station.codeStation ?? "",
                stationLabel: station.libelleStation ?? "",
                uriStation: station.uriStation ?? "",
                longitude: station.longitude ?? 0.0,
                latitude: station.latitude ?? 0.0,
                townshipCode: station.codeCommune ?? "",
                townshipLabel: station.libelleCommune ?? "",
                countyCode: station.codeDepartement ?? "",
                countyLabel: station.libelleDepartement ?? "",
                altitude: String(format: "%.f", station.altitudePointCaracteristique ?? " - "),
                dateUPDT: station.dateMajInformation ?? "",
                bodyOfWaterCode: station.codeMasseDeau ?? "",
                bodyOfWaterLabel: station.nomMasseDeau ?? "",
                uriBodyOfWater: station.uriMasseDeau ?? "",
                regionLabel: station.libelleRegion,
                regionCode: station.codeRegion,
                subBasinCode: station.codeEuSousBassin,
                basinLabel:station.nomBassin,
                subBasinLabel: station.nomSousBassin,
                basinCode: station.codeEuSousBassin,
                uriBasin: station.uriBassin,
                pointKM: station.pointKilometrique,
                hydroEntityType: station.typeEntiteHydro,
                comment: station.commentaire,
                creationDate: station.dateCreation,
                endDate: station.dateArret,
                finality: station.finalite,
                preciseLocation: station.localisationPrecise,
                nature: station.nature
        )
        return stationODF
    }
}
