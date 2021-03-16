//
//  ViewController.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 08/02/2021.
//

import UIKit

extension StationPageViewController: UIPageViewControllerDelegate {

    func pageViewController(_ pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController],
                            transitionCompleted completed: Bool) {
        notifyStationDelegateOfNewIndex()
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        sendDataTo(pendingViewControllers[0])
    }
}
