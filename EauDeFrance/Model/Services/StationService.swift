//
//  StationService.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 14/01/2021.
//

import Foundation


class StationService  {
    enum MenuODF {
        case map
        case list
    }

    static var shared = StationService()

    var currentMenu: MenuODF
    var current: ManageService
    
    init() {
        self.current = Piezometry.shared
        self.currentMenu = .map
    }
}
