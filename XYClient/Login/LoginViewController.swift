//
//  MainViewController.swift
//  XYClient
//
//  Created by Aventador on 2024/6/6.
//

import UIKit
import CommonViewModule
import HTTPModule
import WebViewModule

class LoginViewController: XYViewController {
    let copyrightString = "Horzion Technology Co.,Ltd"
    
    var loginView: LoginView!
    
    var copyrightLabel: UILabel!
    
    var tapGesture: UITapGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(gestureTapped))
        view.addGestureRecognizer(tapGesture)
        
        loginView = LoginView()
        loginView.delegate = self
        loginView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginView)
        
        copyrightLabel = UILabel()
        copyrightLabel.font = CommonFont.additional
        copyrightLabel.textColor = CommonColor.placeholder
        copyrightLabel.text = copyrightString
        copyrightLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(copyrightLabel)
        
        NSLayoutConstraint.activate([
            loginView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginView.topAnchor.constraint(equalTo: view.topAnchor, constant: 300),
            loginView.widthAnchor.constraint(equalTo: view.widthAnchor),
            loginView.heightAnchor.constraint(equalToConstant: LoginView.defaultHeight),
            
            copyrightLabel.centerXAnchor.constraint(equalTo:view.centerXAnchor),
            copyrightLabel.bottomAnchor.constraint(equalTo:view.bottomAnchor, constant: -Screen.bottomSafeArea),
        ])
    }
    
    @objc func gestureTapped(_ ges:UITapGestureRecognizer) {
        Screen.keyWindow?.endEditing(true)
    }
    
}

extension LoginViewController: LoginViewDelegate {
    func loginViewLoginButtonPressed(_ loginView: LoginView) {
        
        let login = PHM_Login.with {
            $0.account = "amigo"
            $0.pwdMd5 = "amigo123"
        }
        
        
        Http.post(.login, payload: login, responseType: PHM_LoginResp.self) { response in
            switch response {
            case .success(let resp):
                print(resp)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func loginViewPolicyLabelClicked(_ loginView: LoginView, url: URL) {
        let webViewController = XYWebViewController(url)
        navigationController?.pushViewController(webViewController, animated: true)
    }
}

