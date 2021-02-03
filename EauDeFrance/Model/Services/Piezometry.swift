//
//  Piezometry.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 29/01/2021.
//

import Foundation

class Piezometry: ManageService {

    static var shared = Piezometry()

    internal var stationURL =  URL(string: "https://hubeau.eaufrance.fr/api/v1/niveaux_nappes/stations?")!

    internal var apiFigureURL = URL(string: "https://hubeau.eaufrance.fr/api/v1/niveaux_nappes/chroniques?")!


    var networkService: NetworkProtocol = NetworkService.shared
    
    let serviceName = "Piezométrie"
    let apiName = "niveaux_nappes"

    init() { }

    func getStations(codeDept: String, callback: @escaping ([StationODF]?, Utilities.ManageError? ) -> Void) {

            let parameters = ["code_departement": codeDept]
            var stationODF: [PiezometryODF] = []
            networkService.getAPIData(
                stationURL, parameters, ApiHubeauHeader<PiezometryHubeau>.self, completionHandler: {[weak self]  (apidata, error) in
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
    private func bridgeStation(station: PiezometryHubeau)-> PiezometryODF? {
        let stationODF: PiezometryODF?
        stationODF = PiezometryODF.init(
            stationCode: station.codeBss,
            stationLabel: station.libellePe,
            uriStation: station.bssId,
            longitude: station.longitude,
            latitude: station.latitude,
            townshipCode: station.codeCommuneInsee,
            townshipLabel: station.nomCommune,
            countyCode: station.codeDepartement,
            countyLabel: station.nomDepartement,
            bodyOfWaterCode: station.codesMasseEauEdl,
            bodyOfWaterLabel: station.nomsMasseEauEdl,
            uriBodyOfWater: station.urnsMasseEauEdl,
            depthOfInvestigation: station.profondeurInvestigation,
            nbPiezoMeasurement:  station.nbMesuresPiezo,
            bssId: station.bssId,
            urnsBdLisa: station.urnsBdlisa,
            bdLisaCode: station.codesBdlisa,
            startMeasurementDate: station.dateDebutMesure,
            endMeasurementDate: station.dateFinMesure,
            altitude: String(format: "0.0", station.altitudeStation ?? 0),
            dateUPDT: station.dateDebutMesure)
        return stationODF
    }
}
