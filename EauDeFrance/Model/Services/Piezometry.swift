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

    internal var figureURL = URL(string: "https://hubeau.eaufrance.fr/api/v1/niveaux_nappes/chroniques?")!


    var networkService: NetworkProtocol = NetworkService.shared
    
    let serviceName = "Piezométrie"
    let apiName = "niveaux_nappes"

    init() { }

    func getStation(parameters: [[KeyRequest:String]], callback: @escaping ([StationODF]?, Utilities.ManageError?) -> Void) {

            networkService.getAPIData(
                stationURL, parameters, ApiHubeauHeader<PiezometryHubeau>?.self, completionHandler: {[weak self]  (apidata, error) in
                    guard let depackedAPIData = apidata, let stations = depackedAPIData.data else {
                        return callback(nil, error)
                    }
                    var stationODF: [PiezometryODF] = []

                    for station in stations {
                        if let station = self?.bridgeStation(station: station) {
                            stationODF.append(station)
                        }
                    }
                    callback(stationODF, nil)
                    return
                })
        }


    func getFigure(station: StationODF, callback: @escaping (StationODF?, ManageODFapi?, Utilities.ManageError?) -> Void) {

        let parameters: [[KeyRequest : String]] = [[.stationPiezo:station.stationCode],[.size:"50"],
            [.sort:"desc"]]

        networkService.getAPIData(
            stationURL, parameters, ApiHubeauHeader<PiezometryHubeauValue>?.self, completionHandler: {[weak self]  (apidata, error) in
                guard let depackedAPIData = apidata, let apiFigures = depackedAPIData.data else {
                    return callback(nil,nil, error)
                }
                let statusAPI = ManageODFapi(count: depackedAPIData.count, first: depackedAPIData.first, last: depackedAPIData.last, prev: depackedAPIData.prev, next: depackedAPIData.next, apiVersion: depackedAPIData.apiVersion)

                guard let serviceODF = station as? PiezometryODF else {
                    return callback(nil, nil, Utilities.ManageError.incorrectDataStruct)
                }

                for figure in apiFigures {
                    if let figureODF = self?.bridgeFigureODF(api:  figure) {
                        serviceODF.figure?.append(figureODF)
                    }
                }
                callback(station, statusAPI, nil)
                return
            })
    }

    private func bridgeFigureODF(api: PiezometryHubeauValue) -> PiezometryODFValue {
        let figure = PiezometryODFValue(measureDate: api.dateMesure, timestampMeasure: api.timestampMesure, groundwaterLevel: api.niveauNappeEau, obtainingMode: api.modeObtention, status: api.statut, qualification: api.qualification, continuationCode: api.codeContinuite, continuationName: api.nomContinuite, producerCode: api.codeProducteur, producerName: api.nomProducteur, typeMeasureCode: api.codeNatureMesure, nameTypeMeasure: api.nomNatureMesure, waterTableDepth: api.profondeurNappe)
        return figure
    }
    private func bridgeStation(station: PiezometryHubeau) -> PiezometryODF? {

        let stationODF = PiezometryODF(
            stationCode: station.codeBss ?? "",
            stationLabel: station.libellePe ?? "",
            uriStation: station.bssId ?? "",
            longitude: station.longitude ?? 0.0,
            latitude: station.latitude ?? 0.0,
            townshipCode: station.codeCommuneInsee ?? "",
            townshipLabel: station.nomCommune ?? "",
            countyCode: station.codeDepartement ?? "",
            countyLabel: station.nomDepartement ?? "",
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
            altitude: String(format: "%.f", station.altitudeStation ?? " - "),
            dateUPDT: station.dateDebutMesure ?? "")
        return stationODF
    }
}
