//
//  ViewController.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 21/01/2021.
//

import UIKit
import ENSwiftSideMenu

class SideMenuNavigationController: ENSideMenuNavigationController {
    let tableViewController = SideMenuTableViewController()

    override func viewDidLoad() {
        super.viewDidLoad()

        sideMenu = ENSideMenu(sourceView: view, menuViewController: tableViewController, menuPosition:.left)
        self.sideMenuController()?.sideMenu?.delegate = self
        sideMenu?.delegate = self

        // Configure side menu
        sideMenu?.menuWidth = 180.0
        sideMenu?.allowPanGesture = false
        sideMenu?.allowLeftSwipe = true
        sideMenu?.allowRightSwipe = false

        // Show navigation bar above side menu
        view.bringSubviewToFront(navigationBar)

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        var currentRow:Int

        switch (StationService.shared.current.serviceName) {
        case "Température":
            currentRow = 0
        default:
            currentRow = 1
        }
        tableViewController.tableView.selectRow(at: IndexPath(row: currentRow, section: 0), animated: false, scrollPosition: .none)
        tableViewController.selectedMenuItem = currentRow
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
