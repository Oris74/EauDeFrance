//
//  ChartXAxisFormatter1.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 02/03/2021.
//

import Foundation
import Charts

extension ChartXAxisFormatter: IAxisValueFormatter {

    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        
        axis?.drawLabelsEnabled = true
        axis?.setLabelCount(10, force: false)
        let date = Date(timeIntervalSince1970: value * referenceTimeInterval )
        let time = dateFormatter.string(from: date)
        return "\(time)"
    }
}
