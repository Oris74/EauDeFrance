//
//  Mapview.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 18/01/2021.
//

import UIKit
import MapKit

extension MapViewController: MKMapViewDelegate {
    /// MARK: Manage + /- buttons for zoom
   func zoomInOut(newIndex: Int){
        var region: MKCoordinateRegion = mapView.region
        if stepperIndex > newIndex {
            //Zoom In
            region.span.latitudeDelta = min(region.span.latitudeDelta * 2.0, 180.0)
            region.span.longitudeDelta = min(region.span.longitudeDelta * 2.0, 180.0)
        } else if (stepperIndex < newIndex) {
            //Zoom out
            region.span.latitudeDelta /= 2.0
            region.span.longitudeDelta /= 2.0
        }
        stepperIndex = newIndex
        mapView.setRegion(region, animated: true)
    }

    func spanLocationMap(coordinate: CLLocationCoordinate2D, spanLat: Double, spanLong: Double) {

        let span = MKCoordinateSpan(latitudeDelta: spanLat, longitudeDelta: spanLong)
        let region = MKCoordinateRegion(center: coordinate, span: span)

        mapView.setRegion(region, animated: true)
    }

    // enrichir les annotations
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

        view.image = UIImage(named: stationService.current.apiName)!.resize(height: 40)
        return view
    }

    /// MARK: Move the selected annotation to the center of the map
    /// MARK: Display Custom Call Out
    internal func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        switch view.annotation {
        case is MKUserLocation:
            // Don't proceed with custom callout
            return

        case let stationODF as StationODF:
            spanLocationMap(coordinate: stationODF.coordinate, spanLat: 1, spanLong: 1)

            let views = Bundle.main.loadNibNamed("CustomCallOutView", owner: nil, options: nil)

            let callOutView = views?[0] as! CustomCallOutView

            callOutView.backGroundView.layer.borderWidth = 2
            callOutView.backGroundView.layer.borderColor = UIColor.blue.cgColor
            
            let logo = UIImage(named: stationService.current.apiName)?.resize(height: 45)
            callOutView.logoService.image = logo
            callOutView.stationName.text = stationODF.stationCode
            callOutView.stationLabel.text = "\(stationODF.postalCode) \(stationODF.townshipLabel)"

            if let serviceODF = stationODF as? TemperatureODF {
                callOutView.streamLabel.text = serviceODF.streamLabel
                callOutView.streamLabel.isHidden = false
                callOutView.titleStationLabel.isHidden = false
            }

            if stationODF is PiezometryODF {
                callOutView.streamLabel.isHidden = true
                callOutView.titleStationLabel.isHidden = true
            }

            callOutView.countyLabel.text = (stationODF.countyCode ) + " " +  (stationODF.countyLabel )
            callOutView.bpDataStation.setStationToBp(station: stationODF)
            callOutView.bpDataStation.addTarget(self, action: #selector (MapViewController.getCallOutStation(sender:)), for: .touchUpInside)

            callOutView.center = CGPoint(x: view.bounds.size.width / 2, y: -callOutView.bounds.size.height*0.52)
            view.addSubview(callOutView)

            mapView.setCenter((view.annotation?.coordinate)!, animated: true)
            return
        default: return
        }
    }

    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        if view.isKind(of: StationAnnotationView.self)
        {
            for subview in view.subviews
            {
                subview.removeFromSuperview()
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool){
        self.tabBarController?.tabBar.items?[1].isEnabled = false

        let northEast = mapView.convert(CGPoint(x: mapView.bounds.width, y: 0), toCoordinateFrom: mapView)
        let southWest = mapView.convert(CGPoint(x: 0, y: mapView.bounds.height), toCoordinateFrom: mapView)

        self.mapArea = "\(southWest.longitude),\(southWest.latitude),\(northEast.longitude),\(northEast.latitude)"

        self.activityIndicator.isHidden = false
        let parameters: [[KeyRequest : String]] = [[.area:mapArea!],[.size: "2000"]]

        stationService.current.getStation(parameters: parameters, callback: {[weak self] ( stationList, error) in
            guard let depackedStations = stationList, error == nil else {
                self?.manageErrors(errorCode: error)
                return }

            self?.displayStation(stations: depackedStations)
            self?.listVCDelegate?.stations = depackedStations
            self?.activityIndicator.isHidden = true
            
            self?.tabBarController?.tabBar.items?[1].isEnabled = true
        })
    }

    @objc func getCallOutStation(sender: CustomButton)
    {
        guard let station = sender.getStationFromBp() else { return }
        mapView.deselectAnnotation(station, animated: false)
        presentStationVC(with: station)
    }

    func displayStation( stations: [StationODF]?) {
        guard let stations = stations else { return }

        let annotationsToRemove = mapView.annotations.filter { $0 !== mapView.selectedAnnotations.first }

        mapView.removeAnnotations( annotationsToRemove )

        for station in stations {
            mapView.addAnnotation(station)
        }
    }

    func presentStationVC(with station: StationODF) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let stationVC = storyboard.instantiateViewController(withIdentifier: "StationViewController") as? StationViewController
        else { return }
        stationVC.station = station
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.pushViewController(stationVC, animated: true)
    }

}
