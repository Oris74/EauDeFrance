//
//  dfdViewController.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 11/03/2021.
//

import UIKit
import SafariServices

extension DetailedStationViewController: SFSafariViewControllerDelegate {

    func displaySiteToSafari(with url: URL?) {

        guard let depackedURL = url else {
            manageErrors(errorCode: Utilities.ManageError.urlError)
            return
        }
            let config = SFSafariViewController.Configuration()
            config.entersReaderIfAvailable = true

            let vc = SFSafariViewController(url: depackedURL, configuration: config)
            present(vc, animated: true)
    }

}
