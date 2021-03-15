//
//  File.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 28/01/2021.
//

import Foundation

class Temperature: Utilities, ManageService {
 
    static var shared = Temperature()
    
    let stationURL = URL(string: "https://hubeau.eaufrance.fr/api/v1/temperature/station?")!

    let figureURL = URL(string: "https://hubeau.eaufrance.fr/api/v1/temperature/chronique?")!

    var networkService: NetworkProtocol

    let postalCodeFrance = ManagePostalCode.shared

    let apiName = "temperature"
    let serviceName = "Température"

    init(networkService: NetworkProtocol =  NetworkService.shared) {
        self.networkService = networkService
    }


    func getStation(parameters: [[KeyRequest:String]], callback: @escaping ([StationODF]?, Utilities.ManageError? ) -> Void) {
        networkService.getAPIData(
            stationURL, parameters, ApiHubeauHeader<TemperatureHubeau>?.self, completionHandler: {[weak self]  (apidata, error) in

                guard let depackedAPIData = apidata, let stations = depackedAPIData.data else {
                    return callback(nil, error)
                }

                var stationODF: [TemperatureODF] = []
                for stationAPI in stations {
                    if let station = self?.bridgeStationODF(station: stationAPI) {
                        stationODF.append(station)
                    }
                }
                callback(stationODF, nil)
                return
            })
    }


    func getFigure(stationCode: String, callback: @escaping ([Measure], Utilities.ManageError?) -> Void) {
        let parameters: [[KeyRequest : String]] = [
            [.stationCode: stationCode],
            [.sort:"desc"],[.size: "5000"]]

        networkService.getAPIData(
            figureURL, parameters, ApiHubeauHeader<TemperatureHubeauValue>?.self, completionHandler: {[weak self]  (apidata, error) in
                guard let depackedAPIData = apidata, let apiFigures = depackedAPIData.data else {
                    return callback([], error)
                }

                var measures: [Measure] = []

                for figure in apiFigures {
                    if let measure = self?.bridgeFigureODF(api:  figure),
                        !measures.contains(where: {$0.date == measure.date}) {
                        measures.append(measure)
                    }
                }
                measures.sort {$0.date < $1.date}
                callback(measures, nil)
                return
            })
    }

    private func bridgeFigureODF(api: TemperatureHubeauValue) -> Measure? {

        var measure: Measure?

        if let hour = api.heureMesureTemp {
            if let date = api.dateMesureTemp {
                let timestamp = "\(date)T\(hour)Z"
                if let value = api.resultat, let unit = api.codeUnite {
                    measure = Measure(timestamp: timestamp, value: value, unit: unit )

                }
            }
        }
        return measure
    }

    private func bridgeStationODF(station: TemperatureHubeau ) -> TemperatureODF? {
        var postalCode: String = ""
        if let codeInsee = station.codeCommune {
            postalCode = postalCodeFrance.getPostalCode(withInsee: codeInsee) ?? "\(codeInsee)(Code INSEE)"
        }

        let stationODF: TemperatureODF?
        stationODF = TemperatureODF.init(
            stationCode: station.codeStation,
            stationLabel: station.libelleStation,
            localization: station.localisation ?? ManageError.missingData.rawValue,
            streamCode: station.codeCoursEau ?? ManageError.missingData.rawValue,
            streamLabel: station.libelleCoursEau ?? ManageError.missingData.rawValue,
            uriStream: station.uriCoursEau,
            hydroSectionCode: station.codeTronconHydro ?? ManageError.missingData.rawValue,
            longitude: station.longitude,
            latitude: station.latitude,
            townshipCode: station.codeCommune ?? ManageError.missingData.rawValue,
            postalCode: postalCode,
            townshipLabel: station.libelleCommune ?? ManageError.missingData.rawValue,
            countyCode: station.codeDepartement ?? ManageError.missingData.rawValue,
            countyLabel: station.libelleDepartement ?? ManageError.missingData.rawValue,
            altitude: String(format: "%.f", station.altitude ?? 0.0),
            dateUPDT: station.dateMajInfos ?? ManageError.missingData.rawValue,
            bodyOfWaterCode: station.codeMasseEau ?? ManageError.missingData.rawValue,
            bodyOfWaterLabel: station.libelleMasseEau ?? ManageError.missingData.rawValue,
            uriBodyOfWater: station.uriMasseEau,
            regionLabel: station.libelleRegion ?? ManageError.missingData.rawValue,
            regionCode: station.codeRegion ?? ManageError.missingData.rawValue,
            subBasinCode: station.codeSousBassin ?? ManageError.missingData.rawValue,
            basinLabel: station.libelleBassin ?? ManageError.missingData.rawValue,
            subBasinLabel: station.libelleSousBassin ?? ManageError.missingData.rawValue,
            basinCode: station.codeBassin ?? ManageError.missingData.rawValue,
            uriBasin: station.uriBassin,
            pointKM: String(format: "%.0", station.pointKm ?? 0.0)
            )
        return stationODF
    }
}
