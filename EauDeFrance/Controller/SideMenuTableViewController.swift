//
//  SideMenuTableViewController.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 21/01/2021.
//

import UIKit
import ENSwiftSideMenu

class SideMenuTableViewController: UITableViewController, VCUtilities {
    private let menuOptionCellId = "Cell"
    var selectedMenuItem : Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Customize apperance of table view
        tableView.contentInset = UIEdgeInsets(top: 64.0, left: 0, bottom: 0, right: 0)
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.clear
        tableView.scrollsToTop = false

        // Preserve selection between presentations
        clearsSelectionOnViewWillAppear = false

        // Preselect a menu option
        tableView.selectRow(at: IndexPath(row: selectedMenuItem, section: 0), animated: false, scrollPosition: .middle)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        var cell = tableView.dequeueReusableCell(withIdentifier: menuOptionCellId)

        if (cell == nil) {
            cell = UITableViewCell(style:.default, reuseIdentifier: menuOptionCellId)
            cell!.backgroundColor = .clear
            cell!.textLabel?.textColor = .darkGray
            switch indexPath.row {
            case 0:
                cell!.imageView?.image = UIImage(named: Temperature.shared.apiName)?.resize(height: 30)
                cell!.textLabel?.text = Temperature.shared.serviceName
            case 1:
                cell!.imageView?.image = UIImage(named: Hydrometry.shared.apiName)?.resize(height: 30)
                cell!.textLabel?.text = Hydrometry.shared.serviceName
            case 2:
                cell!.imageView?.image = UIImage(named: Piezometry.shared.apiName)?.resize(height: 30)
                cell!.textLabel?.text = Piezometry.shared.serviceName
            default:
                cell!.imageView?.image = UIImage(named: StreamQuality.shared.apiName)?.resize(height: 30)
                cell!.textLabel?.text = StreamQuality.shared.serviceName
            }

            let selectedBackgroundView = UIView(frame: CGRect(x: 0, y: 0, width: cell!.frame.size.width, height: cell!.frame.size.height))
            selectedBackgroundView.backgroundColor = UIColor.gray.withAlphaComponent(0.2)
            cell!.selectedBackgroundView = selectedBackgroundView
        }
        return cell!
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        print("did select row: \(indexPath.row)")

        if (indexPath.row == selectedMenuItem) {
            return
        }

        selectedMenuItem = indexPath.row

        //Present new view controller
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
        var destViewController : UIViewController
        switch (indexPath.row) {
        case 0:
            StationService.shared.current = Temperature.shared
            break
        case 1:
            StationService.shared.current = Hydrometry.shared
            break
        case 2:
            StationService.shared.current = Piezometry.shared
            break
        default:
            StationService.shared.current = StreamQuality.shared
            break
        }

        switch StationService.shared.currentMenu {
        case .list:
            destViewController = mainStoryboard.instantiateViewController(withIdentifier: "listViewID")
        case .map:
            destViewController = mainStoryboard.instantiateViewController(withIdentifier: "mapViewID")
        }

        sideMenuController()?.setContentViewController(destViewController)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
