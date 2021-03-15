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
    
    func textFormatter(data: [[Any]] ) -> NSAttributedString? {
        var block: String = ""

        block = "<CENTER><TABLE width=100% align=center><TR valign=top><TD align=center><TABLE width=80%>"
        for (index, row) in data.enumerated() {
            var rowTxt = ""
            if index == 0 {
                rowTxt = "<TR><TD colspan = 2><H3><CENTER><B>\(row[0]) : </B> \(row[1])</H3></CENTER></TD></TR>"
            } else {
                rowTxt = "<TR><TD width=40% valign=top><B>\(row[0]) : </B></TD><TD width=60%>\(row[1])</TD></TR>"
            }
            block += rowTxt
        }
        block += "</TABLE></TD></TR></TABLE></CENTER>"
        return block.htmlToAttributedString
    }

    func binomialFormatter(_ field: [String], _ field2: [String] = []) -> String {
        let qtyField = field.count
        let qtyField2 = field2.count
        var formattedResult = ""

        for index in 0..<qtyField {
            if index < qtyField2 {
            formattedResult += "\(field[index]) (\(field2[index]))<br />"
            } else {
                formattedResult += "\(field[index])<br />"
            }
        }
        return formattedResult
    }
}
