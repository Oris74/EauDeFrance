//
//  FigureStationViewController.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 05/02/2021.
//

import UIKit
import Charts

class FigureStationViewController: UIViewController {
    
    var months: [String]!

    @IBOutlet weak var barChartView: BarChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        let unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0, 4.0, 18.0, 2.0, 4.0, 5.0, 4.0]

        setChart(dataPoints: months, values: unitsSold)
        barChartView.noDataText = "absence de données"
        // Do any additional setup after loading the view.
    }

    func setChart(dataPoints: [String], values: [Double]) {

        var dataEntries: [BarChartDataEntry] = []

        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: values[i], data: nil)
            dataEntries.append(dataEntry)
        }
        barChartView.noDataText = "You need to provide data for the chart."
        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "Units Sold")
        let chartData = BarChartData(dataSet: chartDataSet)
        barChartView.data = chartData
    }

}
