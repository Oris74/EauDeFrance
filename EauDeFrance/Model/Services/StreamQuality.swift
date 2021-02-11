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

    internal var figureURL = URL(string: "https://hubeau.eaufrance.fr/api/v1/qualite_rivieres/analyse_pc??")!

    let serviceName = "Qualité rivières"
    let apiName = "qualite_rivieres"

    var networkService: NetworkProtocol = NetworkService.shared

   init() {
    }

func getStation(parameters: [[KeyRequest:String]], callback: @escaping ([StationODF]?, Utilities.ManageError?) -> Void) {

        networkService.getAPIData(
            stationURL, parameters, ApiHubeauHeader<QualityStreamHubeau>?.self, completionHandler: {[weak self]  (apidata, error) in

                guard let depackedAPIData = apidata, let stations = depackedAPIData.data else {
                    return callback(nil, error)
                }

                var stationODF: [QualityStreamODF] = []
                for stationAPI in stations {
                    if let station = self?.bridgeStation(station: stationAPI) {
                        stationODF.append(station)
                    }
                }
                callback(stationODF, nil)
                return
            })
    }

    func getFigure(station: StationODF, callback: @escaping (StationODF?, ManageODFapi?, Utilities.ManageError?) -> Void) {
//        let parameters: [[KeyRequest : String]] = [
//            [.stationCode:station.stationCode],
//            [.page:"50"],
//            [.sort:"desc"]
//        ]
//
//        networkService.getAPIData(
//            figureURL, parameters, ApiHubeauHeader<QualityStreamHubeauValue>?.self, completionHandler: {[weak self]  (apidata, error) in
//                guard let depackedAPIData = apidata, let apiFigures = depackedAPIData.data else {
//                    return callback(nil, nil, error)
//                }
//
//                let statusAPI = ManageODFapi(count: depackedAPIData.count, first: depackedAPIData.first, last: depackedAPIData.last, prev: depackedAPIData.prev, next: depackedAPIData.next, apiVersion: depackedAPIData.apiVersion)
//
//                guard let serviceODF = station as? QualityStreamODF else {
//                    return callback(nil, nil, Utilities.ManageError.incorrectDataStruct)
//                }
//
//                for figure in apiFigures {
//                    if let figureODF = self?.bridgeFigureODF(api:  figure) {
//                        serviceODF.figure?.append(figureODF)
//                    }
//                }
//                callback(station, statusAPI, nil)
//                return
//            })
        callback(nil, nil, nil)
    }

//    private func bridgeFigureODF(api: QualityStreamHubeauValue) -> QualityODFValue {
//        let figure = QualityODFValue(
//            parameterCode: api.codeParametre,
//            parameterLabel: api.libelleParametre,
//            tempMeasureDate: api.dateMesureTemp,
//            tempMeasureHour: api.heureMesureTemp,
//            result: api.resultat,
//            unitCode: api.codeUnite,
//            unitSymbol: api.symboleUnite,
//            qualificationCode: api.codeQualification,
//            qualificationLabel: api.libelleQualification)
//        return figure
//    }
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
