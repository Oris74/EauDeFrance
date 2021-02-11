//
//  Hydrology.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 28/01/2021.
//

import Foundation

class Hydrometry: ManageService {

    static var shared = Hydrometry()

    internal let stationURL = URL(string: "https://hubeau.eaufrance.fr/api/v1/hydrometrie/referentiel/stations?")!

    internal let figureURL = URL(string: "https://hubeau.eaufrance.fr/api/v1/hydrometrie/referentiel/observation_tr?")!

    let serviceName = "Hydrométrie"
    let apiName = "hydrometrie"

    var networkService: NetworkProtocol = NetworkService.shared
    
    init() { }

    func getStation(parameters: [[KeyRequest : String]], callback: @escaping ([StationODF]?, Utilities.ManageError?) -> Void) {


        var stationODF: [StationODF] = []
        networkService.getAPIData(
            stationURL, parameters, ApiHubeauHeader<HydrometryHubeau>?.self, completionHandler: {[weak self]  (apidata, error) in
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

    func getFigure(station:StationODF, callback: @escaping (StationODF?, ManageODFapi?, Utilities.ManageError?) -> Void) {

    }
    private func bridgeStation(station: HydrometryHubeau ) -> HydrometryODF? {
        let stationODF: HydrometryODF?
        stationODF = HydrometryODF.init(
            stationCode: station.codeStation ?? "",
            stationLabel: station.libelleStation ?? "",
            longitude: station.longitude ?? 0.0,
            latitude: station.latitude ?? 0.0 ,
            townshipCode:station.codeCommune ?? "",
            townshipLabel: station.libelleCommune ?? "",
            countyCode: station.codeDepartement ?? "",
            countyLabel: station.libelleDepartement ?? "",
            altitude: String(format: "%.f", station.altitudeRefAltiStation ?? 0.0),
            dateUPDT:station.dateMajRefAltiStation ?? "",
            siteCode: station.codeSite,
            siteLabel:station.libelleSite,
            stationType: station.typeStation,
            coordonnateXStation: station.coordonneeXStation,
            coordonnateYStation: station.coordonneeYStation,
            projectionCode: station.codeProjection,
            localStationInfluence : station.influenceLocaleStation,
            stationCommentary: station.commentaireStation,
            altiSiteSystemCode: station.codeSystemeAltiSite,
            regionCode: station.codeRegion,
            regionLabel: station.libelleRegion,
            streamCode: station.codeCoursEau,
            streamLabel: station.libelleCoursEau,
            uriStream: station.uriCoursEau,
            stationDescription: station.descriptifStation,
            openingStationDate: station.dateOuvertureStation,
            closingStationDate: station.dateFermetureStation,
            localStationInfluenceCommentary: station.commentaireInfluenceLocaleStation,
            stationRegimeCode: station.codeRegimeStation,
            dataStationQualification: station.qualificationDonneesStation,
            finalityStationCode: station.codeFinaliteStation,
            contextTypeStationLawStat: station.typeContexteLoiStatStation,
            stationLawType:station.typeLoiStation,
            sandreNetworkStationCode: station.codeSandreReseauStation,
            altiRefStationActivationDate: station.dateActivationRefAltiStation,
            altiStationRefUpdateDate: station.dateMajRefAltiStation,
            inService: station.enService)

        return stationODF
    }
}
