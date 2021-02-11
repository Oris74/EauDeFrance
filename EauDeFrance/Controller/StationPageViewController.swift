//
//  StationPageViewController.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 04/02/2021.
//

import UIKit

class StationPageViewController: UIPageViewController  {

    weak var stationDelegate: StationPageViewControllerDelegate?

    private(set) lazy var orderedViewControllers: [UIViewController] = {
        return [self.newStationPageViewController(description: "GeneralStation"),
                self.newStationPageViewController(description: "DetailedStation"),
                self.newStationPageViewController(description: "FigureStation")]
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.dataSource = self
        self.delegate = self

        if let initialViewController = orderedViewControllers.first {
            scrollToViewController(viewController: initialViewController)
        }

        stationDelegate?.stationPageViewController(stationPageViewController: self, didUpdatePageCount: orderedViewControllers.count)

        // Do any additional setup after loading the view.

        setupPageControl()
    }

    private func setupPageControl() {
        let appearance = UIPageControl.appearance()
        appearance.pageIndicatorTintColor = UIColor.gray
        appearance.currentPageIndicatorTintColor = UIColor.white

    }

    func scrollToNextViewController() {
        if let visibleViewController = viewControllers?.first,
           let nextViewController = pageViewController(self, viewControllerAfter: visibleViewController) {
            scrollToViewController(viewController: nextViewController)
        }
    }

    private func newStationPageViewController(description: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil) .
            instantiateViewController(withIdentifier: "\(description)ViewController")
    }

    func scrollToViewController(index newIndex: Int) {
        if let firstViewController = viewControllers?.first,
           let currentIndex = orderedViewControllers.firstIndex(of: firstViewController) {
            let direction: UIPageViewController.NavigationDirection = newIndex >= currentIndex ? .forward : .reverse
            let nextViewController = orderedViewControllers[newIndex]

            scrollToViewController(viewController: nextViewController, direction: direction)
        }
    }


    private func scrollToViewController(viewController: UIViewController,
                                        direction: UIPageViewController.NavigationDirection = .forward) {

        sendDataTo(viewController)


        setViewControllers([viewController],
                           direction: direction,
                           animated: true,
                           completion: { (finished) -> Void in
                            self.notifyStationDelegateOfNewIndex()
                           })
    }

    /// MARK:  Notifies '_stationDelegate' that the current page index was updated.
    internal func notifyStationDelegateOfNewIndex() {
        if let firstViewController = viewControllers?.first,
           let index = orderedViewControllers.firstIndex(of: firstViewController) {
            stationDelegate?.stationPageViewController(stationPageViewController: self, didUpdatePageIndex: index)
        }
    }
    
    func sendDataTo(_ viewController: UIViewController) {
        let station = stationDelegate?.sendStationToVC()

        switch viewController {
        case let stationPageVC as GeneralStationViewController:
            stationPageVC.station = station
        case let stationPageVC as DetailedStationViewController:
            stationPageVC.station = station
        case let stationPageVC as FigureStationViewController:
            stationPageVC.station = station

        default: break
        }
    }
}
