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

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableview.delegate = self
        self.tableview.dataSource = self

        self.mapVCDelegate = tabBarController?.viewControllers?.first?.children[0] as? MapViewController
        self.sideMenuController()?.sideMenu?.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        stationService.currentMenu = .list
        navigationItem.titleView = serviceStackView(service: stationService.current)
        if stations == nil {
            populateStationsList()
        }
        tableview.reloadData()
        self.tabBarController?.tabBar.isHidden = false

        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light //For light mode
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        hideSideMenuView()
        if segue.identifier == "segueToStationVC" {
            let pageVC = segue.destination as! StationViewController
            if let selectedStation = self.tableview.indexPathForSelectedRow {
                pageVC.station = self.stations[selectedStation.row]
                self.tabBarController?.tabBar.isHidden = true
            } else { return }
        }
    }

    func populateStationsList() {
        guard let zone =  mapVCDelegate.mapArea else { return }
        let request: [[KeyRequest:String]] = [[.area:zone],[.size:"2000"]]
        stationService.current.getStation(parameters: request, callback: {[weak self] ( stationList, error) in
            guard let depackedStations = stationList, error == nil else {
                self?.manageErrors(errorCode: error)
                return }

            self?.stations = depackedStations
            self?.tableview.reloadData()
            self?.mapVCDelegate.displayStation(stations: depackedStations)
            self?.tabBarController?.tabBar.items?[1].isEnabled = true
        })
    }
}
