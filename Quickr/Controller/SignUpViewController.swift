//
//  ViewController.swift
//  Quickr
//
//  Created by Anshul Garg on 03/05/20.
//  Copyright © 2020 Anshul Garg. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    let stackView = UIStackView()
    let passStackView = UIStackView()
    
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
    
    private let confirmPwordTxtField : UITextField = {
        let txtField = UITextField()
        txtField.placeholder = "Confirm Password"
        txtField.borderStyle = .roundedRect
        txtField.translatesAutoresizingMaskIntoConstraints = false
        txtField.isUserInteractionEnabled = true
        txtField.autocapitalizationType = .none
        txtField.autocorrectionType = .no
        return txtField
    }()
    
    let btnLogin:UIButton = {
        let btn = UIButton(type:.system)
        btn.backgroundColor = #colorLiteral(red: 0.1176470588, green: 0.6823529412, blue: 0.5960784314, alpha: 1)
        btn.setTitle("Sign Up", for: .normal)
        btn.titleLabel?.font = UIFont(name: "ArialRoundedMTBold", size: 16)
        btn.tintColor = .white
        btn.layer.cornerRadius = 5
        btn.clipsToBounds = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(signUpButtonPressed), for: UIControl.Event.touchUpInside)
        return btn
    }()
    
    private let createAccountLabel : UILabel = {
        let label = UILabel()
        label.text = "Create Account,"
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont(name: "AvenirNext-Bold", size: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let signUpLabel : UILabel = {
        let label = UILabel()
        label.text = "Sign up to get started!"
        label.textColor = .gray
        label.textAlignment = .left
        label.font = UIFont(name: "AvenirNext-Medium", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let memberLabel : UILabel = {
        let label = UILabel()
        label.text = "I'm already a member,"
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont(name: "AvenirNext-Medium", size: 18)
        return label
    }()
    
    private let signInButton : UIButton = {
        let btn = UIButton()
        btn.setTitle("Sign In", for: .normal)
        btn.setTitleColor(.purple, for: .normal)
        btn.tintColor = .white
        btn.clipsToBounds = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(signInButtonPressed), for: UIControl.Event.touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        view.backgroundColor = .white
        view.addSubview(signUpLabel)
        view.addSubview(createAccountLabel)
        view.addSubview(loginContentView)
        loginContentView.addSubview(unameTxtField)
        loginContentView.addSubview(passStackView)
        loginContentView.addSubview(btnLogin)
        loginContentView.addSubview(stackView)
        stackViewLayout()
        setUpAutoLayout()
        unameTxtField.delegate = self
        pwordTxtField.delegate = self
    }
    
    func setUpAutoLayout(){
        createAccountLabel.leftAnchor.constraint(equalTo : view.leftAnchor, constant : 20).isActive = true
        createAccountLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        createAccountLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        createAccountLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        signUpLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        signUpLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        signUpLabel.topAnchor.constraint(equalTo: createAccountLabel.bottomAnchor, constant: 8).isActive = true
        signUpLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        loginContentView.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
        loginContentView.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
        loginContentView.topAnchor.constraint(equalTo: signUpLabel.bottomAnchor, constant: 0).isActive = true
        loginContentView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 8).isActive = true
        
        unameTxtField.topAnchor.constraint(equalTo:loginContentView.topAnchor, constant: 40).isActive = true
        unameTxtField.leftAnchor.constraint(equalTo:loginContentView.leftAnchor, constant:20).isActive = true
        unameTxtField.rightAnchor.constraint(equalTo:loginContentView.rightAnchor, constant:-20).isActive = true
        unameTxtField.heightAnchor.constraint(equalToConstant:40).isActive = true
        
        passStackView.leftAnchor.constraint(equalTo:loginContentView.leftAnchor, constant:20).isActive = true
        passStackView.rightAnchor.constraint(equalTo:loginContentView.rightAnchor, constant:-20).isActive = true
        passStackView.heightAnchor.constraint(equalToConstant:40).isActive = true
        passStackView.topAnchor.constraint(equalTo:unameTxtField.bottomAnchor, constant:10).isActive = true
        
        btnLogin.topAnchor.constraint(equalTo:pwordTxtField.bottomAnchor, constant:40).isActive = true
        btnLogin.leftAnchor.constraint(equalTo:loginContentView.leftAnchor, constant:20).isActive = true
        btnLogin.rightAnchor.constraint(equalTo:loginContentView.rightAnchor, constant:-20).isActive = true
        btnLogin.heightAnchor.constraint(equalToConstant:40).isActive = true
        
        stackView.topAnchor.constraint(equalTo: btnLogin.bottomAnchor, constant: 40).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        stackView.centerXAnchor.constraint(equalTo: loginContentView.centerXAnchor).isActive = true
        
    }
    
    func stackViewLayout(){
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.addArrangedSubview(memberLabel)
        stackView.addArrangedSubview(signInButton)
        stackView.spacing = 3
        
        passStackView.translatesAutoresizingMaskIntoConstraints = false
        passStackView.axis = .horizontal
        passStackView.alignment = .fill
        passStackView.distribution = .fillEqually
        passStackView.spacing = 10
        passStackView.addArrangedSubview(pwordTxtField)
        passStackView.addArrangedSubview(confirmPwordTxtField)
        
    }
    
    @objc func signUpButtonPressed(sender : UIButton!){
        Auth.auth().createUser(withEmail: unameTxtField.text!, password: pwordTxtField.text!){ (user, error) in
            if error == nil {
                let tabBar = MainTabBar()
                self.navigationController?.pushViewController(tabBar, animated: false)
                 self.navigationController?.navigationBar.isHidden = true
            }
            else{
                print(error!)
            }
        }
    }
    
    @objc func signInButtonPressed(sender : UIButton!){
        let loginVC = LoginViewController()
        self.navigationController?.pushViewController(loginVC, animated: false)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}


