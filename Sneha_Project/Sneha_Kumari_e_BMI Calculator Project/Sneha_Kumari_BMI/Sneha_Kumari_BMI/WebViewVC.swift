//
//  WebViewVC.swift
//  Sneha_Kumari_BMI
//
//  Created by Sneha on 4/15/20.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit
import WebKit

class WebViewVC: UIViewController, WKNavigationDelegate {
    
    var webView: WKWebView!
    var urlString: String = ""
    
    convenience init(urlString: String) {
        self.init()
        self.urlString = urlString
    }
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let url = URL(string: urlString) {
            webView.load(URLRequest(url: url))
        } else {
            webView.load(URLRequest(url: URL(string: "https://www.google.com")!))
        }
        webView.allowsBackForwardNavigationGestures = true
    }
}

