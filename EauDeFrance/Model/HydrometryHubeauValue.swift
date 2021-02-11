//
//  HydrometryHubeauValue.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 10/02/2021.
//

import Foundation
struct HydrometryHubeauValue: Codable {
    let codeBss: String?
    let codeSite: String?
    let codeStation: String?
    let grandeurHydro: String?
    let dateDebutSerie, dateFinSerie: Date?
    let statutSerie, codeSystemeAltiSerie: Int?
    let dateObs: Date?
    let resultatObs, codeMethodeObs: Int?
    let libelleMethodeObs: String?
    let codeQualificationObs: Int?
    let libelleQualificationObs: String?
    let continuiteObsHydro: Bool?
    let longitude, latitude: Double?
    
    enum CodingKeys: String, CodingKey {
        case codeBss = "code_bss"
        case codeSite = "code_Site"
        case codeStation = "code_Station"
        case grandeurHydro = "grandeur_Hydro"
        case dateDebutSerie = "date_Debut_Serie"
        case dateFinSerie = "Date_Fin_Serie"
        case statutSerie = "statut_Serie"
        case codeSystemeAltiSerie = "code_Systeme_Alti_Serie"
        case dateObs = "date_Obs"
        case resultatObs = "resultat_Obs"
        case codeMethodeObs = "code_Methode_Obs"
        case libelleMethodeObs = "libelle_Methode_Obs"
        case codeQualificationObs = "code_Qualification_Obs"
        case libelleQualificationObs = "libelle_Qualification_Obs"
        case continuiteObsHydro = "continuite_Obs_Hydro"
        case longitude
        case latitude
    }
}
