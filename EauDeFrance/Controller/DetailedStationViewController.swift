//
//  DetailedStationViewController.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 05/02/2021.
//

import UIKit

enum Resource:String {
    case sandre = "Sandre"
    case lisa = "Lisa"
}

class DetailedStationViewController: UIViewController, VCUtilities {
    var station: StationODF!
    var stackButton: UIStackView!

    @IBOutlet weak var txtZone: UITextView!

    @IBOutlet weak var resourceStack: UIStackView!

    override func viewDidLoad() {
        super.viewDidLoad()

        switch station {
        case let temperatureStation as TemperatureODF:
            temperatureDetail(station: temperatureStation)
        case let piezometryStation as PiezometryODF:
            piezoDetail(station: piezometryStation)

        default: break
        }

    }

    override func viewWillAppear(_ animated: Bool) {
        self.txtZone.flashScrollIndicators()
        super.viewWillAppear(animated)
    }
    
    func temperatureDetail(station: TemperatureODF){

        let data = [
            ["Identifiant", station.stationCode],
            ["Point Kilométrique", station.pointKM],
            ["Localisation", station.localization],
            ["Latitude", "\(station.latitude)"],
            ["Longitude", "\(station.longitude)"],
            ["Section Hydro", station.hydroSectionCode],
            ["Bassin", "\(station.basinLabel) (\(station.basinCode))"],
            ["Sous Bassin", "\(station.subBasinLabel) (\(station.subBasinLabel))"],
            ["Cours d'eau", "\(station.streamLabel) (\(station.streamCode))"],
            ["Masse d'eau", "\(station.bodyOfWaterLabel) (\(station.bodyOfWaterCode))"]
        ]
        self.txtZone.attributedText = textFormatter(data: data)
        self.txtZone.flashScrollIndicators()

        if let depackedUriBoWater = station.uriBodyOfWater {
            let boWater:[String:URL] = [station.bodyOfWaterCode:depackedUriBoWater]
            createResource( resource: .sandre, tuple: boWater )
        }
        if let depackedUriStream = station.uriStream {
            let streamData:[String:URL] =  [station.streamCode:depackedUriStream]

            createResource( resource: .sandre, tuple: streamData )
        }
    }
  
    func piezoDetail(station: PiezometryODF) {
        let data = [
            ["Identifiant", station.stationCode],
            ["Code BBS", station.bssId],
            ["Mesures Réalisées", station.nbPiezoMeasurement],
            ["Identifiant LISA", "\(binomialFormatter(station.bdLisaCode))"],
            ["Latitude", "\(station.latitude)"],
            ["Longitude", "\(station.longitude)"],
            ["Profondeur d'investigation", "\(station.depthOfInvestigation) m"],
            ["Masse d'eau", "\(binomialFormatter(station.bodyOfWaterLabel ,station.bodyOfWaterCode))"],
            ["Mise à jour", station.dateUPDT]
        ]
        self.txtZone.attributedText = textFormatter(data: data)
        self.txtZone.flashScrollIndicators()

        if let depackedUriBoWater = station.uriBodyOfWater {
            let boWater:[String:URL] = Dictionary(uniqueKeysWithValues: zip(station.bodyOfWaterCode,depackedUriBoWater))
            createResource( resource: .sandre, tuple: boWater )
        }
        if let depackedUrnLisa = station.urnsBdLisa {
            let lisaData:[String:URL] = Dictionary(uniqueKeysWithValues: zip(station.bdLisaCode,depackedUrnLisa))
            createResource( resource: .lisa, tuple: lisaData )
        }
    }

    func createResource( resource: Resource, tuple: [String:URL] ){

        var image = UIImage()
        image = (UIImage(named: resource.rawValue)?.resize(height: 50))!

        for doc in tuple {
            let button = CustomButton()

            button.setResourceToBp(data: tuple, resource: resource)
            button.setImage(image, for: .normal)
           
            button.setTitle(doc.key, for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.titleLabel?.font = .boldSystemFont(ofSize:12)
            resourceStack.addArrangedSubview(button)
            button.addTarget(self, action: #selector(resourceAccess), for: .touchUpInside )
        }

        for resource in resourceStack.arrangedSubviews {
            if let resource = resource as? UIButton {
                    resource.centerVertically()
            }
        }
        self.resourceStack.layoutIfNeeded()     //refresh stackView with buttons
    }

    @objc func resourceAccess(sender: CustomButton) {
        let lisaData = sender.getResourceFromBp(resource: .lisa)
        let sandreData = sender.getResourceFromBp(resource: .sandre)

        if let titleKey = sender.title(for: .normal) {
            if let url = lisaData[titleKey] {
                displaySiteToSafari(with: url)
            }else if let url = sandreData[titleKey] {
                displaySiteToSafari(with: url)
            }
        }
    }
}
