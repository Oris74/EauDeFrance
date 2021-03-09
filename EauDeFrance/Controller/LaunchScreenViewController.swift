//
//  LaunchScreenViewController.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 03/03/2021.
//

import UIKit
import Foundation

class LaunchScreenViewController: UIViewController, VCUtilities {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let postalCodeFrance = ManagePostalCode.shared
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let window = UIApplication.shared.windows.first

        postalCodeFrance.importPostalCode(completion: {[weak self] error in
            if error != nil {
                self?.manageErrors(errorCode: error)
            }
            let vc = storyboard.instantiateViewController (withIdentifier: "MainVC") as! UITabBarController
                window?.rootViewController = vc
                window?.makeKeyAndVisible()
        })
    }
}
