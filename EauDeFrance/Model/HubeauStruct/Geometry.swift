//
//  Geometry.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 07/01/2021.
//

import Foundation

// MARK: - Geometry
struct Geometry: Codable {
    let type: String?
    let crs: CRS?
    let coordinates: [Double]?
}
