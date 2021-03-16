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
    func sideMenuWillOpen() { }

    func sideMenuWillClose() { }

    func sideMenuShouldOpenSideMenu() -> Bool {
        return true
    }

    func sideMenuDidClose() { }

    func sideMenuDidOpen() { }
}
