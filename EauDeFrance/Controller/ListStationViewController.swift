//
//  ListStationViewController.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 22/01/2021.
//

import UIKit
import ENSwiftSideMenu

class ListStationViewController: UIViewController {

    var stations: [StationODF]!
    var indexSelectedRow = NSIndexPath()

    weak var mapVCDelegate: MapViewController!
    
    internal var stationService = StationService.shared

    @IBOutlet weak var tableview: UITableView!


    @IBAction func mainMenu(_ sender: UIBarButtonItem) {
        toggleSideMenuView()
    }

    @IBAction func magnifiyingGlass(_ sender: UIBarButtonItem) {

    }

    @IBAction func addCustomDoc(_ sender: UIBarButtonItem) {

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableview.delegate = self
        self.tableview.dataSource = self

        self.mapVCDelegate = tabBarController?.viewControllers?.first?.children[0] as? MapViewController
        self.sideMenuController()?.sideMenu?.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {

        stationService.currentMenu = .list
        navigationItem.titleView = serviceStackView(service: stationService.current)
        tableview.reloadData()
        super.viewWillAppear(animated)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "segueToStationVC" {
            let pageVC = segue.destination as! StationViewController
            if let selectedStation = self.tableview.indexPathForSelectedRow {
                pageVC.station = self.stations[selectedStation.row]
            } else { return }
        }
    }
}

extension ListStationViewController: ENSideMenuDelegate {

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

    }
}
