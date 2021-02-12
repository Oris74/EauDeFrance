//
//  ShareDocViewController2ViewController.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 12/02/2021.
//

import UIKit

extension ShareDocViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    func setupCamera() {
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.allowsEditing = true
        vc.delegate = self
        present(vc, animated: true)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)

        guard let image = info[.editedImage] as? UIImage else {
            manageErrors(errorCode: Utilities.ManageError.cameraIssue)
            return
        }

        // print out the image size as a test
        self.photoLocation.image = image
    }
}
