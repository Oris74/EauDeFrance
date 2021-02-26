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

    var currentDay: Date?
    var segmentedWeekDate: [Int:Date?] = [1:nil,2:nil,3:nil,4:nil,5:nil,6:nil,7:nil]
    var figuresChart: [Measure] = []
    var measure: [Measure] = []
    var startRange = Date()
    var endRange = Date()
    @IBOutlet weak var lineChartView: LineChartView!

    @IBOutlet weak var figuresDate: UILabel!

    @IBOutlet weak var segmentedWeek: UISegmentedControl!
    @IBOutlet weak var xLabel: UILabel!
    @IBOutlet weak var yLabel: UILabel!

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBAction func segmentedWeek(_ sender: UISegmentedControl) {
        manageSegmentedWeekBp(index: sender.selectedSegmentIndex)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        lineChartView.delegate = self
    }

    override func viewDidAppear(_ animated: Bool) {
        updateChart()
        super.viewDidAppear(animated)
    }

    func updateChart() {
        measure.removeAll()
        getFirstDay()
    }

    func getFirstDay() {
        let parameters:[[KeyRequest : String]] = [[.size: "1"]]

        activityIndicator.isHidden = false
        StationService.shared.current.getFigure(station: station, optionnalParam: parameters, callback: {[weak self] (dataStation, dataStatus, error) in
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
                for figure in figures {
                    if let hour = figure.tempMeasureHour {
                        if let date = figure.tempMeasureDate {
                            let timestamp = "\(date)T\(hour)Z"
                            if let value = figure.result,
                               let unit = figure.unitSymbol {
                                let newMeasure = Measure(timestamp: timestamp, value: value, unit: unit)
                                if (self?.measure.contains(where: {$0.date == newMeasure.date}) == false) {
                                    self?.measure.append(newMeasure)
                                    self?.endRange = newMeasure.date
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
                    if (self?.measure.contains(where: {$0.date == newMeasure.date}) == false) {
                        self?.measure.append(newMeasure)

                    }
                }
            default: break
            }
            self?.measure.sort {$0.date < $1.date}
            guard let lastDate = self?.measure.last else { return }

            guard let weekDay = lastDate.date.posInWeek() else { return }
            guard let beginRange = lastDate.date.getDateFor(day: -(weekDay)) else { return }
            guard let endRange = lastDate.date.getDateFor(day: +1) else { return }

            //return figures from 'beginRange' and below 'endRange' so end = lastDate+1
            let parameters:[[KeyRequest : String]] = [
                [.beginRange: beginRange.getDate()],
                [.endRange: endRange.getDate()]
            ]
            self?.startRange = beginRange
            self?.currentDay = endRange
            self?.getData(parameters: parameters, selectedDate: lastDate.date)

        })
    }

    func getData(parameters: [[KeyRequest : String]], selectedDate: Date ) {

        StationService.shared.current.getFigure(station: station, optionnalParam: parameters, callback: {[weak self] (dataStation, dataStatus, error) in
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
                for figure in figures {
                    if let hour = figure.tempMeasureHour {
                        if let date = figure.tempMeasureDate {
                            let timestamp = "\(date)T\(hour)Z"
                            if let value = figure.result, let unit = figure.unitSymbol {
                                let newMeasure = Measure(timestamp: timestamp, value: value, unit: unit )
                                if (self?.measure.contains(where: {$0.date == newMeasure.date}) == false) {
                                    self?.measure.append(newMeasure)
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
                    let value = figure.profondeurNappe
                    let unit = " m "
                    let newMeasure = Measure(timestamp: date, value: value, unit: unit)
                    if (self?.measure.contains(where: {$0.date == newMeasure.date}) == false) {
                        self?.measure.append(newMeasure)
                    }
                }

            default: break
            }
            self?.measure.sort {$0.date < $1.date}
            self?.activityIndicator.isHidden = true
            self?.setSegmentedWeek(date: selectedDate)
            guard let indexSegmentedBP = selectedDate.posInWeek() else { return }

            self?.manageSegmentedWeekBp(index: indexSegmentedBP )
        })
    }

    func setSegmentedWeek(date: Date) {
        guard let posDayInWeek = date.posInWeek() else { return }
        guard var currentDate = date.getDateFor(day: 7 - posDayInWeek) else { return }

        for pos in (0...8).reversed() {
            switch pos {
            case 1...7:
                segmentedWeek.setTitle(currentDate.getDay(), forSegmentAt: pos)
                if checkPresenceData(for: currentDate) {
                    segmentedWeek.setEnabled(true, forSegmentAt: pos)
                    segmentedWeekDate[pos] = currentDate
                } else {
                    segmentedWeek.setEnabled(false, forSegmentAt: pos)
                }

                guard let previousDate = currentDate.getDateFor(day: -1) else { return }
                currentDate = previousDate
            case 0:
                guard let firstMeasure = measure.first else { return }
                //guard let previousWeekDate = date.getDateFor(day: -posDayInWeek) else { return }

                if currentDate.getDate() >= firstMeasure.date.getDate() {
                    segmentedWeek.setEnabled(true, forSegmentAt: pos)
                } else {
                    segmentedWeek.setEnabled(false, forSegmentAt: pos)
                }
            case 8:
                guard let lastMeasure = measure.last else { return }
                guard let nextWeekDate = date.getDateFor(day: (8-posDayInWeek)) else { return }

                if nextWeekDate.getDate() <= lastMeasure.date.getDate() {
                    segmentedWeek.setEnabled(true, forSegmentAt: pos)
                } else {
                    segmentedWeek.setEnabled(false, forSegmentAt: pos)
                }
            default:
                segmentedWeek.setEnabled(false, forSegmentAt: pos)
            }
        }
    }

    func checkPresenceData(for date: Date) -> Bool {
        return self.measure.contains(where: {$0.date.getDate() == date.getDate()})
    }

    func manageSegmentedWeekBp(index: Int){

        switch index {
        case 0:
            setPreviousWeek()
        case 1...7:
            guard let selectedDay = segmentedWeekDate[index] else { return }
            guard let newDay = selectedDay else { return }

            let values = self.measure.filter { $0.date.getDate() == newDay.getDate() }
            figuresDate.text = newDay.getFullDay()
            setChartsData(figures: values)
            lineChartView.notifyDataSetChanged()
            segmentedWeek.selectedSegmentIndex = index
        default:
            setNextWeek()
        }
    }
    func setPreviousWeek(){
        guard let segmentDay = segmentedWeekDate[1] else { return }
        guard let currentSunday = segmentDay else { return }

        //API return figures >= 'beginRange' and < 'endRange'
        //both side are increased of 1 to manage previous and next range related to segmentedButtun

        guard let beginRange = currentSunday.getDateFor(day: -9) else { return }    //more than 1 week
        guard let endRange = currentSunday.getDateFor(day: +1) else { return }

        //previousSaturday is the selected segmentedButton
        guard let previousSaturday = currentSunday.getDateFor(day: -1) else { return }

        let parameters:[[KeyRequest : String]] = [
            [.beginRange: beginRange.getDate()],
            [.endRange: endRange.getDate()]
        ]
        getData(parameters: parameters, selectedDate: previousSaturday)

    }

    func setNextWeek(){
        guard let segmentDay = segmentedWeekDate[7] else { return }
        guard let currentSaturday = segmentDay else { return }

        //API return figures >= 'beginRange' and < 'endRange'
        //both side are increased of 1 to manage previous and next range related to segmentedButtun

        let beginRange = currentSaturday
        guard let endRange = currentSaturday.getDateFor(day: +9) else { return }

        //nextSunday is the selected segmentedButton
        guard let nextSunday = currentSaturday.getDateFor(day: +1) else { return }

        let parameters:[[KeyRequest : String]] = [
            [.beginRange: beginRange.getDate()],
            [.endRange: endRange.getDate()]
        ]
        getData(parameters: parameters, selectedDate: nextSunday)
    }

    func setChartsData(figures: [Measure]) {
        var set = LineChartDataSet()

        var entries = [ChartDataEntry]()
        for figure in figures {
            let yValue = figure.value
            let xValue = figure.date.convertTimetoXaxis()
            let entry = ChartDataEntry(x: xValue, y: yValue)
            entries.append(entry)
        }

        set = LineChartDataSet(entries: entries, label: figures[0].unit)
        set.mode = .cubicBezier
        set.drawCirclesEnabled = false
        set.lineWidth = 2
        set.setColor(.black)
        set.fill = Fill(color: .blue)
        set.fillAlpha = 0.8
        set.drawHorizontalHighlightIndicatorEnabled = false
        set.highlightColor = .systemRed

        let data = LineChartData(dataSet: set)

        data.setDrawValues(false)
      
        lineChartView.backgroundColor = UIColor(red: 230/255.0, green: 253/255.0, blue: 253/255.0, alpha: 1.0)
        lineChartView.noDataText = "No data"

        //Set the interactive style
        lineChartView.scaleYEnabled = false             //Cancel Y axis scaling
        lineChartView.doubleTapToZoomEnabled = true     //Double-click zoom
        lineChartView.dragEnabled = true                //Enable drag gesture
        lineChartView.dragDecelerationEnabled = true    //Whether there is an inertial effect after dragging
        lineChartView.dragDecelerationFrictionCoef = 0.9

        let legend = lineChartView.legend
        legend.horizontalAlignment = .center
        legend.orientation = .vertical
        legend.verticalAlignment = .top
        legend.formSize = 10.0
        legend.yEntrySpace = 12.0

        let xAxis = lineChartView.xAxis
        xAxis.axisLineWidth = 1.0 ///UIScreen.main.scale   //Set X axis width
        xAxis.labelPosition = .bottom               //The display position of the X axis
        xAxis.drawGridLinesEnabled = true           //draw grid lines
        xAxis.spaceMin = 2;                         //Set the label interval
        xAxis.axisMinimum = 0
        xAxis.labelTextColor = UIColor.blue//label text color
        xAxis.labelCount = 6
        xAxis.axisMaximum = 23

        let leftAxis = lineChartView.leftAxis
        leftAxis.labelCount = 15                    //The number of Y-axis labels
        leftAxis.forceLabelsEnabled = false         //Do not force to draw a specified number of labels
        leftAxis.axisMinimum = 0 //Set the minimum value of the Y axis
        leftAxis.drawZeroLineEnabled = true         //Draw from 0
        // leftAxis.axisMaximum = 1000               //Set the maximum value of the Y axis
        leftAxis.inverted = false                   //Whether to turn the Y axis upside down
        leftAxis.axisLineWidth = 1.0/UIScreen.main.scale //Set Y axis width
        leftAxis.axisLineColor = UIColor.blue       //Y axis color
        leftAxis.labelPosition = .outsideChart      //label position
        leftAxis.labelTextColor = UIColor.red       //Text color
        leftAxis.labelFont = UIFont.systemFont(ofSize: 10)  //Text font

        //Set the grid style
        leftAxis.gridLineDashLengths = [3.0,3.0]        //Set the grid line of dashed style
        leftAxis.gridColor = UIColor.init(red: 200/255.0, green: 200/255.0, blue: 200/255.0, alpha: 1) //Grid line color
        leftAxis.gridAntialiasEnabled = false            //Turn off antialiasing

        let rightAxis = lineChartView.rightAxis

        rightAxis.enabled = false //disable right axis

        //        lineChartView.backgroundColor = UIColor.clear

        //        lineChartView.xAxis.drawLabelsEnabled = true
        //        lineChartView.rightAxis.enabled = false
        //
        //        lineChartView.leftAxis.drawZeroLineEnabled = true
        //        lineChartView.xAxis.drawAxisLineEnabled = true
        //lineChartView.rightAxis.axisDependency

        // Breaks the ability to zoom
        //        lineChartView.xAxis.drawLabelsEnabled = true
        //        lineChartView.xAxis.granularity = 1
        //        lineChartView.xAxis.labelPosition = .bottom

        //        lineChartView.noDataText = "absence de donnée"
        // lineChartView.animate(xAxisDuration: 1.0, yAxisDuration: 1.0)
        //        lineChartView.chartDescription?.enabled = false

        lineChartView.data = data
    }

    //    func getDateValues(date: Date?) -> [Measure] {
    //        guard let date = date else { return [] }
    //        if date <= self.startRange {
    //        if let firstDate = date.getDateFor(days: -7)?.getDate() {
    //            let parameters:[[KeyRequest : String]] =
    //                    [[.beginRange: firstDate],[.endRange:date.getDate()]]
    //            self.startRange = date
    //            getData(parameters: parameters)
    //            }
    //        }
    //        let values = self.measure.filter { $0.date.getDate() == date.getDate() }
    //        return values.compactMap {$0}
    //    }


    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print(entry)
        self.xLabel.text = "\(entry.x) heure"
        self.yLabel.text = "\(entry.y) °C"
    }
}

class ChartXAxisFormatter: NSObject {
    fileprivate var dateFormatter: DateFormatter?
    fileprivate var referenceTimeInterval: TimeInterval?

    convenience init(referenceTimeInterval: TimeInterval, dateFormatter: DateFormatter) {
        self.init()
        self.referenceTimeInterval = referenceTimeInterval
        self.dateFormatter = dateFormatter
    }
}

extension ChartXAxisFormatter: IAxisValueFormatter {
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        guard let dateFormatter = dateFormatter,
              let referenceTimeInterval = referenceTimeInterval
        else {
            return ""
        }

        let date = Date(timeIntervalSince1970: value * 3600 * 24 + referenceTimeInterval)
        return dateFormatter.string(from: date)
    }
}
import Foundation

class KMChartAxisValueFormatter: NSObject,IAxisValueFormatter,IValueFormatter
{
    func stringForValue(_ value: Double, entry: ChartDataEntry, dataSetIndex: Int, viewPortHandler: ViewPortHandler?) -> String
    {
        //print("======\(value)")
        return String(format:"%.2f%%",value)
    }

    var values:NSArray?
    override init()
    {
        super.init()
    }

    init(_ values: NSArray)
    {
        super.init()

        self.values = values
    }



    func stringForValue(_ value: Double, axis: AxisBase?) -> String
    {
        //The value here refers to the number of data on the x axis
        if values == nil {
            return "\(value)"
        }

        //print("\(Int(value))")
        return self.values![Int(value)] as! String;

    }

}
