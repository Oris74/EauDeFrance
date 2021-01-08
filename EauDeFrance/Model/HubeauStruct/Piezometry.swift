//
//  Piezometry.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 07/01/2021.
//

import Foundation

// MARK: - Datum
struct Piezometry {
    let codeBss: String?
    let urnBss: String?
    let dateDebutMesure, dateFinMesure, codeCommuneInsee, nomCommune: String?
    let x, y: Double?
    let codesBdlisa: [String]?
    let urnsBdlisa: [String]?
    let geometry: Geometry?
    let bssId, altitudeStation: String?
    let nbMesuresPiezo: Int?
    let codeDepartement, nomDepartement, libellePe: String?
    let profondeurInvestigation: Int?
    let codesMasseEauEdl: [String]?
    let nomsMasseEauEdl: [String]?
    let urnsMasseEauEdl: [String]?
    let dateMaj: String?
}
