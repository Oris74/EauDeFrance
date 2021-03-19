//
//  Measure.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 22/02/2021.
//

import Foundation

// MARK: - Stock vlaes of stream Temperature or height of water table (Piezometry)
struct Measure: Equatable {
    var date: Date
    var value: Double
    var unit: String
    init(timestamp: String, value: Double, unit: String) {
        self.value = value
        self.unit = unit
        let dateFormatter = DateFormatter()
        dateFormatter.locale = .current
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        //according to date format your date string
        self.date = dateFormatter.date(from: timestamp) ?? Date()
    }
}

