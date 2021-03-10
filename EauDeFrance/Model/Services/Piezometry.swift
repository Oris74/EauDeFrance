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

    internal var figureURL = URL(string: "https://hubeau.eaufrance.fr/api/v1/niveaux_nappes/chroniques_tr?")!

    let networkService: NetworkProtocol = NetworkService.shared
    let postalCodeFrance = ManagePostalCode.shared
    let serviceName = "Piezométrie"
    let apiName = "niveaux_nappes"

    init() { }

    func getStation(parameters: [[KeyRequest:String]], callback: @escaping ([StationODF]?, Utilities.ManageError?) -> Void) {
        var param: [[KeyRequest:String]] = [[.activityFrom:"2000-01-01"]]
        param += parameters

            networkService.getAPIData(
                stationURL, param, ApiHubeauHeader<PiezometryHubeau>?.self, completionHandler: {[weak self]  (apidata, error) in
                    guard let depackedAPIData = apidata, let stations = depackedAPIData.data else {
                        return callback(nil, error)
                    }
                    var stationODF: [PiezometryODF] = []

                    for station in stations {
                        if let station = self?.bridgeStation(station: station) {
                            stationODF.append(station)
                        }
                    }
                    stationODF.sort (by: {$0.townshipLabel < $1.townshipLabel})
                    callback(stationODF, nil)
                    return
                })
        }

    func getFigure(codeStation: String, callback: @escaping ([Measure], Utilities.ManageError?) -> Void) {
        let parameters: [[KeyRequest : String]] = [
            [.stationPiezo: codeStation],
            [.sort:"desc"],[.size: "5000"]]

        networkService.getAPIData(
            figureURL, parameters, ApiHubeauHeader<PiezometryHubeauValue>?.self, completionHandler: { (apidata, error) in
                guard let depackedAPIData = apidata, let apiFigures = depackedAPIData.data else {
                    return callback([], error)
                }

                var measures: [Measure] = []

                for figure in apiFigures {
                    let measure = Measure(timestamp: figure.dateMesure, value: figure.niveauEauNgf, unit: " m (ngf) ")
                    if !measures.contains(where: {$0.date == measure.date}) {
                        measures.append(measure)
                    }
                }
                measures.sort {$0.date < $1.date}
                callback(measures, nil)
                return
            })
    }

    private func bridgeStation(station: PiezometryHubeau) -> PiezometryODF? {
        var postalCode :String
        if let codeInsee = station.codeCommuneInsee {
             postalCode = postalCodeFrance.getPostalCode(withInsee: codeInsee) ?? "\(codeInsee)(Code INSEE)"
        } else {
             postalCode = ""
        }

        let stationODF = PiezometryODF(
            stationCode: station.codeBss ?? "non renseignée",
            stationLabel: station.libellePe ?? "non renseignée",
            uriStation: station.urnBss ?? "non renseignée",
            longitude: station.longitude ?? 0.0,
            latitude: station.latitude ?? 0.0,
            townshipCode: station.codeCommuneInsee ?? "non renseignée",
            codePostal: postalCode,
            townshipLabel: station.nomCommune ?? "non renseignée",
            countyCode: station.codeDepartement ?? "non renseignée",
            countyLabel: station.nomDepartement ?? "non renseignée",
            bodyOfWaterCode: station.codesMasseEauEdl ?? ["non renseignée"],
            bodyOfWaterLabel: station.nomsMasseEauEdl ?? ["non renseignée"],
            uriBodyOfWater: station.urnsMasseEauEdl ?? ["non renseignée"],
            depthOfInvestigation: station.profondeurInvestigation ?? 0.0,
            nbPiezoMeasurement:  station.nbMesuresPiezo ?? 0,
            bssId: station.bssId ?? "non renseignée",
            urnsBdLisa: station.urnsBdlisa ?? ["non renseignée"],
            bdLisaCode: station.codesBdlisa ?? ["non renseignée"],
            startMeasurementDate: station.dateDebutMesure ?? "non renseignée",
            endMeasurementDate: station.dateFinMesure ?? "non renseignée",
            altitude: station.altitudeStation ?? "non renseignée",
            dateUPDT: station.dateDebutMesure ?? "non renseignée")
        return stationODF
    }
}
