//
//  Measure.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 22/02/2021.
//

import Foundation

struct Measure {
    var date: Date
    var value: Double

    init(timestamp: String, value: Double) {
        self.value = value

        let dateFormatter = DateFormatter()
        dateFormatter.locale = .current
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

        //according to date format your date string
        self.date = dateFormatter.date(from: timestamp) ?? Date()
    }
}

