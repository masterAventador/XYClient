//
//  LoginView.swift
//  XYClient
//
//  Created by Aventador on 2024/7/2.
//

import UIKit
import CommonViewModule

protocol LoginViewDelegate: AnyObject {
    func loginViewLoginButtonPressed(_ loginView: LoginView)
    func loginViewPolicyLabelClicked(_ loginView: LoginView,url: URL)
}

class LoginView: UIView {
    
    static let horizonGap = 50.0
    static let verticalGap = 20.0
    static let inputHeight = 50.0
    static let checkBoxWidth = 20.0
    static let policyLabelHorizonGap = 10.0
    static let loginBtnHeight = 50.0
    
    static let policyAttributeString = {
        let policyName = "《用户隐私协议》"
        let policyString = "我已阅读并同意\(policyName)"
        let policyAttribute = NSMutableAttributedString(string: policyString)
        let policyNameRange = policyString.range(of: policyName)!
        let policyNameNSRange = NSRange(policyNameRange, in: policyString)
        policyAttribute.addAttributes([.link:"https://www.baidu.com",
                                       .foregroundColor:CommonColor.link], range: policyNameNSRange)
        return policyAttribute
    }()
    
    static let policySize = {
        let stringRect = policyAttributeString.boundingRect(with: CGSizeMake(Screen.width - horizonGap * 2 - checkBoxWidth - policyLabelHorizonGap, CGFloat.greatestFiniteMagnitude),options: [.usesFontLeading,.usesLineFragmentOrigin], context: nil)
        return stringRect.size
    }()
    
    static let policyLabelHeight = {
        return Double.maximum(checkBoxWidth, policySize.height)
    }()
    
    static let defaultHeight = 
    inputHeight /*accountInput*/ +
    verticalGap +
    inputHeight /*passwordInput*/ +
    verticalGap +
    policyLabelHeight +
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
    
    let policyTextView = {
        let p = UITextView()
        p.attributedText = policyAttributeString
        p.textContainerInset = .zero
        p.isScrollEnabled = false
        p.isEditable = false
        p.textContainer.lineFragmentPadding = 0
        p.translatesAutoresizingMaskIntoConstraints = false
        return p
    }()
    
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
        addSubview(accountTextField)
        
        let accountLine = getLineView()
        addSubview(accountLine)
        
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "请输入密码", attributes: [.foregroundColor:CommonColor.placeholder])
        passwordTextField.enablesReturnKeyAutomatically = true
        passwordTextField.delegate = self
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(passwordTextField)
        
        let passwordLine = getLineView()
        addSubview(passwordLine)
        
        checkBox.addTarget(self, action: #selector(checkBoxPressed), for: .touchUpInside)
        addSubview(checkBox)
        
        policyTextView.delegate = self
        addSubview(policyTextView)
        
        loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        addSubview(loginButton)
        
        
        NSLayoutConstraint.activate([
            accountTextField.centerXAnchor.constraint(equalTo: centerXAnchor),
            accountTextField.topAnchor.constraint(equalTo: topAnchor),
            accountTextField.widthAnchor.constraint(equalTo: widthAnchor, constant: -Self.horizonGap * 2),
            accountTextField.heightAnchor.constraint(equalToConstant: Self.inputHeight),
            
            accountLine.centerXAnchor.constraint(equalTo: accountTextField.centerXAnchor),
            accountLine.bottomAnchor.constraint(equalTo: accountTextField.bottomAnchor),
            accountLine.widthAnchor.constraint(equalTo: accountTextField.widthAnchor),
            accountLine.heightAnchor.constraint(equalToConstant: 0.5),
            
            passwordTextField.centerXAnchor.constraint(equalTo: accountTextField.centerXAnchor),
            passwordTextField.topAnchor.constraint(equalTo: accountTextField.bottomAnchor, constant: Self.verticalGap),
            passwordTextField.widthAnchor.constraint(equalTo: accountTextField.widthAnchor),
            passwordTextField.heightAnchor.constraint(equalTo: accountTextField.heightAnchor),
            
            passwordLine.centerXAnchor.constraint(equalTo: accountLine.centerXAnchor),
            passwordLine.bottomAnchor.constraint(equalTo: passwordTextField.bottomAnchor),
            passwordLine.widthAnchor.constraint(equalTo: passwordTextField.widthAnchor),
            passwordLine.heightAnchor.constraint(equalToConstant: 0.5),
            
            checkBox.leftAnchor.constraint(equalTo: passwordTextField.leftAnchor),
            checkBox.centerYAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: Self.verticalGap + Self.policyLabelHeight/2),
            checkBox.widthAnchor.constraint(equalToConstant: Self.checkBoxWidth),
            checkBox.heightAnchor.constraint(equalToConstant: Self.checkBoxWidth),
            
            policyTextView.leftAnchor.constraint(equalTo: checkBox.rightAnchor, constant: Self.policyLabelHorizonGap),
            policyTextView.centerYAnchor.constraint(equalTo: checkBox.centerYAnchor),
            policyTextView.widthAnchor.constraint(equalToConstant: Self.policySize.width),
            policyTextView.heightAnchor.constraint(equalToConstant: Self.policySize.height),
            
            loginButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: Self.verticalGap + Self.policyLabelHeight + Self.verticalGap),
            loginButton.widthAnchor.constraint(equalTo: widthAnchor, constant: -Self.horizonGap * 2),
            loginButton.heightAnchor.constraint(equalToConstant: Self.loginBtnHeight)
        ])
        
        NotificationCenter.default.addObserver(self, selector: #selector(textFieldTextDidChanged), name: UITextField.textDidChangeNotification, object: nil)
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func checkBoxPressed() {
        checkBox.isSelected = !checkBox.isSelected
        checkLoginButtonEnable()
    }
    
    @objc func loginButtonPressed() {
        delegate?.loginViewLoginButtonPressed(self)
    }
    
    func checkLoginButtonEnable() {
        loginButton.isEnabled = accountTextField.hasText && passwordTextField.hasText && checkBox.isSelected
    }
}

extension LoginView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func textFieldTextDidChanged(_ notify:Notification,second:Int) {
        checkLoginButtonEnable()
    }
}

extension LoginView: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        delegate?.loginViewPolicyLabelClicked(self, url: URL)
        return true
    }
    
    @available(iOS 17.0, *)
    func textView(_ textView: UITextView, primaryActionFor textItem: UITextItem, defaultAction: UIAction) -> UIAction? {
        if case .link(let url) = textItem.content {
            delegate?.loginViewPolicyLabelClicked(self,url: url)
        }
        return UIAction{_ in}
    }
}
