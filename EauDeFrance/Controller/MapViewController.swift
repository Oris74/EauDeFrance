//
//  MapViewController.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 05/01/2021.
//

import UIKit
import MapKit
import ENSwiftSideMenu

class MapViewController: UIViewController, VCUtilities, UITabBarControllerDelegate {

    internal var stationService = StationService.shared
    private let postalCodeFrance = ManagePostalCode.shared

    internal var listVCDelegate: ListStationViewController?

    internal var locationManager = CLLocationManager()
    internal var currentPlace = CLLocationCoordinate2D(latitude: 46.227638, longitude: 2.213749)
    private var distanceSpan: CLLocationDistance = 1500

    internal var stepperIndex: Int = 0

    var mapArea: String?

    @IBOutlet weak var mapView: MKMapView!

    @IBOutlet weak var stepperMap: UIStepper!

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    @IBAction func stepperMap(_ sender: UIStepper) {
       zoomInOut(newIndex: Int(sender.value))
    }

    @IBAction func mainMenu(_ sender: UIBarButtonItem) {
        toggleSideMenuView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func viewDidLoad() {

        super.viewDidLoad()
        self.mapView.delegate = self
        self.sideMenuController()?.sideMenu?.delegate = self

        self.listVCDelegate = tabBarController?.viewControllers?[1].children[0] as? ListStationViewController

        setupLocationService()
        locationManager.startUpdatingLocation()

        self.tabBarController?.delegate = self

    }

    func launchscreenVC() {

        var launchVC: UIViewController
        let defaults = UserDefaults.standard

        if !defaults.bool(forKey: "launchVC") {

            if #available(iOS 13.0, *) {
                overrideUserInterfaceStyle = .light //For light mode
            }

            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main",bundle: nil)

            launchVC = mainStoryboard.instantiateViewController(withIdentifier: "LaunchVC")
            launchVC.modalPresentationStyle = .fullScreen

            present(launchVC, animated: false)

            postalCodeFrance.importPostalCode(completion: {[weak self] error in
                launchVC.dismiss(animated: false, completion: nil)
                if error != nil {
                    self?.manageErrors(errorCode: error)
                }
                defaults.set(true, forKey: "launchVC" )
            })
        }
    }

    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)

        navigationItem.titleView = serviceStackView(service: stationService.current)
        self.tabBarController?.tabBar.isHidden = false
    }

    override func viewDidAppear(_ animated: Bool) {

        launchscreenVC()

        stationService.currentMenu = .map
        
        self.activityIndicator.isHidden = true

        mapView.showsUserLocation = true
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        manageErrors(errorCode: Utilities.ManageError.memoryIssue)
    }

}
