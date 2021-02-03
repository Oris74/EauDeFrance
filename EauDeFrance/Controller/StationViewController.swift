//
//  StationViewController.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 23/01/2021.
//

import UIKit
import Charts
import MapKit

class StationViewController: UIViewController, VCUtilities {
    weak var delegate: PassDataToVC?

    var months: [String]!

    var station: StationODF!

    @IBOutlet weak var barChartView: BarChartView!

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var stationName: UILabel!

    @IBOutlet weak var subTitle: UILabel!

    @IBOutlet weak var stationDescription: UILabel!

    @IBOutlet weak var county: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.stationName.text = (station.stationCode ?? "")+"\n"+(station.stationLabel ?? "")
        self.subTitle.text = station.title
        self.stationDescription.text = (station.altitude ?? "?")+" m d'altitude"
        self.county.text = station.countyLabel

        months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        let unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0, 4.0, 18.0, 2.0, 4.0, 5.0, 4.0]

        setChart(dataPoints: months, values: unitsSold)
        barChartView.noDataText = "absence de données"

        super.viewDidLoad()

    }

    override func viewWillAppear(_ animated: Bool) {
       

        super.viewWillAppear(animated)
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
