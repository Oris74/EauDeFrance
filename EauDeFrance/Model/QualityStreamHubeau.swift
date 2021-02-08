//
//  WaterQuality.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 08/01/2021.
//

import Foundation

/// MARK: - Datum
struct QualityStreamHubeau: Codable {
   
    let codeStation, libelleStation: String?
    let uriStation: String?
    let durete: String?
    let coordonneeX, coordonneeY: Int?
    let codeProjection, libelleProjection: String?
    let longitude, latitude: Double?
    let codeCommune, libelleCommune, codeDepartement, libelleDepartement: String?
    let codeRegion, libelleRegion: String?
    let codeCoursEau, nomCoursEau: String?
    let uriCoursEau: String?
    let codeMasseDeau, codeEuMasseDeau, nomMasseDeau: String?
    let uriMasseDeau: String?
    let codeEuSousBassin, nomSousBassin, codeBassin, codeEuBassin: String?
    let nomBassin: String?
    let uriBassin: String?
    let typeEntiteHydro: String?
    let commentaire: String?
    let dateCreation: String?
    let dateArret: String?
    let dateMajInformation: String?
    let finalite: String?
    let localisationPrecise, nature: String?
    let altitudePointCaracteristique: Double?
    let pointKilometrique, premierMoisAnneeEtiage, superficieBassinVersantReel, superficieBassinVersantTopo: String?
    let geometry: GeometryHubeau?

    enum CodingKeys: String, CodingKey {
        case codeStation = "code_station"
        case libelleStation = "libelle_station"
        case uriStation = "uri_station"
        case durete
        case coordonneeX, coordonneeY
        case codeProjection = "code_projection"
        case libelleProjection = "libelle_projection"
        case longitude, latitude
        case codeCommune = "code_commune"
        case libelleCommune = "libelle_commune"
        case codeDepartement = "code_departement"
        case libelleDepartement = "libelle_departement"
        case codeRegion = "code_region"
        case libelleRegion = "libelle_region"
        case codeCoursEau = "code_cours_Eau"
        case nomCoursEau = "nom_cours_Eau"
        case uriCoursEau = "uri_cours_Eau"
        case codeMasseDeau = "code_masse_deau"
        case codeEuMasseDeau = "code_eu_masse_deau"
        case nomMasseDeau = "nom_masse_deau"
        case uriMasseDeau = "uri_masse_deau"
        case codeEuSousBassin = "code_eu_sous_bassin"
        case nomSousBassin = "nom_sous_bassin"
        case codeBassin = "code_bassin"
        case codeEuBassin = "code_eu_bassin"
        case nomBassin = "nom_bassin"
        case uriBassin = "uri_bassin"
        case typeEntiteHydro = "type_entite_hydro"
        case commentaire
        case dateCreation = "date_creation"
        case dateArret = "date_arret"
        case dateMajInformation = "date_maj_information"
        case finalite
        case localisationPrecise = "localisation_precise"
        case nature
        case altitudePointCaracteristique = "altitude_point_caracteristique"
        case pointKilometrique = "point_kilometrique"
        case premierMoisAnneeEtiage = "premier_mois_annee_etiage"
        case superficieBassinVersantReel = "superficie_bassin_versant_reel"
        case superficieBassinVersantTopo = "superficie_bassin_versant_topo"
        case geometry
    }
}
