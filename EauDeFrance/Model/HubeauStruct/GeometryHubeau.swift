//
//  Geometry.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 07/01/2021.
//

import Foundation

// MARK: - Geometry
struct GeometryHubeau: Codable {
    let type: String?
    let crs: CRSHubeau?
    let coordinates: [Double]?
}
