//
//  ServicesODF.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 18/01/2021.
//

import Foundation
import UIKit

enum Service:String  {
    case hydrometrie = "Hydrométrie"
    case temperature = "Température"
    case qualite_rivieres = "Qualité cours d'eau"
    case niveaux_nappes = "Piézometrie"

    func logo() -> UIImage {
        return UIImage(named: "\(self)")!
    }

    func getApiURL() -> URL {
        switch self {
        case .hydrometrie:
            return URL(string: "https://hubeau.eaufrance.fr/api/v1/hydrometrie/referentiel/stations?")!
        case .niveaux_nappes:
            return URL(string: "https://hubeau.eaufrance.fr/api/v1/niveaux_nappes/stations?")!
        case .temperature:
            return URL(string: "https://hubeau.eaufrance.fr/api/v1/temperature/station?")!
        case .qualite_rivieres:
            return URL(string: "https://hubeau.eaufrance.fr/api/v1/qualite_rivieres/station_pc??")!
        }
    }

    func getApiFigure()-> URL {
        switch self {
        case .hydrometrie:
            return URL(string: "https://hubeau.eaufrance.fr/api/v1/hydrometrie/referentiel/observation_tr?")!
        case .niveaux_nappes:
            return URL(string: "https://hubeau.eaufrance.fr/api/v1/niveaux_nappes/chroniques?")!
        case .temperature:
            return URL(string: "https://hubeau.eaufrance.fr/api/v1/temperature/chronique?")!
        case .qualite_rivieres:
            return URL(string: "https://hubeau.eaufrance.fr/api/v1/qualite_rivieres/analyse_pc??")!
        }
    }
    func getApiStruct<T>() -> T {
        switch self {
        case .hydrometrie:
            return ApiHubeauHeader<HydrometryHubeau>?.self as! T
        case .niveaux_nappes:
            return ApiHubeauHeader<PiezometryHubeau>?.self as! T
        case .temperature:
            return ApiHubeauHeader<TemperatureHubeau>?.self as! T
        case .qualite_rivieres:
            return ApiHubeauHeader<StreamQualityHubeau>?.self as! T
        }
    }

    func bridgeStation(resultAPI: Any ) -> StationODF? {
        let stationODF: StationODF?

        switch resultAPI {
        case let depackedStation as TemperatureHubeau:
            stationODF = StationODF.init(
                service: Service.temperature,
                stationID: depackedStation.codeStation,
                stationLabel: depackedStation.libelleStation,
                uriStation: depackedStation.uriStation,
                localization: depackedStation.localisation,
                coordinateX: depackedStation.coordonneeX,
                coordinateY: depackedStation.coordonneeY,
                longitude: depackedStation.longitude,
                latitude: depackedStation.latitude,
                townshipID: depackedStation.codeCommune,
                townshipLabel: depackedStation.libelleCommune,
                countyID: depackedStation.codeDepartement,
                countyLabel: depackedStation.libelleDepartement,
                regionID: depackedStation.codeRegion,
                regionLabel: depackedStation.libelleRegion,
                hydroSectionID: depackedStation.codeTronconHydro,
                streamID: depackedStation.codeCoursEau,
                streamLabel: depackedStation.libelleCoursEau,
                uriStream: depackedStation.uriCoursEau,
                // bodyOfWaterID: depackedStation.codeMasseEau,
                // bodyOfWaterLabel: depackedStation.libelleMasseEau,
                // uriBodyOfWater: depackedStation.uriMasseEau,
                pointKm: depackedStation.pointKm,
                altitude: String(format: "0.0", depackedStation.altitude ?? 0.0),
                dateOfUpdtInfos: depackedStation.dateMajInfos
            )
        case let depackedStation as HydrometryHubeau:
            stationODF = StationODF.init(
                service: Service.hydrometrie,
                stationID: depackedStation.codeStation,
                stationLabel: depackedStation.libelleStation,
                // uriStation: depackedStation.uriStation,
                //localization: depackedStation.localisation,
                coordinateX: depackedStation.coordonneeXStation,
                coordinateY: depackedStation.coordonneeYStation,
                longitude: depackedStation.longitude,
                latitude: depackedStation.latitude,
                townshipID: depackedStation.codeCommune,
                townshipLabel: depackedStation.libelleCommune,
                countyID: depackedStation.codeDepartement,
                countyLabel: depackedStation.libelleDepartement,
                regionID: depackedStation.codeRegion,
                regionLabel: depackedStation.libelleRegion,
                //hydroSectionID: depackedStation.codeTronconHydro,
                streamID: depackedStation.codeCoursEau,
                streamLabel: depackedStation.libelleCoursEau,
                uriStream: depackedStation.uriCoursEau,
                //bodyOfWaterID: depackedStation.codeMasseEau,
                // bodyOfWaterLabel: depackedStation.libelleMasseEau,
                // uriBodyOfWater: depackedStation.uriMasseEau,
                //pointKm: depackedStation.pointKm,
                altitude: String(format: "0.0", depackedStation.altitudeRefAltiStation ?? 0.0),
                dateOfUpdtInfos: depackedStation.dateMajStation
            )
        case let depackedStation as PiezometryHubeau:
            stationODF = StationODF.init(
                service: Service.niveaux_nappes,
                stationID: depackedStation.codeBss,
                stationLabel: depackedStation.libellePe,
                uriStation: depackedStation.bssId,
                localization: nil,
                coordinateX: nil,
                coordinateY: nil,
                longitude: depackedStation.coordX,
                latitude: depackedStation.coordY,
                townshipID: depackedStation.codeCommuneInsee,
                townshipLabel: depackedStation.nomCommune,
                countyID: depackedStation.codeDepartement,
                countyLabel: depackedStation.nomDepartement,
                regionID: nil,
                regionLabel: nil,
                hydroSectionID: nil,
                streamID: nil,
                streamLabel: nil,
                uriStream: nil,
                uriBodyOfWater: depackedStation.urnsMasseEauEdl,
                bodyOfWaterLabel: depackedStation.nomsMasseEauEdl,
                bodyOfWaterID: depackedStation.codesMasseEauEdl,
                pointKm: nil,
                altitude: String(format: "0.0", depackedStation.altitudeStation ?? 0),
                dateOfUpdtInfos: depackedStation.dateDebutMesure)


        /*case let depackedStation as StreamQuality:
         stationODF = StationODF.init(
         service: Service.qualite_rivieres,
         stationID: depackedStation.codeStation,
         stationLabel: depackedStation.libelleStation,
         uriStation: depackedStation.uriStation,
         localization: depackedStation.localisation,
         coordinateX: depackedStation.coordonneeX,
         coordinateY: depackedStation.coordonneeY,
         longitude: depackedStation.longitude,
         latitude: depackedStation.latitude,
         townshipID: depackedStation.codeCommune,
         townshipLabel: depackedStation.libelleCommune,
         countyID: depackedStation.codeDepartement,
         countyLabel: depackedStation.libelleDepartement,
         regionID: depackedStation.codeRegion,
         regionLabel: depackedStation.libelleRegion,
         hydroSectionID: depackedStation.codeTronconHydro,
         streamID: depackedStation.codeCoursEau,
         streamLabel: depackedStation.libelleCoursEau,
         uriStream: depackedStation.uriCoursEau
         bodyOfWaterID: depackedStation.codeMasseEau,
         bodyOfWaterLabel: depackedStation.libelleMasseEau,
         uriBodyOfWater: depackedStation.uriMasseEau,
         pointKm: depackedStation.pointKm,
         altitude: depackedStation.altitude,
         dateOfUpdtInfos: depackedStation.dateMajInfos
         )*/
        default:
            stationODF = nil
        }
        return stationODF
    }
}

enum Place {
    case dept(String)
    case zone(Coord)
    func getParameter () -> String {
        switch self {
        case .dept(let code):
            return "?code_departement=\(code)"
        case .zone(let zone):
        return "?bbox=\(zone.minLong),\(zone.minLat),\(zone.maxLong),\(zone.maxLat)"
        }
    }
}

struct Coord {
    let minLong,minLat,maxLong,maxLat: String
}
