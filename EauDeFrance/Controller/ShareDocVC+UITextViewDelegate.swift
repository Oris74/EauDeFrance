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
        checkForPlaceHolder()
        }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        dismissKeyboard()
        textField.resignFirstResponder()
        checkForPlaceHolder()
        return true
    }

    func checkForPlaceHolder() {
        if textView.text.trimmingCharacters(in: NSCharacterSet.whitespaces).count == 0 {
            self.textView.text = "saisissez un commentaire ..."
            self.textView.font = UIFont.italicSystemFont(ofSize: (textView.font?.pointSize)!)
        }
    }

    func textViewDidBeginEditing(_ textView: UITextView) {
        if   self.textView.text ==  "saisissez un commentaire ..." {
            self.textView.text = ""
        }
    }
}
