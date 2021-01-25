//
//  ListStationVC:PassDataToVC.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 22/01/2021.
//

import UIKit

extension  ListStationViewController  {
    func didButtonPressed(cell: ListStationTableViewCell) {

        if let indexPath = self.tableview.indexPath(for: cell) {

        }
        DispatchQueue.main.async {
            self.tableview.reloadData()
        }
    }

    func sendToVC(updatedStation: StationODF) {
//        for (index, station) in stations.enumerated()
//        where updatedStation.id == station.id {
//
//            DispatchQueue.main.async {
//                self.tableview.reloadData()
//            }
//        }
    }


}
