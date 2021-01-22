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
    internal func zoomInOut(newIndex: Int){
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

        view.image = stationService.service.logo().resize(height: 40)
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

            callOutView.logoService.image =  stationService.service.logo().resize(height: 45)
            callOutView.stationName.text = stationODF.stationID
            callOutView.stationLabel.text = stationODF.stationLabel
            callOutView.streamLabel.text = stationODF.streamLabel
            callOutView.county.text = (stationODF.countyID ?? "") + " " +  (stationODF.countyLabel ?? "")

            callOutView.bpDataStation.addTarget(self, action: #selector(MapViewController.displayStationData(sender: )), for: .touchUpInside)

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

    @objc func displayStationData(sender: UIButton)
    {
        let customCallOutVC = sender.superview as! CustomCallOutView
        print("VueControlerStationdata")
    }

    func displayStations() {
        for station in self.stations {
            self.mapView.addAnnotation(station)
        }
    }
}
