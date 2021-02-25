//
//  ViewController.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 17/01/2021.
//

import UIKit

/// Controlers Utilities
protocol VCUtilities: UIViewController {
    func presentAlert(message: String)
}

enum MenuODF {
    case map
    case list
}

extension VCUtilities {

    /// getting popup alert with description errors
    internal func presentAlert(message: String) {
        DispatchQueue.main.async {
        let alert = UIAlertController(title: "Erreur", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)

            self.present(alert, animated: true, completion: nil)
        }
    }

    internal func dismissKeyboard() {
        view.endEditing(true)
    }

    func manageErrors(errorCode: Utilities.ManageError?) {
        guard let error = errorCode else {
            presentAlert(message: Utilities.ManageError.undefinedError.rawValue)
            return
        }
        //popup display
        presentAlert(message: error.rawValue)
    }

    func serviceStackView(service: ManageService) -> UIStackView {
        let serviceLabel = UILabel()
        serviceLabel.textAlignment = .left
        serviceLabel.text = service.serviceName.uppercased()
        serviceLabel.adjustsFontSizeToFitWidth = true
        let logoService = UIImage(named: service.apiName)?.resize(height: 35)
        let logoServiceView = UIImageView(image: logoService)

        let stackView = UIStackView(arrangedSubviews: [ logoServiceView, serviceLabel])
        stackView.setCustomSpacing(10, after: logoServiceView)
        stackView.axis = .horizontal
        return stackView
    }
    
    func delay(_ delay:Double, closure:@escaping ()->()) {
        let when = DispatchTime.now() + delay
        DispatchQueue.main.asyncAfter(deadline: when, execute: closure)
    }

//    /// MARK: Manage + /- buttons for zoom
//    func zoomInOut(mapView: MKMapView, stepper: UIStepper, newIndex: Int, stepperIndex: Int) -> Int {
//        var region: MKCoordinateRegion = mapView.region
//        if stepperIndex > newIndex {
//            //Zoom In
//            region.span.latitudeDelta = min(region.span.latitudeDelta * 2.0, 180.0)
//            region.span.longitudeDelta = min(region.span.longitudeDelta * 2.0, 180.0)
//        } else if (stepperIndex < newIndex) {
//            //Zoom out
//            region.span.latitudeDelta /= 2.0
//            region.span.longitudeDelta /= 2.0
//        }
//
//        mapView.setRegion(region, animated: true)
//        return newIndex
//    }
//
//    func spanLocationMap(mapView: MKMapView, coordinate: CLLocationCoordinate2D, spanLat: Double, spanLong: Double) {
//
//        let span = MKCoordinateSpan(latitudeDelta: spanLat, longitudeDelta: spanLong)
//        let region = MKCoordinateRegion(center: coordinate, span: span)
//
//        mapView.setRegion(region, animated: true)
//    }
}
