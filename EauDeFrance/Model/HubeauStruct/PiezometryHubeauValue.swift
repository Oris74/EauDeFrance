//
//  PiezometryHubeauValue.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 10/02/2021.
//

import Foundation
// MARK: - Datum
struct PiezometryHubeauValue: Codable {
    let dateMaj: String
    let bss_Id: String
    let codeBss: String
    let urnBss: String
    let longitude: Double
    let latitude: Double
    let altitudeStation: Double?
    let altitudeRepere: Double?
    let dateMesure: String
    let timestampMesure: Int
    let profondeurNappe: Double
    let niveauEauNgf: Double
    
    enum CodingKeys: String, CodingKey {
        
        case dateMaj = "date_maj"
        case bss_Id = "bss_id"
        case codeBss = "code_bss"
        case urnBss = "urn_bss"
        case longitude = "longitude"
        case latitude = "latitude"
        case altitudeStation = "altitude_station"
        case altitudeRepere = "altitude_repere"
        case dateMesure = "date_mesure"
        case timestampMesure = "timestamp_mesure"
        case profondeurNappe = "profondeur_nappe"
        case niveauEauNgf = "niveau_eau_ngf"
    }
}
