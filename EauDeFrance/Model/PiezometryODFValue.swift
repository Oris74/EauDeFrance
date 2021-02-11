//
//  PiezometryODFValue.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 10/02/2021.
//

import Foundation

struct PiezometryODFValue {
    let measureDate: String?
    let timestampMeasure: Int?
    let groundwaterLevel: Double?
    let obtainingMode: String?
    let status: String?
    let qualification: String?
    let continuationCode: String?
    let continuationName: String?
    let producerCode: String?
    let producerName: String?
    let typeMeasureCode, nameTypeMeasure: String?
    let waterTableDepth: Double?
}
