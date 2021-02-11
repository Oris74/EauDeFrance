//
//  StationService.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 14/01/2021.
//

import Foundation


class StationService  {

    static var shared = StationService()

    var currentMenu: MenuODF
    var current: ManageService
    
    init() {
        self.current = Temperature.shared
        self.currentMenu = .map
    }
}
