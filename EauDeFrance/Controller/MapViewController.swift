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
    internal var listVCDelegate: ListStationViewController?

    //var stations: [StationODF]?
    
    internal var locationManager = CLLocationManager()
    private var currentPlace = CLLocationCoordinate2D(latitude: 46.227638, longitude: 2.213749)
    private var distanceSpan: CLLocationDistance = 1500

    internal var stepperIndex: Int = 0

    @IBOutlet weak var mapView: MKMapView!

    @IBOutlet weak var stepperMap: UIStepper!

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    @IBAction func magnifiyingGlass(_ sender: UIBarButtonItem) {

    }

    @IBAction func stepperMap(_ sender: UIStepper) {
        zoomInOut(newIndex: Int(sender.value))
    }


    @IBAction func mainMenu(_ sender: UIBarButtonItem) {
        toggleSideMenuView()
    }

    @IBAction func addCustomDoc(_ sender: UIBarButtonItem) {

    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView.delegate = self
        self.sideMenuController()?.sideMenu?.delegate = self

        self.listVCDelegate = tabBarController?.viewControllers?[1].children[0] as? ListStationViewController

        self.currentPlace = setupLocationService()
        locationManager.startUpdatingLocation()

        navigationItem.titleView = serviceStackView(service: stationService.current)

        self.tabBarController?.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(_ animated: Bool) {

        stationService.currentMenu = .map

        mapView.showsUserLocation = true
        spanLocationMap(coordinate: currentPlace, spanLat: 1, spanLong: 1)
    }
}
