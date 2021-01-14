//
//  ApiHeader.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 07/01/2021.
//

import Foundation

// MARK: - ApiHeader
struct ApiHubeauHeader<T: Codable>: Codable {
    let count: Int
    let first, last: String?
    let prev, next: String?
    let apiVersion: String
    let data: [T]?
}
