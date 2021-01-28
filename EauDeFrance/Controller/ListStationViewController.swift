//
//  ListStationViewController.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 22/01/2021.
//

import UIKit

class ListStationViewController: UIViewController {
    var stations: [StationODF]!
    var indexSelectedRow = NSIndexPath()

    weak var mapVCDelegate: MapViewController!
    
    internal var stationService = StationService.shared

    @IBOutlet weak var tableview: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableview.delegate = self
        self.tableview.dataSource = self

        self.mapVCDelegate = tabBarController?.viewControllers?.first?.children[0] as? MapViewController
    }

    override func viewWillAppear(_ animated: Bool) {

        self.stations = mapVCDelegate.stations
        tableview.reloadData()
        super.viewWillAppear(animated)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToDetailledStation" {
            let stationVC = segue.destination as! StationViewController
            if let selectedRecipe = self.tableview.indexPathForSelectedRow {
              //  stationVC.delegate = self
                stationVC.station = self.stations[selectedRecipe.row]
            } else { return }
        }
    }
    override func viewDidDisappear(_ animated: Bool) {
        mapVCDelegate.stations = self.stations
    }
}
