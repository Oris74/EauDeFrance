//
//  StationPageViewController.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 04/02/2021.
//

import UIKit


// MARK: Manage 3 pages for the station description (General, Detailled, graph of values)
class StationPageViewController: UIPageViewController  {

    weak var stationDelegate: StationPageViewControllerDelegate?

    //presentation Order of the view Controllers
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

    func scrollToViewController(index newIndex: Int) {
        if let firstViewController = viewControllers?.first,
           let currentIndex = orderedViewControllers.firstIndex(of: firstViewController) {
            let direction: UIPageViewController.NavigationDirection = newIndex >= currentIndex ? .forward : .reverse
            let nextViewController = orderedViewControllers[newIndex]
            scrollToViewController(viewController: nextViewController, direction: direction)
        }
    }

    private func newStationPageViewController(description: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil) .
            instantiateViewController(withIdentifier: "\(description)ViewController")
    }

    /// move forward to the next page
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

    /// transfert data station to the right page
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
