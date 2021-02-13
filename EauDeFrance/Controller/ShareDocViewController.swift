//
//  ShareDocViewController.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 11/02/2021.
//

import UIKit
import MapKit

class ShareDocViewController: UIViewController, VCUtilities {

    @IBOutlet var mainView: UIView!
    
    @IBOutlet weak var markPlace: UILabel!

    @IBOutlet weak var textView: UITextView!

    @IBOutlet weak var mapView: MKMapView!


    @IBOutlet weak var note: UILabel!


    @IBOutlet weak var photoLocation: UIImageView!

    @IBAction func bpSharingTapped(_ sender: UIBarButtonItem) {
        displayActivityViewController()
    }
    @IBAction func bpCameraTapped(_ sender: UIBarButtonItem) {
        setupCamera()
    }



    internal var locationManager = CLLocationManager()
    internal var currentLocation: CLLocation?
    internal var lastLocation: CLLocation?
    internal let geocoder = CLGeocoder()

    var lastGeocodeTime: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.showsUserLocation = true
        getLocationInfo()

    }

    private func getLocationInfo(){
        lookUpCurrentLocation(completionHandler: {[weak self] (location) in
        guard let location = location else
        { return }

        self?.markPlace.text = location.name
        self?.note.text = "\(location.postalCode ?? "Code Postal") \(location.locality ?? "Localité")\n \(String(describing: location.timeZone) )"
        })
    }

    ///capture image pattern and bring up the ActivityViewController
    private func displayActivityViewController()  { //-> UIActivityViewController
        let myPattern = self.captureImageFromDisplayPattern(self.mainView)
        let activityController = UIActivityViewController(activityItems: [myPattern], applicationActivities: nil)

        activityController.modalTransitionStyle = .flipHorizontal
        activityController.excludedActivityTypes = .some([
            .addToReadingList,
            .markupAsPDF,
            .print,
            .postToWeibo,
            .postToTencentWeibo]
        )
        //bring up the controller
        self.present(activityController, animated: true, completion: nil)
        //return activityController
    }
    /// capture an image of the view in parameter
    /// view:  name of the view.
    private func captureImageFromDisplayPattern(_ viewPattern: UIView) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: viewPattern.bounds.size)
        let capturedImage = renderer.image {_ in
            guard let myView = view else { return }
            myView.drawHierarchy(in: viewPattern.bounds, afterScreenUpdates: true)
        }
        return capturedImage
    }

    func lookUpCurrentLocation(completionHandler: @escaping (CLPlacemark?)
                    -> Void ) {
        // Use the last reported location.
        if let lastLocation = self.locationManager.location {

            // Look up the location and pass it to the completion handler
            geocoder.reverseGeocodeLocation(lastLocation,
                        completionHandler: { (placemarks, error) in
                if error == nil {
                    let firstLocation = placemarks?[0]
                    completionHandler(firstLocation)
                }
                else {
                 // An error occurred during geocoding.
                    completionHandler(nil)
                }
            })
        }
        else {
            // No location was available.
            completionHandler(nil)
        }
    }

}

