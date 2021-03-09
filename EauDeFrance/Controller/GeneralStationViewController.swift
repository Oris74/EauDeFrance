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
     
        self.lblZone2.attributedText = """
        <CENTER>
        <Table width=100%>
        <tr valign=top><td align=center>
            <TABLE width=80%>
            <tr><td colspan = 2><H3><center><b>Code d'identification : </b> \(station.stationCode)</H3></center></td><tr>
            <tr><td><b>Altitude : </b></td><td> \(station.altitude ) m</td><tr>
            <tr><td><b>Localité : </b></td><td>\(station.postalCode) \(station.townshipLabel.uppercased())</td><tr>
            <tr><td><b>Département : </b></td><td>\(station.countyLabel) (\(station.countyCode))</td><tr>
            <tr><td><b>localisation station </b></td><td>\(station.localization)</td><tr>
            <tr><td><b>Altitude : </b></td><td> \(station.altitude ) m</td><tr>
            <tr><td><b>cours d'eau : </b></td><td>\(station.streamLabel)</td><tr>
            <tr><td><b>Dernière mise à jour: </b></td><td>\(station.dateUPDT)</td><tr>
            </table>
        </td></tr></TABLE>
        </CENTER>
        """.htmlToAttributedString
    }

    func piezometryDetail(station: PiezometryODF){
        self.lblZone2.attributedText = """
        <CENTER>
        <Table width=100%>
        <tr valign=top><td align=center>
            <TABLE width=80%>
            <tr><td colspan = 2><H3><center><b>Code d'identification : </b> \(station.stationCode)</H3></center></td></tr>
            <tr><td><b>Altitude : </b></td><td>\(station.altitude ) m</td></tr>
            <tr><td><b>Localité : </b></td><td>\(station.postalCode) \(station.townshipLabel.uppercased())</td></tr>
            <tr><td><b> Département: </b></td><td> \(station.countyLabel) (\(station.countyCode))</td></tr>
            <tr><td><b>Mesures effectuées : </b></td><td> \(station.nbPiezoMeasurement)</td></tr>
            <tr><td><b>Profondeur d'investigation : </b></td><td>\(station.depthOfInvestigation) m</td></tr>
            <tr><td><b>Dernière mise à jour: </td><td></b> \(station.dateUPDT)</center></td></tr>
            </table>
        </td></tr></TABLE>
        </CENTER>
        """.htmlToAttributedString

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
