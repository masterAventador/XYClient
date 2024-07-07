//
//  LoginView.swift
//  XYClient
//
//  Created by Aventador on 2024/7/2.
//

import UIKit
import CommonViewModule

protocol LoginViewDelegate: AnyObject {
    func loginViewLoginButtonPressed(_ loginView:LoginView)
}

class LoginView: UIView {
    
    static let horizonGap = 50.0
    static let verticalGap = 20.0
    static let inputHeight = 50.0
    static let checkBoxWidth = 20.0
    static let loginBtnHeight = 50.0
    
    static let defaultHeight = 
    inputHeight /*accountInput*/ +
    verticalGap +
    inputHeight /*passwordInput*/ +
    verticalGap +
    checkBoxWidth +
    verticalGap +
    loginBtnHeight
    
    let accountTextField = UITextField()
    let passwordTextField = UITextField()
    
    let checkBox = {
        var configuration:UIButton.Configuration = .plain()
        configuration.baseBackgroundColor = .clear
        let button = UIButton(configuration: configuration)
        button.setImage(UIImage(named: "policy_icon_unselect"), for: .normal)
        button.setImage(UIImage(named: "policy_icon_selected"), for: .selected)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let policyTextView = UITextView()
    
    let loginButton = {
        var configuration = UIButton.Configuration.plain()
        configuration.cornerStyle = .medium
        configuration.automaticallyUpdateForSelection = true
        let button = XYButton(.middle)
        button.setTitle("登 录", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isEnabled = false
        return button
    }()
    
    
    
    unowned var delegate: LoginViewDelegate?
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        super.init(frame: CGRectZero)
        
        let getLineView = {
            let line = UIView()
            line.backgroundColor = CommonColor.separator
            line.translatesAutoresizingMaskIntoConstraints = false
            return line
        }
        
        accountTextField.attributedPlaceholder = NSAttributedString(string: "请输入账号", attributes: [.foregroundColor:CommonColor.placeholder])
        accountTextField.enablesReturnKeyAutomatically = true
        accountTextField.delegate = self
        accountTextField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(accountTextField)
        
        let accountLine = getLineView()
        self.addSubview(accountLine)
        
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "请输入密码", attributes: [.foregroundColor:CommonColor.placeholder])
        passwordTextField.enablesReturnKeyAutomatically = true
        passwordTextField.delegate = self
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(passwordTextField)
        
        let passwordLine = getLineView()
        self.addSubview(passwordLine)
        
        checkBox.addTarget(self, action: #selector(checkBoxPressed), for: .touchUpInside)
        self.addSubview(checkBox)
        
        let policyName = "《用户隐私协议》"
        let policyString = "我已阅读并同意\(policyName)"
        let policyAttribute = NSMutableAttributedString(string: policyString)
        let policyNameRange = policyString.range(of: policyName)!
        let policyNameNSRange = NSRange(policyNameRange, in: policyString)
        policyAttribute.addAttribute(.link, value: "https://www.baidu.com", range: policyNameNSRange)
        policyTextView.delegate = self
        
        
        loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        self.addSubview(loginButton)
        
        
        NSLayoutConstraint.activate([
            accountTextField.centerXAnchor.constraint(equalTo: centerXAnchor),
            accountTextField.topAnchor.constraint(equalTo: topAnchor),
            accountTextField.widthAnchor.constraint(equalTo: widthAnchor, constant: -LoginView.horizonGap * 2),
            accountTextField.heightAnchor.constraint(equalToConstant: LoginView.inputHeight),
            
            accountLine.centerXAnchor.constraint(equalTo: accountTextField.centerXAnchor),
            accountLine.bottomAnchor.constraint(equalTo: accountTextField.bottomAnchor),
            accountLine.widthAnchor.constraint(equalTo: accountTextField.widthAnchor),
            accountLine.heightAnchor.constraint(equalToConstant: 0.5),
            
            passwordTextField.centerXAnchor.constraint(equalTo: accountTextField.centerXAnchor),
            passwordTextField.topAnchor.constraint(equalTo: accountTextField.bottomAnchor, constant: LoginView.verticalGap),
            passwordTextField.widthAnchor.constraint(equalTo: accountTextField.widthAnchor),
            passwordTextField.heightAnchor.constraint(equalTo: accountTextField.heightAnchor),
            
            passwordLine.centerXAnchor.constraint(equalTo: accountLine.centerXAnchor),
            passwordLine.bottomAnchor.constraint(equalTo: passwordTextField.bottomAnchor),
            passwordLine.widthAnchor.constraint(equalTo: passwordTextField.widthAnchor),
            passwordLine.heightAnchor.constraint(equalToConstant: 0.5),
            
            checkBox.leftAnchor.constraint(equalTo: passwordTextField.leftAnchor),
            checkBox.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: LoginView.verticalGap),
            checkBox.widthAnchor.constraint(equalToConstant: LoginView.checkBoxWidth),
            checkBox.heightAnchor.constraint(equalToConstant: LoginView.checkBoxWidth),
            
            loginButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            loginButton.topAnchor.constraint(equalTo: checkBox.bottomAnchor, constant: Self.verticalGap),
            loginButton.widthAnchor.constraint(equalTo: widthAnchor, constant: -Self.horizonGap * 2),
            loginButton.heightAnchor.constraint(equalToConstant: Self.loginBtnHeight)
        ])
        
    }
    
    @objc func checkBoxPressed() {
        checkBox.isSelected = !checkBox.isSelected
    }
    
    @objc func loginButtonPressed() {
        
    }
    
    func isAllSet() -> Bool {
        return accountTextField.hasText
    }
    
}

extension LoginView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension LoginView: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        return true
    }
    
    @available(iOS 17.0, *)
    func textView(_ textView: UITextView, primaryActionFor textItem: UITextItem, defaultAction: UIAction) -> UIAction? {
        if case .link(let url) = textItem.content {
            UIApplication.shared.open(url)
        }
        return defaultAction
    }
}
