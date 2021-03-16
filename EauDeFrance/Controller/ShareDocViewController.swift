//
//  ShareDocViewController.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 11/02/2021.
//

import UIKit
import MapKit

class ShareDocViewController: UIViewController, VCUtilities, ImagePickerDelegate {

    enum MediaSource: Int {
        case Photo
        case Camera
    }

    var mediaOption: MediaSource = .Camera

    internal var locationManager = CLLocationManager()
    var currentLocation = CLLocation(latitude: 46.227638, longitude: 2.213749)
    internal let geocoder = CLGeocoder()

    var placeholderLabel: UILabel!
    var lastGeocodeTime: Date?
    var imagePicker: ImagePicker

    @IBOutlet var mainView: UIView!
    
    @IBOutlet weak var photoView: UIView!
    @IBOutlet weak var markPlace: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var note: UILabel!
    @IBOutlet weak var photoLocation: UIImageView!

    @IBOutlet weak var labelLongitude: UILabel!
    @IBOutlet weak var labelLatitude: UILabel!

    @IBAction func bpSharingTapped(_ sender: UIBarButtonItem) {
        displayActivityViewController()
    }

    @IBAction func bpMapTapped(_ sender: UIBarButtonItem) {
        if mapView.isHidden == true {
           mapView.isHidden = false
        } else {
           mapView.isHidden = true
        }
    }
    
    @IBAction func bpCameraTapped(_ sender: UIBarButtonItem) {
       chooseSourceType()
    }

    required init?(coder: NSCoder) {

        self.imagePicker = ImagePicker()
        super.init(coder: coder)

        imagePicker.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        
        setupMapView()
        setupTxtPlaceHolder()
        setupPhotoPlaceHolder()

        textView.delegate = self
        locationManager.startUpdatingLocation()
    }

    override func viewDidAppear(_ animated: Bool) {

        super.viewDidAppear(animated)

        getLocationInfo()
    }
   
    func setupMapView() {

        mapView.delegate = self
        mapView.showsUserLocation = true
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled  = false
        mapView.showsCompass = true
        mapView.mapType = .hybrid
        mapView.showsScale = true

    }

    func setupPhotoPlaceHolder() {
        let image = UIImage(named: "camera")
        self.photoLocation.image = image
        self.photoLocation.alpha = 0.1
        self.photoLocation.contentMode = .scaleToFill
        
        self.photoView.layer.borderWidth = 1
        self.photoView.layer.borderColor = UIColor.black.cgColor
    }

    private func getLocationInfo() {

        lookUpCurrentLocation(completionHandler: {[weak self] (geocode) in
            guard let geocode = geocode, let location = geocode.location else { return }
            let coordinate = location.coordinate
            let latitude = coordinate.latitude
            let longitude = coordinate.longitude

            self?.labelLatitude.text = "Lat: " + String(format: "%.3f",latitude)
            self?.labelLongitude.text = "Lon: " + String(format: "%.3f",longitude)
            let timestamp = Date()
            self?.markPlace.text = geocode.name
            self?.note.text = "\(geocode.postalCode ?? "Code Postal") \(geocode.locality ?? "Localité")\n \(timestamp.getFullDay()) \n \(timestamp.getFullTime())"

            let currentPlace = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            self?.spanLocationMap(coordinate: currentPlace, spanLat: 0.0005, spanLong: 0.0005)

        })
     }

    ///capture image pattern and bring up the ActivityViewController
    private func displayActivityViewController()  { //-> UIActivityViewController
        let myPattern = self.captureImageFromDisplayPattern(self.mainView)
        let activityController = UIActivityViewController(activityItems: [myPattern], applicationActivities: nil)

        activityController.modalTransitionStyle = .flipHorizontal
        activityController.excludedActivityTypes = .some([  .addToReadingList,
                                                            .markupAsPDF,
                                                            .print,
                                                            .postToWeibo,
                                                            .postToTencentWeibo,
                                                            .addToReadingList,
                                                            .airDrop,
                                                            .assignToContact,
                                                            .copyToPasteboard,
                                                            .postToTencentWeibo,
                                                            .postToFlickr,
                                                            .postToVimeo,
                                                            .openInIBooks]
                                                        )
        //bring up the controller
        self.present(activityController, animated: true, completion: nil)
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

    func chooseSourceType(){
        let optionMenu = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .actionSheet)

        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: { (action) -> Void in
                    optionMenu.dismiss(animated: true)
                self.imagePicker.present(from: self.photoLocation, presentationController: self, action: action)
            })
            optionMenu.addAction(cameraAction)
        } else {
            manageErrors(errorCode: Utilities.ManageError.cameraIssue)
        }

        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default, handler: { (action) -> Void in
                self.imagePicker.present(from: self.photoLocation, presentationController: self, action: action)
            })
            optionMenu.addAction(photoLibraryAction)
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        optionMenu.addAction(cancelAction)

        self.present(optionMenu, animated: true, completion: nil)
    }

    func didSelectImage(image: UIImage?) {
        self.photoLocation.image = image
        self.photoLocation.contentMode = .scaleAspectFit
        self.photoLocation.alpha = 1
    }
}

