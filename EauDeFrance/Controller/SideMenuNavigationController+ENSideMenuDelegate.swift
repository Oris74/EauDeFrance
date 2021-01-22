//
//  MapViewController2.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 21/01/2021.
//

import UIKit
import ENSwiftSideMenu

extension SideMenuNavigationController: ENSideMenuDelegate {

    // MARK: - ENSideMenu Delegate
    func sideMenuWillOpen() {
        print("sideMenuWillOpen")
    }

    func sideMenuWillClose() {
        print("sideMenuWillClose")
    }

    func sideMenuShouldOpenSideMenu() -> Bool {
        print("sideMenuShouldOpenSideMenu")
        return true
    }

    func sideMenuDidClose() {
        print("sideMenuDidClose")
    }

    func sideMenuDidOpen() {
        print("sideMenuDidOpen")
    }
}
