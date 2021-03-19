//
//  ImagePicker.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 01/03/2021.
//
import UIKit

// MARK: Manage pickerController access for camera and photo library
class ImagePicker: NSObject {
    private let pickerController: UIImagePickerController
    weak var delegate: ImagePickerDelegate?

    public override init() {
        self.pickerController = UIImagePickerController()

        super.init()

        self.pickerController.delegate = self
        self.pickerController.allowsEditing = false
        self.pickerController.mediaTypes = ["public.image"]
    }

    ///present imagePickerController to the user
    public func present(from sourceView: UIView, presentationController: UIViewController, action: UIAlertAction) {

        switch action.title {
        case "Camera":
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                pickerController.sourceType = .camera
                pickerController.allowsEditing = true
                pickerController.cameraDevice = .rear
            } else {
                return
            }
        case "Photo Library":
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                pickerController.sourceType = .photoLibrary
                pickerController.modalPresentationStyle = .fullScreen
                pickerController.allowsEditing = false
            } else {
                return
            }
        default:  break
        }
        presentationController.present(self.pickerController, animated: true)
    }

    private func pickerController(_ controller: UIImagePickerController, didSelectImage image: UIImage?) {
        controller.dismiss(animated: true, completion: nil)
        self.delegate?.didSelectImage(image: image)
    }
}

extension ImagePicker: UIImagePickerControllerDelegate {

    internal func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.pickerController(picker, didSelectImage: nil)
    }

    internal func imagePickerController(_ picker: UIImagePickerController,
                                        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let image = info[.originalImage] as? UIImage else {
            return self.pickerController(picker, didSelectImage: nil)
        }
        self.pickerController(picker, didSelectImage: image)
    }
}

//mandatory but not used in this project
extension ImagePicker: UINavigationControllerDelegate {
}

public protocol ImagePickerDelegate: class {
    func didSelectImage(image: UIImage?)
}
