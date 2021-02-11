//
//  ServicesODF.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 18/01/2021.
//

import Foundation

enum KeyRequest: String {
    case area = "bbox"
    case county = "code_departement"
    case township = "code_commune_station"
    case streamCode = "code_cours_eau"
    case region = "code_region"
    case stationCode = "code_station"
    case field = "fields"
    case page = "page"
    case sort = "sort"
    case size = "size"
    case entityHydro = "code_entite"
    case max_result = "resultat_max"
    case min_result = "resulat_min"
    case stationPiezo = "code_bbs"

}
