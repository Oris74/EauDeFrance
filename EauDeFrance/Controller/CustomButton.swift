//
//  CustomButton.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 23/01/2021.
//

import UIKit

class CustomButton: UIButton {
    private var station: StationODF?

    func setStation(station: StationODF?) {
        self.station = station
    }

    func getStation() -> StationODF? {
        return station
    }
}
