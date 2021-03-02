//
//  ChartXAxisFormatter.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 02/03/2021.
//

import Foundation
import Charts

class ChartXAxisFormatter: NSObject {
    var dateFormatter: DateFormatter
    var referenceTimeInterval: TimeInterval

    init(referenceTimeInterval: TimeInterval, dateFormatter: DateFormatter) {
        self.referenceTimeInterval = referenceTimeInterval
        self.dateFormatter = dateFormatter 
    }
}
