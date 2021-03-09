//
//  ViewController.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 21/01/2021.
//

import UIKit
import ENSwiftSideMenu

class SideMenuNavigationController: ENSideMenuNavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Create a table view controller
        let tableViewController = SideMenuTableViewController()

        // Create side menu
        sideMenu = ENSideMenu(sourceView: view, menuViewController: tableViewController, menuPosition:.left)
        self.sideMenuController()?.sideMenu?.delegate = self
        // Set a delegate
        sideMenu?.delegate = self

        // Configure side menu
        sideMenu?.menuWidth = 180.0
        sideMenu?.allowPanGesture = false
        sideMenu?.allowLeftSwipe = true
        sideMenu?.allowRightSwipe = false
       
        // Show navigation bar above side menu
        view.bringSubviewToFront(navigationBar)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
