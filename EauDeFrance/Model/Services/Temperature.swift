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

    let figureURL = URL(string: "https://hubeau.eaufrance.fr/api/v1/temperature/chronique?")!

    let networkService: NetworkProtocol = NetworkService.shared

    let postalCodeFrance = ManagePostalCode.shared

    let apiName = "temperature"
    let serviceName = "Température"

    init(){}

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


    func getFigure(codeStation: String, callback: @escaping ([Any]?, ManageODFapi?,Utilities.ManageError?) -> Void) {
        let parameters: [[KeyRequest : String]] = [
            [.stationCode: codeStation],
            [.sort:"desc"],[.size: "5000"]]

        networkService.getAPIData(
            figureURL, parameters, ApiHubeauHeader<TemperatureHubeauValue>?.self, completionHandler: {[weak self]  (apidata, error) in
                guard let depackedAPIData = apidata, let apiFigures = depackedAPIData.data else {
                    return callback(nil, nil, error)
                }

                let statusAPI = ManageODFapi(count: depackedAPIData.count, first: depackedAPIData.first, last: depackedAPIData.last, prev: depackedAPIData.prev, next: depackedAPIData.next, apiVersion: depackedAPIData.apiVersion)

                var temperatureValues: [TemperatureODFValue] = []
                for figure in apiFigures {
                    if let figureODF = self?.bridgeFigureODF(api:  figure) {
                        temperatureValues.append(figureODF)
                    }
                }
                callback(temperatureValues, statusAPI, nil)
                return
            })
    }

    private func bridgeFigureODF(api: TemperatureHubeauValue) -> TemperatureODFValue {
        let figure = TemperatureODFValue(
            parameterCode: api.codeParametre,
            parameterLabel: api.libelleParametre,
            tempMeasureDate: api.dateMesureTemp,
            tempMeasureHour: api.heureMesureTemp,
            result: api.resultat,
            unitCode: api.codeUnite,
            unitSymbol: api.symboleUnite,
            qualificationCode: api.codeQualification,
            qualificationLabel: api.libelleQualification)
        return figure
    }

    private func bridgeStationODF(station: TemperatureHubeau ) -> TemperatureODF? {
        var postalCode: String
        if let codeInsee = station.codeCommune {
             postalCode = postalCodeFrance.getPostalCode(withInsee: codeInsee) ?? "\(codeInsee)(Code INSEE)"
        } else {
             postalCode = ""
        }

        let stationODF: TemperatureODF?
        stationODF = TemperatureODF.init(
            stationCode: station.codeStation,
            stationLabel: station.libelleStation,
            uriStation: station.uriStation,
            localization: station.localisation ?? "non renseignée",
            streamCode: station.codeCoursEau ?? "non renseignée",
            streamLabel: station.libelleCoursEau ?? "non renseignée",
            uriStream: station.uriCoursEau ?? "non renseignée",
            hydroSectionCode: station.codeTronconHydro ?? "non renseignée",
            longitude: station.longitude,
            latitude: station.latitude,
            townshipCode: station.codeCommune ?? "non renseignée",
            postalCode: postalCode,
            townshipLabel: station.libelleCommune ?? "non renseignée",
            countyCode: station.codeDepartement ?? "non renseignée",
            countyLabel: station.libelleDepartement ?? "non renseignée",
            altitude: String(format: "%.f", station.altitude ?? 0.0),
            dateUPDT: station.dateMajInfos ?? "non renseignée",
            bodyOfWaterCode: station.codeMasseEau ?? "non renseignée",
            bodyOfWaterLabel: station.libelleMasseEau ?? "non renseignée",
            uriBodyOfWater: station.uriMasseEau ?? "non renseignée",
            regionLabel: station.libelleRegion ?? "non renseignée",
            regionCode: station.codeRegion ?? "non renseignée",
            subBasinCode: station.codeSousBassin ?? "non renseignée",
            basinLabel: station.libelleBassin ?? "non renseignée",
            subBasinLabel: station.libelleSousBassin ?? "non renseignée",
            basinCode: station.codeBassin ?? "non renseignée",
            uriBasin: station.uriBassin ?? "non renseignée",
            pointKM: String(format: "%.0", station.pointKm ?? 0.0)
            )
        return stationODF
    }
}
