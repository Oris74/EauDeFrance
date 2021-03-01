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
    var pageControl =  UIPageControl()

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var bnNextPage: UIBarButtonItem!
    @IBOutlet weak var stationName: UILabel!
    @IBOutlet weak var county: UILabel!

    var stationPageViewController: StationPageViewController? {
        didSet {
           stationPageViewController?.stationDelegate = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpPageControl()

        self.stationName.text = (station.stationLabel)
        self.county.text = station.countyLabel
        self.pageControl.isUserInteractionEnabled = false
        
        self.pageControl.addTarget(self, action: #selector(StationViewController.didChangePageControlValue(sender:)), for: .valueChanged)
    }

    func setUpPageControl() {
        let navBarSize = navigationController!.navigationBar.bounds.size
        let origin = CGPoint(x:navBarSize.width/2,y:navBarSize.height/2)

        pageControl = UIPageControl(frame: CGRect(x: origin.x,y: origin.y,width: 10,height: 10))
        pageControl.currentPage = 0
        pageControl.tintColor = UIColor.black
        pageControl.pageIndicatorTintColor = UIColor.white
        pageControl.currentPageIndicatorTintColor = UIColor.black
        pageControl.numberOfPages = 3


        let title = UILabel()
        title.text = "Station N°:\(station.stationCode)"
        title.adjustsFontSizeToFitWidth = true

        let stackView = UIStackView(arrangedSubviews: [title, pageControl])

        stackView.setCustomSpacing(0, after: title)
        stackView.axis = .vertical

        navigationItem.titleView = stackView
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

