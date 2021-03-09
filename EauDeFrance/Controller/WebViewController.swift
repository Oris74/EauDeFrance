//
//  WebViewController.swift
//  EauDeFrance
//
//  Created by Laurent Debeaujon on 04/03/2021.
//

import UIKit
import WebKit


class WebViewController:  UIViewController, WKNavigationDelegate, VCUtilities {

    var hubeauURL: String?

    var activityIndicator: UIActivityIndicatorView!
    var webView: WKWebView!

    var observator = Set<NSKeyValueObservation?>()

    var bpExit: UIBarItem!

    override func viewDidLoad() {
        super.viewDidLoad()

        let config = WKWebViewConfiguration()
        self.webView = WKWebView(frame: view.bounds, configuration: config)

        view = self.webView
        self.webView.navigationDelegate = self

        setupExitButton()
        setupActivityIndicator()

        presentWebSite()
    }

    func presentWebSite() {
        guard let depackedURL = hubeauURL else { return }

        if depackedURL.hasPrefix("http") {
            let originURL = URL(string: depackedURL)!
            let myRequest = URLRequest(url: originURL)

            DispatchQueue.main.async {
                self.webView.load(myRequest)
            }
        } else {
            presentAlert(message: "Fiche Indisponible")
            navigationController?.popViewController(animated: true)
            self.dismiss(animated: true, completion: nil)
        }
    }

    func setupExitButton(){
        let exitButton = UIBarButtonItem(title: "X", style: .done, target: self, action: #selector(bpExitTapped))
        self.navigationItem.leftBarButtonItem  = exitButton
        exitButton.tintColor = .black
    }

    func setupActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(style: .gray)
        activityIndicator.color = .black
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false

        self.webView.addSubview(activityIndicator)

        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: self.webView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: self.webView.centerYAnchor)
        ])

        let observe = self.webView.observe(\.isLoading, options: .new) {[unowned self] webView, change in
            if let val = change.newValue {
                if val {
                    self.activityIndicator.startAnimating()
                } else {
                    self.activityIndicator.stopAnimating()
                }
            }
        }

        self.observator.insert(observe)
    }


    @objc func bpExitTapped() {
        dismiss(animated: true, completion: nil)
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
