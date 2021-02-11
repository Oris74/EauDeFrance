//
//  GeneralStationViewController.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 05/02/2021.
//

import UIKit
import MapKit

class GeneralStationViewController: UIViewController, VCUtilities {
    weak var station: StationODF!

    @IBOutlet weak var mapViewStation: MKMapView!

    private var distanceSpan: CLLocationDistance = 500

    override func viewDidLoad() {
        super.viewDidLoad()
        setupMapView()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }

    func setupMapView() {
        let currentPlace = CLLocationCoordinate2D(latitude: station.latitude, longitude: station.longitude)

        mapViewStation.delegate = self
        mapViewStation.isZoomEnabled = true
        mapViewStation.isScrollEnabled  = true
        mapViewStation.showsCompass = true
        mapViewStation.mapType = .hybrid
        spanLocationMap(coordinate: currentPlace, spanLat: 1, spanLong: 1)

        self.mapViewStation.addAnnotation(station)
    }
}

extension GeneralStationViewController: MKMapViewDelegate {

    func spanLocationMap(coordinate: CLLocationCoordinate2D, spanLat: Double, spanLong: Double) {

        let region = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
        mapViewStation.setRegion(region, animated: true)
    }
    
    internal func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? StationODF else { return nil }
        let identifier = "stationODF"

        var view: StationAnnotationView

        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            as? StationAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView

        } else {
            view = StationAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = false
            view.calloutOffset = CGPoint(x: 0, y: 60)
        }

        view.image = UIImage(named: StationService.shared.current.apiName)!.resize(height: 40)
        return view
    }
}
