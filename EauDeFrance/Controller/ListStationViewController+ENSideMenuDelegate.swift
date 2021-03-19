//
//  ListStationViewController1.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 04/03/2021.
//

import UIKit
import ENSwiftSideMenu

extension ListStationViewController: ENSideMenuDelegate {
    
    func sideMenuWillOpen() {
    }
    
    func sideMenuWillClose() { }
    
    func sideMenuShouldOpenSideMenu() -> Bool {
        return true
    }
    
    func sideMenuDidOpen() { }
    
    func sideMenuDidClose() { }
}
