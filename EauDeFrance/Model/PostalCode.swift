//
//  PostalCode.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 27/02/2021.
//

import Foundation

// MARK: store postal code of municipalities related to their INSEE Code
struct PostalCode: Codable {
    let inseeCode: String
    let townshipName: String
    let postalCode: String
    
    enum CodingKeys: String, CodingKey {
        case inseeCode = "insee_com"
        case townshipName = "nom_comm"
        case postalCode = "postal_code"
    }
}
