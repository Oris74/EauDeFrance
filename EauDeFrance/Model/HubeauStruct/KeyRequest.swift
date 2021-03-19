//
//  ServicesODF.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 18/01/2021.
//

import Foundation

// MARK: Hubeau Keys use for query
enum KeyRequest: String {
    case area = "bbox"
    case stationCode = "code_station"
    case page = "page"
    case sort = "sort"
    case size = "size"
    case stationPiezo = "code_bss"
    case activityFrom = "date_recherche"
}
