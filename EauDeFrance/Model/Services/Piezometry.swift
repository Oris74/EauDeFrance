//
//  Piezometry.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 29/01/2021.
//

import Foundation

// MARK: Manage Access to Piezometry API
class Piezometry: Utilities, ManageService  {
    static var shared = Piezometry()
    
    internal var stationURL =  URL(string: "https://hubeau.eaufrance.fr/api/v1/niveaux_nappes/stations?")!
    
    internal var figureURL = URL(string: "https://hubeau.eaufrance.fr/api/v1/niveaux_nappes/chroniques_tr?")!
    
    let networkService: NetworkProtocol
    let postalCodeFrance = ManagePostalCode.shared
    let serviceName = "Piezométrie"
    let apiName = "niveaux_nappes"
    
    init(networkService: NetworkProtocol =  NetworkService.shared) {
        self.networkService = networkService
    }
    
    func getStation(parameters: [[KeyRequest:String]], callback: @escaping ([StationODF]?, Utilities.ManageError?) -> Void) {
        var param: [[KeyRequest:String]] = [[.activityFrom:"2000-01-01"]]
        param += parameters
        
        networkService.getAPIData(
            stationURL, param, ApiHubeauHeader<PiezometryHubeau>?.self, completionHandler: {[weak self]  (apidata, error) in
                guard let depackedAPIData = apidata, let stations = depackedAPIData.data else {  return callback(nil, error) }
                
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
    
    func getFigure(stationCode: String, callback: @escaping ([Measure], Utilities.ManageError?) -> Void) {
        let parameters: [[KeyRequest : String]] = [
            [.stationPiezo: stationCode],
            [.sort:"desc"],[.size: "5000"]]
        
        networkService.getAPIData(
            figureURL, parameters, ApiHubeauHeader<PiezometryHubeauValue>?.self, completionHandler: { (apidata, error) in
                guard let depackedAPIData = apidata, let apiFigures = depackedAPIData.data else { return callback([], error) }
                
                var measures: [Measure] = []
                
                for figure in apiFigures {
                    let measure = Measure(timestamp: figure.dateMesure, value: figure.niveauEauNgf, unit: " m (ngf) ")
                    if !measures.contains(where: {$0.date == measure.date}) {
                        measures.append(measure)
                    }
                }
                measures.sort {$0.date < $1.date}
                if measures.count > 0 {
                    callback(measures, nil)
                }  else {
                    callback([], Utilities.ManageError.missingData)
                }
                return
            })
    }
    
    private func bridgeStation(station: PiezometryHubeau) -> PiezometryODF? {
        var postalCode :String = ""
        if let codeInsee = station.codeCommuneInsee {
            postalCode = postalCodeFrance.getPostalCode(withInsee: codeInsee)
        }
        
        let stationODF = PiezometryODF(
            stationCode: station.codeBss ?? ManageError.missingData.rawValue,
            stationLabel: station.libellePe ?? ManageError.missingData.rawValue,
            longitude: station.longitude ?? 0.0,
            latitude: station.latitude ?? 0.0,
            townshipCode: station.codeCommuneInsee ?? ManageError.missingData.rawValue,
            codePostal: postalCode,
            townshipLabel: station.nomCommune ?? ManageError.missingData.rawValue,
            countyCode: station.codeDepartement ?? ManageError.missingData.rawValue,
            countyLabel: station.nomDepartement ?? ManageError.missingData.rawValue,
            bodyOfWaterCode: station.codesMasseEauEdl ?? [ManageError.missingData.rawValue],
            bodyOfWaterLabel: station.nomsMasseEauEdl ?? [ManageError.missingData.rawValue],
            uriBodyOfWater: station.urnsMasseEauEdl ?? [],
            depthOfInvestigation: station.profondeurInvestigation ?? 0.0,
            nbPiezoMeasurement:  station.nbMesuresPiezo ?? 0,
            bssId: station.bssId,
            urnsBdLisa: station.urnsBdlisa ?? [],
            bdLisaCode: station.codesBdlisa ?? [ManageError.missingData.rawValue],
            startMeasurementDate: station.dateDebutMesure ?? ManageError.missingData.rawValue,
            endMeasurementDate: station.dateFinMesure ?? ManageError.missingData.rawValue,
            altitude: station.altitudeStation ?? ManageError.missingData.rawValue,
            dateUPDT: station.dateDebutMesure ?? ManageError.missingData.rawValue)
        return stationODF
    }
}
