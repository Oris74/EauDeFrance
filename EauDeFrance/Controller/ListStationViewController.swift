//
//  ListStationViewController.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 22/01/2021.
//

import UIKit

class ListStationViewController: UIViewController, PassDataToVC {
    var stations:[StationODF]!

    var indexSelectedRow = NSIndexPath()

    @IBOutlet weak var tableview: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableview.delegate = self
        self.tableview.dataSource = self
    }

    override func viewWillAppear(_ animated: Bool) {
        tableview.reloadData()
        super.viewWillAppear(animated)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToDetailledStation" {
            let stationVC = segue.destination as! StationViewController
            if let selectedRecipe = self.tableview.indexPathForSelectedRow {
                stationVC.delegate = self
                stationVC.station = stations[selectedRecipe.row]
            } else { return }
        }
    }
}
