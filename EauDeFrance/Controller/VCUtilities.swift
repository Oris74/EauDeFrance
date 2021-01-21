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

extension VCUtilities {

    /// getting popup alert with description errors
    internal func presentAlert(message: String) {
        let alert = UIAlertController(title: "Erreur", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
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
    
   

    func serviceStackView(service: Service) -> UIStackView {
        let serviceLabel = UILabel()
        serviceLabel.textAlignment = .left
        serviceLabel.text = service.rawValue
        let logoService = UIImage(named: String(describing: service))?.resize(height: 30)
        let logoServiceView = UIImageView(image: logoService)
        let stackView = UIStackView(arrangedSubviews: [serviceLabel, logoServiceView])
        stackView.setCustomSpacing(20, after: serviceLabel)
        stackView.axis = .horizontal
        return stackView
    }
}
