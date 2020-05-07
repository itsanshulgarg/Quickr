//
//  LoginViewController.swift
//  Quickr
//
//  Created by Anshul Garg on 04/05/20.
//  Copyright © 2020 Anshul Garg. All rights reserved.
//

import UIKit
import FirebaseAuth
import JGProgressHUD
import IQKeyboardManagerSwift

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    let stackView = UIStackView()
    let hud = JGProgressHUD(style: .dark)
    
    private let loginContentView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let unameTxtField:UITextField = {
        let txtField = UITextField()
        txtField.backgroundColor = .white
        txtField.placeholder = "Email Address"
        txtField.borderStyle = .roundedRect
        txtField.translatesAutoresizingMaskIntoConstraints = false
        txtField.isUserInteractionEnabled = true
        txtField.autocapitalizationType = .none
        txtField.autocorrectionType = .no
        return txtField
    }()
    
    private let pwordTxtField:UITextField = {
        let txtField = UITextField()
        txtField.placeholder = "Password"
        txtField.borderStyle = .roundedRect
        txtField.translatesAutoresizingMaskIntoConstraints = false
        txtField.isUserInteractionEnabled = true
        txtField.autocapitalizationType = .none
        txtField.autocorrectionType = .no
        txtField.isSecureTextEntry = true
        return txtField
    }()
    
    let btnLogin:UIButton = {
        let btn = UIButton(type:.system)
        btn.backgroundColor = #colorLiteral(red: 0.1176470588, green: 0.6823529412, blue: 0.5960784314, alpha: 1)
        btn.setTitle("Login", for: .normal)
        btn.tintColor = .white
        btn.titleLabel?.font = UIFont(name: "ArialRoundedMTBold", size: 16)
        btn.layer.cornerRadius = 5
        btn.clipsToBounds = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(loginButtonPressed), for: UIControl.Event.touchUpInside)
        return btn
    }()
    
    private let welcomeLabel : UILabel = {
        let label = UILabel()
        label.text = "Welcome,"
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont(name: "AvenirNext-Bold", size: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let signInLabel : UILabel = {
        let label = UILabel()
        label.text = "Sign in to continue!"
        label.textColor = .gray
        label.textAlignment = .left
        label.font = UIFont(name: "AvenirNext-Medium", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let newUserLabel : UILabel = {
        let label = UILabel()
        label.text = "I'm new User,"
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont(name: "AvenirNext-Medium", size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let signUpButton : UIButton = {
        let btn = UIButton()
        btn.setTitle("Sign Up", for: .normal)
        btn.setTitleColor(.purple, for: .normal)
        btn.tintColor = .white
        btn.clipsToBounds = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(signUpButtonPressed), for: UIControl.Event.touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        view.backgroundColor = .white
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = false
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        view.addSubview(signInLabel)
        view.addSubview(welcomeLabel)
        view.addSubview(loginContentView)
        loginContentView.addSubview(unameTxtField)
        loginContentView.addSubview(pwordTxtField)
        loginContentView.addSubview(btnLogin)
        loginContentView.addSubview(stackView)
        stackViewLayout()
        setUpAutoLayout()
        unameTxtField.delegate = self
        pwordTxtField.delegate = self
    }
    
    @objc func loginButtonPressed(sender : UIButton!){
        Auth.auth().signIn(withEmail: unameTxtField.text!, password: pwordTxtField.text!){ (user, error) in
            if error == nil{
                self.hud.textLabel.text = "Loading"
                self.hud.show(in: self.view)
                let tabBar = MainTabBar()
                self.navigationController?.pushViewController(tabBar, animated: false)
                self.navigationController?.navigationBar.isHidden = true
                self.hud.dismiss()
            }
            else{
                let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
        
    }
    
    @objc func signUpButtonPressed(sender: UIButton!){
        let signUpVC = SignUpViewController()
        self.navigationController?.pushViewController(signUpVC, animated: false)
    }
    
    func stackViewLayout(){
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.addArrangedSubview(newUserLabel)
        stackView.addArrangedSubview(signUpButton)
        stackView.spacing = 3
    }
    
    func setUpAutoLayout(){
        welcomeLabel.leftAnchor.constraint(equalTo : view.leftAnchor, constant : 20).isActive = true
        welcomeLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        welcomeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        welcomeLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        signInLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        signInLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        signInLabel.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 8).isActive = true
        signInLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        loginContentView.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
        loginContentView.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
        loginContentView.topAnchor.constraint(equalTo: signInLabel.bottomAnchor, constant: 0).isActive = true
        loginContentView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 8).isActive = true
        
        unameTxtField.topAnchor.constraint(equalTo:loginContentView.topAnchor, constant: 40).isActive = true
        unameTxtField.leftAnchor.constraint(equalTo:loginContentView.leftAnchor, constant:20).isActive = true
        unameTxtField.rightAnchor.constraint(equalTo:loginContentView.rightAnchor, constant:-20).isActive = true
        unameTxtField.heightAnchor.constraint(equalToConstant:40).isActive = true
        
        pwordTxtField.leftAnchor.constraint(equalTo:loginContentView.leftAnchor, constant:20).isActive = true
        pwordTxtField.rightAnchor.constraint(equalTo:loginContentView.rightAnchor, constant:-20).isActive = true
        pwordTxtField.heightAnchor.constraint(equalToConstant:40).isActive = true
        pwordTxtField.topAnchor.constraint(equalTo:unameTxtField.bottomAnchor, constant:10).isActive = true
        
        btnLogin.topAnchor.constraint(equalTo:pwordTxtField.bottomAnchor, constant:40).isActive = true
        btnLogin.leftAnchor.constraint(equalTo:loginContentView.leftAnchor, constant:20).isActive = true
        btnLogin.rightAnchor.constraint(equalTo:loginContentView.rightAnchor, constant:-20).isActive = true
        btnLogin.heightAnchor.constraint(equalToConstant:40).isActive = true
        
        stackView.topAnchor.constraint(equalTo: btnLogin.bottomAnchor, constant: 40).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        stackView.centerXAnchor.constraint(equalTo: loginContentView.centerXAnchor).isActive = true
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
