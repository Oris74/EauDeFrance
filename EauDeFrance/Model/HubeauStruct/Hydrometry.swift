//
//  Hydrometry.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 07/01/2021.
//

import Foundation
// MARK: - Datum
struct Hydrometry: Codable {
    let codeSite, libelleSite, codeStation, libelleStation: String?
    let typeStation: String?
    let coordonneeXStation, coordonneeYStation, codeProjection: Int?
    let longitudeStation, latitudeStation: Double?
    let influenceLocaleStation: Int?
    let commentaireStation: String?
    let altitudeRefAltiStation, codeSystemeAltiSite: Int?
    let codeCommuneStation, libelleCommune, codeDepartement, codeRegion: String?
    let libelleRegion, codeCoursEau: String?
    let libelleCoursEau: String?
    let uriCoursEau: String?
    let descriptifStation: String?
    let dateMajStation, dateOuvertureStation: Date?
    let dateFermetureStation: String?
    let commentaireInfluenceLocaleStation: String?
    let codeRegimeStation, qualificationDonneesStation, codeFinaliteStation: Int?
    let typeContexteLoiStatStation, typeLoiStation: Int?
    let codeSandreReseauStation: [String]?
    let dateDebutRefAltiStation, dateActivationRefAltiStation, dateMajRefAltiStation: Date?
    let libelleDepartement: String?
    let enService: Bool?
    let geometry: Geometry?
}
