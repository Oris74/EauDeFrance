//
//  StationViewController+StationVCDelegate.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 08/02/2021.
//

import UIKit

extension StationViewController: StationPageViewControllerDelegate {
    func sendStationToVC() -> StationODF {
        return self.station
    }

    func stationPageViewController(stationPageViewController: StationPageViewController,
        didUpdatePageCount count: Int) {
        pageControl.numberOfPages = count
    }

    func stationPageViewController(stationPageViewController: StationPageViewController,
        didUpdatePageIndex index: Int) {
        pageControl.currentPage = index
    }

}
