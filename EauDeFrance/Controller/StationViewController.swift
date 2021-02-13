//
//  StationViewController.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 23/01/2021.
//

import UIKit

class StationViewController: UIViewController, VCUtilities {

   // weak var delegate: PassDataToVC?
    weak var stationDelegate: StationPageViewControllerDelegate?
    
    var station: StationODF!

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var bpNextPage: UIButton!

    @IBOutlet weak var stationName: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    @IBOutlet weak var stationDescription: UILabel!
    @IBOutlet weak var county: UILabel!

    var stationPageViewController: StationPageViewController? {
        didSet {
           stationPageViewController?.stationDelegate = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.stationName.text = (station.stationLabel )
        self.subTitle.text = station.title

        self.stationDescription.text = (station.altitude )+" m d'altitude"
        self.county.text = station.countyLabel

        navigationItem.titleView = serviceStackView(service: StationService.shared.current)

        pageControl.addTarget(self, action: #selector(StationViewController.didChangePageControlValue(sender:)), for: .valueChanged)

    }

    override func viewWillAppear(_ animated: Bool) {

        super.viewWillAppear(animated)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let stationPageViewController = segue.destination as? StationPageViewController {
            self.stationPageViewController = stationPageViewController
            self.hidesBottomBarWhenPushed = false
        }

    }

    @IBAction func didBpbpNextPage(_ sender: Any) {
        stationPageViewController?.scrollToNextViewController()
    }
    /**
     Fired when the user taps on the pageControl to change its current page.
     */
    @objc func didChangePageControlValue(sender: UIPageControl) {
        stationPageViewController?.scrollToViewController(index: pageControl.currentPage)
    }
}

