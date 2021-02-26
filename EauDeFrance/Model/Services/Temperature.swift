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

    var networkService: NetworkProtocol = NetworkService.shared

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

    func getFigure(url: URL, callback: @escaping ([TemperatureODFValue]?, ManageODFapi?,Utilities.ManageError?) -> Void) {

        networkService.getAPIData(
            url, nil, ApiHubeauHeader<TemperatureHubeauValue>?.self, completionHandler: {[weak self]  (apidata, error) in
                guard let depackedAPIData = apidata, let apiFigures = depackedAPIData.data else {
                    return callback(nil, nil, error)
                }

                let statusAPI = ManageODFapi(count: depackedAPIData.count, first: depackedAPIData.first, last: depackedAPIData.last, prev: depackedAPIData.prev, next: depackedAPIData.next, apiVersion: depackedAPIData.apiVersion)

                var serviceODF:[TemperatureODFValue] = []
                for figure in apiFigures {
                    if let figureODF = self?.bridgeFigureODF(api:  figure) {
                        serviceODF.append(figureODF)
                    }
                }
                callback(serviceODF, statusAPI, nil)
                return
            })
    }



    func getFigure(station: StationODF, optionnalParam: [[KeyRequest:String]], callback: @escaping (StationODF?, ManageODFapi?,Utilities.ManageError?) -> Void) {

        let parameters: [[KeyRequest : String]] = [
            [.stationCode: station.stationCode],
            [.sort:"desc"]] + optionnalParam

        networkService.getAPIData(
            figureURL, parameters, ApiHubeauHeader<TemperatureHubeauValue>?.self, completionHandler: {[weak self]  (apidata, error) in
                guard let depackedAPIData = apidata, let apiFigures = depackedAPIData.data else {
                    return callback(nil, nil, error)
                }

                let statusAPI = ManageODFapi(count: depackedAPIData.count, first: depackedAPIData.first, last: depackedAPIData.last, prev: depackedAPIData.prev, next: depackedAPIData.next, apiVersion: depackedAPIData.apiVersion)

                guard let serviceODF = station as? TemperatureODF else {
                    return callback(nil, nil, Utilities.ManageError.incorrectDataStruct)
                }
                serviceODF.figure = []
                for figure in apiFigures {
                    if let figureODF = self?.bridgeFigureODF(api:  figure) {
                        serviceODF.figure?.append(figureODF)
                    }
                }
                callback(serviceODF, statusAPI, nil)
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
        let stationODF: TemperatureODF?
        stationODF = TemperatureODF.init(
            stationCode: station.codeStation ?? "",
            stationLabel: station.libelleStation ?? "",
            uriStation: station.uriStation,
            localization: station.localisation,
            //coordinateX: station.coordonneeX,
            //coordinateY: station.coordonneeY,
            streamCode: station.codeCoursEau,
            streamLabel: station.libelleCoursEau,
            uriStream: station.uriCoursEau,
            hydroSectionCode: station.codeTronconHydro,
            longitude: station.longitude ?? 0.0,
            latitude: station.latitude ?? 0.0,
            townshipCode: station.codeCommune ?? "",
            townshipLabel: station.libelleCommune ?? "",
            countyCode: station.codeDepartement ?? "",
            countyLabel: station.libelleDepartement ?? "",
            altitude: String(format: "%.f", station.altitude ?? 0.0),
            dateUPDT: station.dateMajInfos ?? "",
            bodyOfWaterCode: station.codeMasseEau,
            bodyOfWaterLabel: station.libelleMasseEau,
            uriBodyOfWater: station.uriMasseEau,
            regionLabel: station.libelleRegion,
            regionCode: station.codeRegion,
            subBasinCode: station.codeSousBassin,
            basinLabel: station.libelleBassin,
            subBasinLabel: station.libelleSousBassin,
            basinCode: station.codeBassin,
            uriBasin: String(format: "%.0", station.altitude ?? 0.0),
            pointKM: String(format: "%.0", station.pointKm ?? 0.0)
        )
        return stationODF
    }
}
