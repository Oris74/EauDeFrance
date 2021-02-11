//
//  TableViewCell.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 23/01/2021.
//

import UIKit

extension ListStationViewController: UITableViewDelegate {
        private func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
            self.indexSelectedRow = indexPath
            self.performSegue(withIdentifier: "segueToStationVC", sender: indexPath)
        }
}

