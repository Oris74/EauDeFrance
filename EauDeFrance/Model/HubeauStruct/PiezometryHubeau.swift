//
//  Piezometry.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 07/01/2021.
//

import Foundation

// MARK: API  Hubeau for Piezometry station
struct PiezometryHubeau:  Codable {
    
    let codeBss: String?
    let dateDebutMesure, dateFinMesure, codeCommuneInsee, nomCommune: String?
    let longitude, latitude: Double?
    let codesBdlisa: [String]?
    let urnsBdlisa: [URL]?
    let bssId: String
    let altitudeStation: String?
    let nbMesuresPiezo: Int?
    let codeDepartement, nomDepartement, libellePe: String?
    let profondeurInvestigation: Double?
    let codesMasseEauEdl: [String]?
    let nomsMasseEauEdl: [String]?
    let urnsMasseEauEdl: [URL]?
    let dateMaj: String?
    
    enum CodingKeys: String, CodingKey {
        case codeBss = "code_bss"
        case dateDebutMesure = "date_debut_mesure"
        case dateFinMesure = "date_fin_mesure"
        case codeCommuneInsee = "code_commune_insee"
        case nomCommune = "nom_commune"
        case longitude = "x"
        case latitude = "y"
        case codesBdlisa = "codes_bdlisa"
        case urnsBdlisa = "urns_bdlisa"
        case bssId = "bss_id"
        case altitudeStation = "altitude_station"
        case nbMesuresPiezo = "nb_mesures_piezo"
        case codeDepartement = "code_departement"
        case nomDepartement = "nom_departement"
        case libellePe = "libelle_pe"
        case profondeurInvestigation = "profondeur_investigation"
        case codesMasseEauEdl = "codes_masse_eau_edl"
        case nomsMasseEauEdl = "noms_masse_eau_edl"
        case urnsMasseEauEdl = "urns_masse_eau_edl"
        case dateMaj = "date_maj"
    }
}
