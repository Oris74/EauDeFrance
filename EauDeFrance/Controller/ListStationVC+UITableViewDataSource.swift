//
//  ListStationViewController1.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 22/01/2021.
//

import UIKit

extension ListStationViewController: UITableViewDataSource, VCUtilities {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let depackedStations = stations else {
            return 0 }
        return depackedStations.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "StationCell", for: indexPath) as! ListStationTableViewCell

        cell.cellDelegate = self

        let station = self.stations![indexPath.row]


        return cell
    }
}

extension ListStationViewController: UITableViewDelegate {
        private func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
            self.indexSelectedRow = indexPath
            self.performSegue(withIdentifier: "segueToDetailledStation", sender: indexPath)
        }
}
