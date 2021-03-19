//
//  StationService.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 14/01/2021.
//

import Foundation

// MARK: state of EauDeFrance - Map or List / Piezometry or Temperature


class StationService  {
    enum TabMenuODF {
        case map , list
    }

    static var shared = StationService()
    
    var currentTab: TabMenuODF
    var current: ManageService
    
    init() {
        self.current = Temperature.shared
        self.currentTab = .map
    }
}
