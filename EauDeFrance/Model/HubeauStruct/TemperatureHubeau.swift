//
//  Temperature.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 07/01/2021.
//

import Foundation

// MARK: - API  Hubeau for Temperature station
struct TemperatureHubeau: Codable {
    let codeStation, libelleStation: String
    let localisation: String?
    let coordonneeX, coordonneeY, codeTypeProjection: Int?
    let longitude, latitude: Double
    let codeCommune, libelleCommune, codeDepartement, libelleDepartement: String?
    let codeRegion, libelleRegion, codeTronconHydro, codeCoursEau: String?
    let libelleCoursEau: String?
    let uriCoursEau: URL?
    let codeMasseEau: String?
    let libelleMasseEau: String?
    let uriMasseEau: URL?
    let codeSousBassin, libelleSousBassin, codeBassin, libelleBassin: String?
    let uriBassin: URL?
    let pointKm: Double?
    let altitude: Double?
    let dateMajInfos: String?
    
    enum CodingKeys: String, CodingKey {
        case codeStation = "code_station"
        case libelleStation = "libelle_station"
        case localisation = "localisation"
        case coordonneeX = "coordonneeX"
        case coordonneeY = "coordonneeY"
        case codeTypeProjection = "code_type_projection"
        case longitude = "longitude"
        case latitude = "latitude"
        case codeCommune = "code_commune"
        case libelleCommune = "libelle_commune"
        case codeDepartement = "code_departement"
        case libelleDepartement = "libelle_departement"
        case codeRegion = "code_region"
        case libelleRegion = "libelle_region"
        case codeTronconHydro = "code_troncon_hydro"
        case codeCoursEau = "code_cours_eau"
        case libelleCoursEau = "libelle_cours_eau"
        case uriCoursEau = "uri_cours_eau"
        case codeMasseEau = "code_masse_eau"
        case libelleMasseEau = "libelle_masse_eau"
        case uriMasseEau = "uri_masse_eau"
        case codeSousBassin = "code_sous_bassin"
        case libelleSousBassin = "libelle_sous_bassin"
        case codeBassin = "code_bassin"
        case libelleBassin = "libelle_bassin"
        case uriBassin = "uri_bassin"
        case pointKm = "pk"
        case altitude
        case dateMajInfos  = "date_maj_infos"
    }
}
