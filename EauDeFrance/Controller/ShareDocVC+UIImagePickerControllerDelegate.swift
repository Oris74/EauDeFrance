//
//  ShareDocViewController2ViewController.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 12/02/2021.
//

import UIKit

extension ShareDocViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    func setupCamera() {
        if(UIImagePickerController.isSourceTypeAvailable(.camera))
        {
                 let myPickerController = UIImagePickerController()
                 myPickerController.delegate = self
                 myPickerController.allowsEditing = true
                 myPickerController.sourceType = .camera
                 self.present(myPickerController, animated: true, completion: nil)
        }
        else
        {
            manageErrors(errorCode: Utilities.ManageError.cameraIssue)
        }
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
