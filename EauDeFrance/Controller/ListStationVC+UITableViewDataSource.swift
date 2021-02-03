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
        guard let depackedStations = self.stations else {
            return 0 }
        return depackedStations.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "StationCell", for: indexPath) as! ListStationTableViewCell

        cell.cellDelegate = self

        let station = self.stations[indexPath.row]
        cell.titleStation.text = (station.townshipCode ?? "")+" " + (station.townshipLabel ?? "")
        cell.detailStation.text = (station.stationLabel ?? "")+("\nStation ID:" + (station.stationCode ?? ""))

        return cell
    }
}
