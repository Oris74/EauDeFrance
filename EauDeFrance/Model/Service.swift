//
//  ServicesODF.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 18/01/2021.
//

import Foundation
import UIKit

enum Service:String {
    case hydrometrie = "Hydrométrie"
    case temperature = "Température"
    case qualite_rivieres = "Qualité cours d'eau"
    case niveau_nappes = "Piézometrie"

    func logo() -> UIImage {
        return UIImage(named: "\(self)")!
    }
}
