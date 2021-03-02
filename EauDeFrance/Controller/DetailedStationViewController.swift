//
//  DetailedStationViewController.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 05/02/2021.
//

import UIKit

class DetailedStationViewController: UIViewController {
    var station: StationODF!

    @IBOutlet weak var lblStream: UILabel!
    @IBOutlet weak var lblRegion: UILabel!
    @IBOutlet weak var lblBodyOfWater: UILabel!
    @IBOutlet weak var lblSubBasin: UILabel!
    @IBOutlet weak var lblOther: UILabel!
    

    @IBOutlet weak var bpBodyOfWater: UIButton!
    @IBOutlet weak var bpBasin: UIButton!


    override func viewDidLoad() {
        super.viewDidLoad()

        switch station {
        case let temperatureStation as TemperatureODF:
            self.lblStream.text = temperatureStation.streamLabel
            self.lblRegion.text = temperatureStation.regionLabel
            self.lblSubBasin.text = temperatureStation.subBasinLabel
            self.lblOther.text = "Code Hydro :\(temperatureStation.hydroSectionCode)"
            self.lblBodyOfWater.text = temperatureStation.bodyOfWaterLabel
        case let piezometryStation as PiezometryODF:
            self.lblOther.text = piezometryStation.info
        default: break
        }

    }


    @IBAction func bpBasin(_ sender: UIButton) {

    }


    @IBAction func bpBodyOfWater(_ sender: UIButton) {

    }

}
