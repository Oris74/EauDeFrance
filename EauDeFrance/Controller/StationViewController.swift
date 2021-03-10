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


    var stationPageViewController: StationPageViewController? {
        didSet {
           stationPageViewController?.stationDelegate = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpPageControl()
        setupTitlePage()
        self.stationName.attributedText = "<center><b>\(station.stationLabel)</b><br />Commune INSEE : \(station.townshipCode)</center>".htmlToAttributedString
        self.pageControl.isUserInteractionEnabled = true
        self.pageControl.addTarget(self, action: #selector(StationViewController.didChangePageControlValue(sender:)), for: .valueChanged)
    }

    func setUpPageControl() {
        let navBarSize = navigationController!.navigationBar.bounds.size
        let origin = CGPoint(x:navBarSize.width/2,y:navBarSize.height/2)

        pageControl = UIPageControl(frame: CGRect(x: origin.x,y: origin.y,width: 10,height: 10))
        pageControl.currentPage = 0
        
        pageControl.pageIndicatorTintColor = UIColor.white
        pageControl.currentPageIndicatorTintColor = UIColor.blue
        pageControl.numberOfPages = 3

    }

    func setupTitlePage() {
        let title = UILabel()
        title.text =  "Station de \(StationService.shared.current.serviceName)"
        title.adjustsFontSizeToFitWidth = true

        let stackView = UIStackView(arrangedSubviews: [title, pageControl])

        stackView.setCustomSpacing(0, after: title)
        stackView.axis = .vertical

        navigationItem.titleView = stackView
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

