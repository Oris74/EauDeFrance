//
//  ViewController.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 08/02/2021.
//

import UIKit

protocol StationPageViewControllerDelegate: class {

    /**
     Called when the number of pages is updated.

     - parameter stationPageViewController: the StationPageViewController instance
     - parameter count: the total number of pages.
     */
    func stationPageViewController(stationPageViewController: StationPageViewController,
                                   didUpdatePageCount count: Int)

    /**
     Called when the current index is updated.

     - parameter stationPageViewController: the StationPageViewController instance
     - parameter index: the index of the currently visible page.
     */
    func stationPageViewController(stationPageViewController: StationPageViewController,
                                   didUpdatePageIndex index: Int)

}
