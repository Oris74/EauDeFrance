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
    @IBOutlet weak var lblZone2: UILabel!
    @IBOutlet weak var lblZone3Bp: UILabel!
    @IBOutlet weak var lblZone4Bp: UILabel!
    @IBOutlet weak var lblZone5: UILabel!
    @IBOutlet weak var lblZone6: UILabel!

    @IBOutlet weak var bpZone3: UIButton!
    @IBOutlet weak var bpZone4: UIButton!


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
    
   
    @IBAction func bpZone3Tapped(_ sender: UIButton) {
        var webSite = ""
        let webVC = WebViewController()

        switch station {
        case let temperatureStation as TemperatureODF:
            webSite = temperatureStation.uriStream

        case let piezometryStation as PiezometryODF:
             webSite = piezometryStation.uriStation

        default: break
        }

        if webSite == "" { return }
        webVC.hubeauURL = webSite
        let nav = UINavigationController(rootViewController: webVC)

        present(nav, animated: true)

    }

    @IBAction func bpZone4Tapped(_ sender: UIButton) {
        var webSite = ""
        let webVC = WebViewController()

        switch station {
        case let temperatureStation as TemperatureODF:
             webSite = temperatureStation.uriBodyOfWater

        case let piezometryStation as PiezometryODF:

            webSite = piezometryStation.urnsBdLisa[0]

        default: break
        }

        if webSite == "" { return }
        webVC.hubeauURL = webSite

        let nav = UINavigationController(rootViewController: webVC)
        present(nav, animated: true)
    }

    func piezoDetail(station: PiezometryODF) {

        self.lblZone1.attributedText = """
<center><H2><b>Station : </center></H2></b> \(station.stationLabel)
<center><H2><b>nouveau code BSS : </center></H2></b> \(station.bssId)
\(station.postalCode)\(station.townshipLabel) (Code INSEE: \(station.townshipCode))
\(station.countyCode) \(station.countyLabel)
<center><H2><b>Quantité de mesures Réalisées : </center></H2><b>\(station.nbPiezoMeasurement)
<center><H2><b>Profondeur d'investigation : </center></H2><b> \(station.depthOfInvestigation)
""".htmlToAttributedString

        self.lblZone2.attributedText = """

<center><H2>Situation géographique</H2>
<b>Altitude : </b> \(station.altitude)
<b>Latitude : </b> \(String(format: "%.2f",station.latitude))  <b>longitude : </b>\(String(format: "%.2f",station.longitude))</center>

""".htmlToAttributedString

        self.lblZone3Bp.attributedText = """
<b>identifiant Lisa:</b>  \(station.bdLisaCode[0])
""".htmlToAttributedString

        self.lblZone4Bp.attributedText = """
<center><H2><b> Masse d'Eau </b></H2></center>
\(station.bodyOfWaterCode[0]) \(station.bodyOfWaterLabel[0])
""".htmlToAttributedString

        self.lblZone5.attributedText = """
<b>Démarrage des mesures : </b>\(station.startMeasurementDate)<p>
<b>fin des mesures : </b>\(station.endMeasurementDate)
""".htmlToAttributedString

        self.lblZone6.attributedText = """
Date de Mise à jour : \(station.dateUPDT)
""".htmlToAttributedString

    }

    func temperatureDetail(station: TemperatureODF){
        self.lblZone1.text = station.streamLabel
        self.lblZone2.text = station.regionLabel
        self.lblZone3Bp.text = station.subBasinLabel
        self.lblZone4Bp.text = "Code Hydro :\(station.hydroSectionCode)"
        self.lblZone5.text = station.bodyOfWaterLabel
    }
}

