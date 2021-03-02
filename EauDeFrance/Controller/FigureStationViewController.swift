//
//  FigureStationViewController.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 05/02/2021.
//

import UIKit
import Charts

class FigureStationViewController: UIViewController, ChartViewDelegate, VCUtilities {
    var station: StationODF!

    @IBOutlet weak var lineChartView: LineChartView!

    @IBOutlet weak var xLabel: UILabel!
    @IBOutlet weak var yLabel: UILabel!

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    

    @IBOutlet weak var lblPeriodFrom: UILabel!

    @IBOutlet weak var lblPeriodTo: UILabel!


    override func viewDidLoad() {
        super.viewDidLoad()
        lineChartView.delegate = self
    }

    override func viewDidAppear(_ animated: Bool) {
        updateChart()
        super.viewDidAppear(animated)
    }

    func updateChart() {
        let parameters:[[KeyRequest : String]] = [[.size: "500"]]
        getData(parameters: parameters)
    }

    func getData(parameters: [[KeyRequest : String]]) {

        StationService.shared.current.getFigure(station: station, optionnalParam: parameters, callback: {[weak self] (dataStation, dataStatus, error) in
            if (error != nil) {
                self?.manageErrors(errorCode: error)
                return
            }
            var measure: [Measure] = []

            switch dataStation {
            case let dataStation as TemperatureODF:
                guard let figures = dataStation.figure, error == nil else {
                    self?.manageErrors(errorCode: Utilities.ManageError.undefinedError)
                    return
                }
                for figure in figures {
                    if let hour = figure.tempMeasureHour {
                        if let date = figure.tempMeasureDate {
                            let timestamp = "\(date)T\(hour)Z"
                            if let value = figure.result, let unit = figure.unitSymbol {
                                let newMeasure = Measure(timestamp: timestamp, value: value, unit: unit )
                                if (measure.contains(where: {$0.date == newMeasure.date}) == false) {
                                    measure.append(newMeasure)
                                }
                            }
                        }
                    }
                }

            case let dataStation as PiezometryODF:
                guard let figures = dataStation.figure, error == nil, figures.count > 0 else {
                    self?.manageErrors(errorCode: Utilities.ManageError.undefinedError)
                    return
                }
                for figure in figures {
                    let date = figure.dateMesure
                    let value = figure.niveauEauNgf
                    let unit = " m "
                    let newMeasure = Measure(timestamp: date, value: value, unit: unit)
                    if (measure.contains(where: {$0.date == newMeasure.date}) == false) {
                        measure.append(newMeasure)
                    }
                }

            default: break
            }
            measure.sort {$0.date < $1.date}
            self?.activityIndicator.isHidden = true

            self?.setChartsData(figures: measure)
        })
    }

    func setChartsData(figures: [Measure]) {

        guard let lastDate  = figures.last, let firstDate = figures.first else { return }

        self.lblPeriodTo.text = lastDate.date.getFullDay()
        self.lblPeriodFrom.text = firstDate.date.getFullDay()

        let hourSeconds: TimeInterval = 3600
        let nbDay = Int((lastDate.date.timeIntervalSince1970 - firstDate.date.timeIntervalSince1970) / hourSeconds/24)

        lineChartView.backgroundColor = UIColor(red: 230/255.0, green: 253/255.0, blue: 253/255.0, alpha: 1.0)
        lineChartView.noDataText = "No data"

        //Set the interactive style
        lineChartView.scaleYEnabled = false             //Cancel Y axis scaling
        lineChartView.doubleTapToZoomEnabled = true     //Double-click zoom
        lineChartView.dragEnabled = true                //Enable drag gesture
        lineChartView.dragDecelerationEnabled = true    //Whether there is an inertial effect after dragging
        lineChartView.dragDecelerationFrictionCoef = 0.9

        let legend = lineChartView.legend
        legend.horizontalAlignment = .left
        legend.orientation = .horizontal
        legend.verticalAlignment = .bottom
        legend.formSize = 10.0

        let xAxis = lineChartView.xAxis
        xAxis.labelPosition = .bottom
        xAxis.labelFont = .systemFont(ofSize: 10, weight: .light)
        xAxis.labelTextColor = UIColor(red: 255/255, green: 192/255, blue: 56/255, alpha: 1)
        xAxis.drawAxisLineEnabled = false
        xAxis.drawGridLinesEnabled = true
        xAxis.centerAxisLabelsEnabled = false
        xAxis.granularity = 24
        xAxis.axisMinimum = firstDate.date.timeIntervalSince1970/hourSeconds
        xAxis.labelTextColor = UIColor.blue //label text color
        xAxis.axisMaximum = lastDate.date.timeIntervalSince1970/hourSeconds
        xAxis.setLabelCount(nbDay, force: false)
        xAxis.labelRotationAngle = 45.0

        let dateFormatter = DateFormatter()
        dateFormatter.locale = .current
        dateFormatter.dateFormat = "dd-MMM HH:mm"
        xAxis.valueFormatter = ChartXAxisFormatter(referenceTimeInterval: hourSeconds, dateFormatter: dateFormatter)

        let leftAxis = lineChartView.leftAxis
        leftAxis.labelCount = 15                             //The number of Y-axis labels
        leftAxis.forceLabelsEnabled = false                  //Do not force to draw a specified number of labels
        leftAxis.axisMinimum = 0                             //Set the minimum value of the Y axis
        leftAxis.drawZeroLineEnabled = true                  //Draw from 0
        leftAxis.inverted = false                            //Whether to turn the Y axis upside down
        leftAxis.axisLineWidth = 1.0/UIScreen.main.scale     //Set Y axis width
        leftAxis.axisLineColor = UIColor.blue                //Y axis color
        leftAxis.labelPosition = .outsideChart               //label position
        leftAxis.labelTextColor = UIColor.red                //Text color
        leftAxis.labelFont = UIFont.systemFont(ofSize: 10)   //Text font

        //Set the grid style
        leftAxis.gridLineDashLengths = [3.0,3.0]        //Set the grid line of dashed style
        leftAxis.gridColor = UIColor.init(red: 200/255.0, green: 200/255.0, blue: 200/255.0, alpha: 1) //Grid line color
        leftAxis.gridAntialiasEnabled = false            //Turn off antialiasing

        let rightAxis = lineChartView.rightAxis
        rightAxis.enabled = false

        var values = [ChartDataEntry]()
        for figure in figures {
            let yValue = figure.value
            let xValue = figure.date.timeIntervalSince1970/hourSeconds
            let value = ChartDataEntry(x: xValue, y: yValue)
            values.append(value)
        }

        let set1 = LineChartDataSet(entries: values, label: figures[0].unit)
        set1.axisDependency = .left
        set1.setColor(.blue)
        set1.lineWidth = 1.5
        set1.drawCirclesEnabled = false
        set1.drawValuesEnabled = false
        set1.drawCircleHoleEnabled = false
        set1.drawFilledEnabled = true
        set1.fillColor = .cyan
        set1.fillAlpha = 0.2
        set1.highlightColor = .red

        let data = LineChartData(dataSet: set1)
        data.setValueTextColor(.blue)
        data.setValueFont(.systemFont(ofSize: 9, weight: .light))

        lineChartView.data = data
    }

    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        let date = Date(timeIntervalSince1970: (entry.x*3600))

        self.xLabel.text = "\(date.getFullDay()) - \(date.getFullTime())"
        self.yLabel.text = "\(entry.y)"
    }
}

