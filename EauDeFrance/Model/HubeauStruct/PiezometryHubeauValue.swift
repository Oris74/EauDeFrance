//
//  PiezometryHubeauValue.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 10/02/2021.
//

import Foundation
// MARK: - Datum
struct PiezometryHubeauValue: Codable {
    let codeBss: String?
    let urnBss: String?
    let dateMesure: String?
    let timestampMesure: Int?
    let niveauNappeEau: Double?
    let modeObtention: String?
    let statut: String?
    let qualification: String?
    let codeContinuite: String?
    let nomContinuite: String?
    let codeProducteur: String?
    let nomProducteur: String?
    let codeNatureMesure, nomNatureMesure: String?
    let profondeurNappe: Double?
    
    enum CodingKeys: String, CodingKey {
        case codeBss = "code_bss"
        case urnBss = "urn_bss"
        case dateMesure = "date_mesure"
        case timestampMesure = "timestamp_mesure"
        case niveauNappeEau = "niveau_nappe_eau"
        case modeObtention = "mode_obtention"
        case statut
        case qualification
        case codeContinuite = "code_continuite"
        case nomContinuite = "nom_continuite"
        case codeProducteur = "code_producteur"
        case nomProducteur = "nom_producteur"
        case codeNatureMesure = "code_nature_mesure"
        case nomNatureMesure = "nom_nature_mesure"
        case profondeurNappe = "profondeur_nappe"
    }
}
