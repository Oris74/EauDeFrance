//
//  Hydrometry.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 07/01/2021.
//

import Foundation
// MARK: - Datum
struct HydrometryHubeau:  Codable {
    let codeSite, libelleSite: String?
    let codeStation, libelleStation: String?
    let typeStation: String?
    let coordonneeXStation, coordonneeYStation: Int?
    //let codeProjection: Int?
    let longitude, latitude: Double?
    let influenceLocaleStation: Int?
    let commentaireStation: String?
    let altitudeRefAltiStation: Int?
    let codeSystemeAltiSite: Int?
    let codeCommune, libelleCommune, codeDepartement, codeRegion: String?
    let libelleRegion, codeCoursEau: String?
    let libelleCoursEau: String?
    let uriCoursEau: String?
    let descriptifStation: String?
    let dateMajStation, dateOuvertureStation: String?
    let dateFermetureStation: String?
    let commentaireInfluenceLocaleStation: String?
    let codeRegimeStation, qualificationDonneesStation, codeFinaliteStation: Int?
    let typeContexteLoiStatStation, typeLoiStation: Int?
    let codeSandreReseauStation: [String]?
    let dateDebutRefAltiStation, dateActivationRefAltiStation, dateMajRefAltiStation: String?
    let libelleDepartement: String?
    let enService: Bool?
    let geometry: GeometryHubeau?

    enum CodingKeys: String, CodingKey {
        case codeSite = "code_site"
        case libelleSite = "libelle_site"
        case codeStation = "code_station"
        case libelleStation = "libelle_station"
        case typeStation = "type_station"
        case coordonneeXStation = "coordonnee_x_station"
        case coordonneeYStation = "coordonnee_y_Station"
        //case codeProjection = "code_projection"
        case longitude = "longitude_station"
        case latitude = "latitude_station"
        case influenceLocaleStation = "influence_locale_station"
        case commentaireStation = "commentaire_station"
        case altitudeRefAltiStation = "altitude_ref_alti_station"
        case codeSystemeAltiSite = "code_systeme_alti_site"
        case codeCommune = "code_commune_station"
        case libelleCommune = "libelle_commune"
        case codeDepartement = "code_cepartement"
        case codeRegion = "code_region"
        case libelleRegion = "libelle_region"
        case codeCoursEau = "code_cours_eau"
        case libelleCoursEau = "libelle_cours_eau"
        case uriCoursEau = "uri_cours_eau"
        case descriptifStation = "descriptif_station"
        case dateMajStation = "date_maj_station"
        case dateOuvertureStation = "date_ouverture_station"
        case dateFermetureStation = "date_fermeture_station"
        case commentaireInfluenceLocaleStation = "commentaire_influence_locale_station"
        case codeRegimeStation = "code_regime_station"
        case qualificationDonneesStation = "qualification_donnees_station"
        case codeFinaliteStation = "code_finalite_station"
        case typeContexteLoiStatStation = "type_contexte_loi_stat_station"
        case typeLoiStation = "type_loi_station"
        case codeSandreReseauStation = "code_sandre_reseau_station"
        case dateDebutRefAltiStation = "date_debut_ref_alti_station"
        case dateActivationRefAltiStation = "date_activation_ref_alti_station"
        case dateMajRefAltiStation = "date_maj_ref_alti_station"
        case libelleDepartement = "libelle_departement"
        case enService = "en_service"
        case geometry = "geometry"
    }
}
