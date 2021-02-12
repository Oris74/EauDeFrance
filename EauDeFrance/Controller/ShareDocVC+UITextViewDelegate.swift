//
//  ShareDocViewController2.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 12/02/2021.
//

import UIKit

extension ShareDocViewController: UITextViewDelegate   {

        @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
            textView.resignFirstResponder()
        }

        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            dismissKeyboard()
            textField.resignFirstResponder()
            return true
        }
}

