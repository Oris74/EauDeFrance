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
    func setupPlaceHolder() {
        self.placeholderLabel = UILabel()
        self.placeholderLabel.text = "saisissez un commentaire ..."
        self.placeholderLabel.font = UIFont.italicSystemFont(ofSize: (textView.font?.pointSize)!)
        self.placeholderLabel.sizeToFit()
        textView.addSubview(placeholderLabel)
        self.placeholderLabel.frame.origin = CGPoint(x: 5, y: (textView.font?.pointSize)! / 2)
        self.placeholderLabel.textColor = UIColor.lightGray
        self.placeholderLabel.isHidden = !textView.text.isEmpty
    }

    func textViewDidChangeSelection(_ textView: UITextView) {
        placeholderLabel.isHidden = !(note.text?.isEmpty ?? true)
    }
}

