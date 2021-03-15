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

    @IBOutlet weak var lblZone2: UILabel!

    private var distanceSpan: CLLocationDistance = 500
    private var stationService = StationService.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        setupMapView()

        switch station {
        case let temperatureStation as TemperatureODF:
            temperatureDetail(station: temperatureStation)
        case let piezometryStation as PiezometryODF:
            piezometryDetail(station: piezometryStation)

        default: break
        }
    }

    func temperatureDetail(station: TemperatureODF){

        let data = [
            ["Identifiant", station.stationCode],
            ["Altitude", station.altitude + " m "],
            ["Localité", "\(station.postalCode) \(station.townshipLabel.uppercased())"],
            ["Département", "\(station.countyLabel) (\(station.countyCode))"],
            ["Région", "\(station.regionLabel)(\(station.regionCode))"],
            ["Localisation", station.localization],
            ["Cours d'eau", "\(station.streamLabel) (\(station.streamCode))"],
            ["Mise à jour", station.dateUPDT],
        ]
        self.lblZone2.attributedText = textFormatter(data: data)
    }

    func piezometryDetail(station: PiezometryODF){
        let data = [
            ["Identifiant", station.stationCode],
            ["Altitude", station.altitude + " m "],
            ["Localité", "\(station.postalCode) \(station.townshipLabel.uppercased())"],
            ["Département", "\(station.countyLabel) (\(station.countyCode))"],
            ["Mesures disponibles", station.nbPiezoMeasurement],
            ["Démarrage des Mesures", station.startMeasurementDate],
            ["Fin des mesures", station.endMeasurementDate],
            ["Mise a jour", station.dateUPDT],
        ]
        self.lblZone2.attributedText = textFormatter(data: data)
    }

    func setupMapView() {
        let currentPlace = CLLocationCoordinate2D(latitude: station.latitude, longitude: station.longitude)

        mapViewStation.delegate = self
        mapViewStation.isZoomEnabled = false
        mapViewStation.isScrollEnabled  = false
        mapViewStation.showsCompass = true
        mapViewStation.mapType = .hybrid
        mapViewStation.showsCompass = true
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
