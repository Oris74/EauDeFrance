//
//  FigureStationViewController.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 05/02/2021.
//

import UIKit
import Charts

class FigureStationViewController: UIViewController, VCUtilities {
    var station: StationODF!

    var months: [String]!

    @IBOutlet weak var barChartView: BarChartView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()


        months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        let unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0, 4.0, 18.0, 2.0, 4.0, 5.0, 4.0]

        updateChart()
        //setChart(dataPoints: months, values: unitsSold)
        barChartView.noDataText = "absence de données"
    }

    override func viewWillAppear(_ animated: Bool) {

        super.viewWillAppear(animated)
    }

    func updateChart() {
        activityIndicator.isHidden = false

        StationService.shared.current.getFigure(station: station, callback: {[weak self] (dataStation, dataStatus, error) in
            if (error != nil) {
                self?.manageErrors(errorCode: error)
                return
            }

            switch dataStation {
            case let dataStation as TemperatureODF:
                guard let figures = dataStation.figure, error == nil else {
                    self?.manageErrors(errorCode: Utilities.ManageError.undefinedError)
                    return
                }
                let range = figures.compactMap({ $0.result })
                self?.setChart(dataPoints: (self?.months)! , values: range)

            case let dataStation as PiezometryODF:
                guard let figures = dataStation.figure, error == nil else {
                    self?.manageErrors(errorCode: Utilities.ManageError.undefinedError)
                    return
                }
            default: break
            }

            self?.activityIndicator.isHidden = false
        })
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
