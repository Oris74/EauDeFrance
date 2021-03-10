//
//  DetailedStationViewController.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 05/02/2021.
//

import UIKit

class DetailedStationViewController: UIViewController {
    var station: StationODF!
    var values: StationService!

    @IBOutlet weak var lblZone1: UILabel!



    override func viewDidLoad() {
        super.viewDidLoad()
        switch station {
        case let temperatureStation as TemperatureODF:
            temperatureDetail(station: temperatureStation)
        case let piezometryStation as PiezometryODF:
            piezoDetail(station: piezometryStation)

        default: break
        }
    }
    
   
//    @IBAction func bpZone3Tapped(_ sender: UIButton) {
//        var webSite = ""
//        let webVC = WebViewController()
//
//        switch station {
//        case let temperatureStation as TemperatureODF:
//            webSite = temperatureStation.uriStream
//
//        case let piezometryStation as PiezometryODF:
//             webSite = piezometryStation.uriStation
//
//        default: break
//        }
//
//        if webSite == "" { return }
//        webVC.hubeauURL = webSite
//        let nav = UINavigationController(rootViewController: webVC)
//
//        present(nav, animated: true)
//
//    }
//
//    @IBAction func bpZone4Tapped(_ sender: UIButton) {
//        var webSite = ""
//        let webVC = WebViewController()
//
//        switch station {
//        case let temperatureStation as TemperatureODF:
//             webSite = temperatureStation.uriBodyOfWater
//
//        case let piezometryStation as PiezometryODF:
//
//            webSite = piezometryStation.urnsBdLisa[0]
//
//        default: break
//        }
//
//        if webSite == "" { return }
//        webVC.hubeauURL = webSite
//
//        let nav = UINavigationController(rootViewController: webVC)
//        present(nav, animated: true)
//    }
    func temperatureDetail(station: TemperatureODF){
        self.lblZone1.attributedText = """
        <Table width=100%>
        <tr valign=top><td align=center>
            <TABLE width=80%>
            <tr><td colspan = 2><H3><center><b>Code d'identification : </b>\(station.stationCode)</H3></center></td></tr>
            <tr><td><b>Point Kilométrique : </b></td><td> \(station.pointKM) </td></tr>
            <tr><td><b>Localisation : </b></td><td>\(station.localization)</td></tr>
            <tr><td><b>Section Hydro : </b></td><td> \(station.hydroSectionCode) </td></tr>
            <tr><td><b>Bassin : </b></td><td>\(station.basinLabel)(\(station.basinCode))</td></tr>
            <tr><td><b>Sous Bassin : </b></td><td>\(station.subBasinLabel) (\(station.subBasinCode))</td></tr>
            <tr><td><b>Cours d'eau : </b></td><td>\(station.streamLabel) (\(station.streamCode))</td></tr>
            <tr><td><b>Masse d'eau : </b></td><td>\(station.bodyOfWaterLabel)(\(station.bodyOfWaterCode))</td></tr>
            </table>
        </td></tr></TABLE>
        """.htmlToAttributedString
    }


    func piezoDetail(station: PiezometryODF) {
    
        self.lblZone1.attributedText = """
        <Table width=100%>
        <tr><td>
            <TABLE valign="top" width=80%>
            <tr><td colspan = 2><H3><center><b>Code d'identification : </b>\(station.stationCode)</H3></center></td></tr>
            <tr><td><b>Code BSS: </b></td><td> \(station.bssId) </td></tr>
            <tr><td><b>Quantité de mesures Réalisées :  </b></td><td>\(station.nbPiezoMeasurement)</td></tr>
            <tr><td><b>identifiant Lisa:</b></td><td> \(station.bdLisaCode[0]) </td></tr>
            <tr><td><b>Latitude :</b> \(String(format: "%.2f",station.latitude))</td><td><b>longitude : </b>\(String(format: "%.2f",station.longitude))</td></tr>
            <tr><td valign="top"><b>Profondeur d'investigation : </b></td><td>\(station.depthOfInvestigation) m</td></tr>
            <tr><td valign="top"><b>Masse d'eau : </b></td><td>\(arrayToStr(station.bodyOfWaterLabel ,station.bodyOfWaterCode))</td></tr>
            <tr><td width=40%><b>Mise à jour :</b></td><td width=60%>\(station.dateUPDT)</td></tr>
            </table>
        </td></tr></TABLE>
        """.htmlToAttributedString
    }

    func arrayToStr(_ field: [String], _ field2: [String]) -> String {
        let qtyField = field.count
        let qtyField2 = field2.count
        var formattedResult = ""

        for index in 0..<qtyField {
            if index < qtyField2 {
            formattedResult += "\(field[index]) (\(field2[index]))<br />"
            } else {
                formattedResult += "\(field[index])<br />"
            }
        }
        return formattedResult
    }
}
