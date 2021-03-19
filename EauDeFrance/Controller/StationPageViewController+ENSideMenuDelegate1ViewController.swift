//
//  StationPageViewController1ViewController.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 28/02/2021.
//

import Foundation
import ENSwiftSideMenu

/// need to be conforme to protocol ENSideMenu but not used
extension StationPageViewController: ENSideMenuDelegate {
    func sideMenuWillOpen() { }
    
    func sideMenuWillClose() { }
    
    func sideMenuShouldOpenSideMenu() -> Bool {
        return false
    }
    
    func sideMenuDidOpen() { }
    
    func sideMenuDidClose() { }
}
