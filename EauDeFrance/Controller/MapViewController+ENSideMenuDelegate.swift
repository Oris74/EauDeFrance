//
//  ViewController.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 21/01/2021.
//

import UIKit
import ENSwiftSideMenu

extension MapViewController: ENSideMenuDelegate {
    func sideMenuWillOpen() {

    }

    func sideMenuWillClose() {

    }

    func sideMenuShouldOpenSideMenu() -> Bool {
        return true
    }

    func sideMenuDidOpen() {

    }

    func sideMenuDidClose() {
        refreshMap()
    }
}
