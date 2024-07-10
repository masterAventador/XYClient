//
//  XYWebViewController.swift
//  WebViewModule
//
//  Created by Aventador on 2024/7/9.
//

import UIKit
import CommonViewModule
import WebKit

open class XYWebViewController: XYViewController {
    
    public let webView = XYWebView(frame: .zero, configuration: WKWebViewConfiguration())
    
    open var url: URL
    
    public init(_ url: URL) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        webView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(webView)
        NSLayoutConstraint.activate([
            webView.leftAnchor.constraint(equalTo: view.leftAnchor),
            webView.rightAnchor.constraint(equalTo: view.rightAnchor),
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        loadRequest()
    }
    
    
    open func loadRequest() {
        webView.load(URLRequest(url: url))
    }
}

extension XYWebViewController: WKNavigationDelegate {
    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        decisionHandler(.allow)
    }
}
