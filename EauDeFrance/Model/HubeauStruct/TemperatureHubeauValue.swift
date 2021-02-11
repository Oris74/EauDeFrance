//
//  TemperatureValue.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 07/01/2021.
//

import Foundation

// MARK: - Datum
struct TemperatureHubeauValue: Codable {
    let codeStation, libelleStation: String?
    let uriStation: String?
    let longitude, latitude: Double?
    let codeCommune, libelleCommune, codeCoursEau, libelleCoursEau: String?
    let uriCoursEau: String?
    let codeParametre, libelleParametre, dateMesureTemp, heureMesureTemp: String?
    let resultat: Double?
    let codeUnite, symboleUnite, codeQualification, libelleQualification: String?

    enum CodingKeys: String, CodingKey {
        case codeStation = "code_station"
        case libelleStation = "libelle_station"
        case uriStation = "uri_station"
        case longitude, latitude
        case codeCommune = "code_commune"
        case libelleCommune = "libelle_commune"
        case codeCoursEau = "code_cours_eau"
        case libelleCoursEau = "libelle_cours_eau"
        case uriCoursEau = "uri_cours_eau"
        case codeParametre = "code_parametre"
        case libelleParametre = "libelle_parametre"
        case dateMesureTemp = "date_mesure_temp"
        case heureMesureTemp = "heure_mesure_temp"
        case resultat = "resultat"
        case codeUnite = "code_unite"
        case symboleUnite = "symbole_unite"
        case codeQualification = "code_qualification"
        case libelleQualification  = "libelle_qualification"
    }
}
