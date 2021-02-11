//
//  TemperatureODFValue.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 10/02/2021.
//

import Foundation

struct TemperatureODFValue {
    let parameterCode, parameterLabel, tempMeasureDate, tempMeasureHour: String?
    let result: Double?
    let unitCode, unitSymbol, qualificationCode, qualificationLabel: String?
}
