//
//  MapViewController.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 05/01/2021.
//

import UIKit
import MapKit
import ENSwiftSideMenu

class MapViewController: UIViewController, VCUtilities {

    internal var stationService: StationService

    internal var locationManager = CLLocationManager()
    internal var stepperIndex: Int = 0
    internal var stations = [StationODF]()
    //internal var service: Service
    
    private var currentPlace = CLLocationCoordinate2D(latitude: 46.227638, longitude: 2.213749)
    private var distanceSpan: CLLocationDistance = 1500

    lazy var serviceStackView: UIStackView = {
        let serviceLabel = UILabel()
        serviceLabel.textAlignment = .left
        serviceLabel.text = stationService.service.rawValue.uppercased()
        serviceLabel.adjustsFontSizeToFitWidth = true
        let logoService = stationService.service.logo().resize(height: 30)
        let logoServiceView = UIImageView(image: logoService)

        let stackView = UIStackView(arrangedSubviews: [ logoServiceView, serviceLabel])
        stackView.setCustomSpacing(10, after: logoServiceView)
        stackView.axis = .horizontal
        return stackView
    }()

    @IBOutlet weak var mapView: MKMapView!

    @IBOutlet weak var stepperMAp: UIStepper!

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    @IBAction func magnifiyingGlass(_ sender: UIBarButtonItem) {

    }

    @IBAction func stepperMap(_ sender: UIStepper) {
        zoomInOut(newIndex: Int(sender.value))
    }


    @IBAction func mainMenu(_ sender: UIBarButtonItem) {
        toggleSideMenuView()
    }

    required init?(coder: NSCoder) {
        stationService = StationService.shared
        super.init(coder: coder)

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView.delegate = self
        self.sideMenuController()?.sideMenu?.delegate = self
        
        checkLocationServices()
        locationManager.startUpdatingLocation()

        if let location = locationManager.location?.coordinate {
            currentPlace = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
        } else {
            manageErrors(errorCode: .missingCoordinate)
        }

        navigationItem.titleView = serviceStackView
        refreshMap()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func viewDidAppear(_ animated: Bool) {
        activityIndicator.isHidden = false

        mapView.showsUserLocation = true
        spanLocationMap(coordinate: currentPlace, spanLat: 1, spanLong: 1)

       activityIndicator.isHidden = true
    }

    func refreshMap() {
        stationService.getStations(codeDept: "74", callback: {[weak self] ( stationList, error) in
            guard let depackedStations = stationList, error == nil else {
                self?.manageErrors(errorCode: error)
                return }
            self?.stations = depackedStations
            self?.displayStations()
        })
    }
}

