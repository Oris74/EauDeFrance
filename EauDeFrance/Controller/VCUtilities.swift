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
        serviceLabel.text = service.rawValue.uppercased()
        serviceLabel.adjustsFontSizeToFitWidth = true
        let logoService = service.logo().resize(height: 30)
        let logoServiceView = UIImageView(image: logoService)

        let stackView = UIStackView(arrangedSubviews: [ logoServiceView, serviceLabel])
        stackView.setCustomSpacing(10, after: logoServiceView)
        stackView.axis = .horizontal
        return stackView
    }
}
