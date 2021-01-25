//
//  NewsCastViewController.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 23/01/2021.
//

import UIKit
import WebKit

class NewsCastViewController: UIViewController
                              , WKNavigationDelegate {
    var webView: WKWebView!

    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()


        let originURL = URL(string: "https://www.eaufrance.fr/actualites")!
        let myRequest = URLRequest(url: originURL)
        DispatchQueue.main.async {
            self.webView.load(myRequest)
        }
    }

    internal func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        webView.stopLoading()
    }

    override func viewWillDisappear(_ animated: Bool) {

        webView.stopLoading()
        webView.navigationDelegate = nil
    }

    deinit {
        view = UIView()
        webView = nil
    }


}
