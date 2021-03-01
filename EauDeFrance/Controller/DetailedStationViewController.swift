//
//  DetailedStationViewController.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 05/02/2021.
//

import UIKit

class DetailedStationViewController: UIViewController {
    var station: StationODF!

    @IBOutlet weak var stream: UILabel!
    @IBOutlet weak var region: UILabel!
    @IBOutlet weak var subBasin: UILabel!
    @IBOutlet weak var label: UILabel!

    @IBOutlet weak var bodyOfWater: UIButton!
    @IBOutlet weak var basin: UIButton!


    override func viewDidLoad() {
        super.viewDidLoad()

        switch station {
        case let temperatureStation as TemperatureODF:
            self.stream.text = temperatureStation.streamLabel
            self.region.text = temperatureStation.regionLabel
            self.subBasin.text = temperatureStation.subBasinLabel
            self.label.text = "Code Hydro\(temperatureStation.hydroSectionCode ?? "")"

        case let piezometryStation as PiezometryODF:
            self.label.text = piezometryStation.info
        default: break
        }

    }


    @IBAction func bpBasin(_ sender: UIButton) {

    }


    @IBAction func bodyOfWater(_ sender: UIButton) {

    }

}
