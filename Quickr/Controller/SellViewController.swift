//
//  SellViewController.swift
//  Quickr
//
//  Created by Anshul Garg on 04/05/20.
//  Copyright © 2020 Anshul Garg. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseStorage
import JGProgressHUD
import IQKeyboardManagerSwift

class SellViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate{
    
    var imagePicker: UIImagePickerController!
    let stackView = UIStackView()
    var imageViewConstraint : NSLayoutConstraint?
    let db = Firestore.firestore()
    let hud = JGProgressHUD(style: .dark)
    
    private let imageView : UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.contentMode = .scaleAspectFit
        return imgView
    }()
    
    private let cameraButton : UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "camera"), for: .normal)
        btn.frame.size = CGSize(width: 40, height: 40)
        btn.tintColor = .blue
        btn.clipsToBounds = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(cameraButtonPressed), for: UIControl.Event.touchUpInside)
        return btn
    }()
    
    private let galleryButton : UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "photo"), for: .normal)
        btn.frame.size = CGSize(width: 40, height: 40)
        btn.tintColor = .blue
        btn.clipsToBounds = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(galleryButtonPressed), for: UIControl.Event.touchUpInside)
        return btn
    }()
    
    private let titleTxtField:UITextField = {
        let txtField = UITextField()
        txtField.backgroundColor = .white
        txtField.placeholder = "Set Title"
        txtField.borderStyle = .roundedRect
        txtField.translatesAutoresizingMaskIntoConstraints = false
        txtField.isUserInteractionEnabled = true
        txtField.autocorrectionType = .no
        return txtField
    }()
    
    private let categoryTxtField:UITextField = {
        let txtField = UITextField()
        txtField.backgroundColor = .white
        txtField.placeholder = "Set Category"
        txtField.borderStyle = .roundedRect
        txtField.translatesAutoresizingMaskIntoConstraints = false
        txtField.isUserInteractionEnabled = true
        return txtField
    }()
    
    private let priceTxtField:UITextField = {
        let txtField = UITextField()
        txtField.backgroundColor = .white
        txtField.placeholder = "Set Price"
        txtField.borderStyle = .roundedRect
        txtField.translatesAutoresizingMaskIntoConstraints = false
        txtField.isUserInteractionEnabled = true
        txtField.autocorrectionType = .no
        return txtField
    }()
    
    private let postAdButton : UIButton = {
        let btn = UIButton()
        btn.setTitle("Post Ad", for: .normal)
        btn.backgroundColor = #colorLiteral(red: 0.6588235294, green: 0.5647058824, blue: 0.9960784314, alpha: 1)
        btn.tintColor = .white
        btn.clipsToBounds = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 5
        btn.addTarget(self, action: #selector(postAdButtonPressed), for: UIControl.Event.touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = false
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        
        self.navigationItem.title = "Sell"
        view.backgroundColor = .white
        view.addSubview(imageView)
        view.addSubview(stackView)
        view.addSubview(titleTxtField)
        view.addSubview(categoryTxtField)
        view.addSubview(priceTxtField)
        view.addSubview(postAdButton)
        priceTxtField.delegate = self
        titleTxtField.delegate = self
        categoryTxtField.delegate = self
        stackViewLayout()
        setUpAutoLayout()
    }
    
    @objc func cameraButtonPressed(){
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
    
    @objc func galleryButtonPressed(){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey(rawValue: UIImagePickerController.InfoKey.originalImage.rawValue)] as? UIImage {
            imageViewConstraint?.constant = 200
            view.layoutIfNeeded()
            imageView.image = image
            dismiss(animated: true, completion: nil)
        }
    }
    
    func stackViewLayout(){
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.addArrangedSubview(cameraButton)
        stackView.addArrangedSubview(galleryButton)
        stackView.spacing = 40
    }
    
    func setUpAutoLayout(){
        imageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40).isActive = true
        imageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40).isActive = true
        imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        imageViewConstraint =  imageView.heightAnchor.constraint(equalToConstant: 0)
        imageViewConstraint?.isActive = true
        cameraButton.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 0).isActive = true
        cameraButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        galleryButton.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 0).isActive = true
        galleryButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        stackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        titleTxtField.topAnchor.constraint(equalTo:stackView.bottomAnchor, constant: 40).isActive = true
        titleTxtField.leftAnchor.constraint(equalTo:view.leftAnchor, constant:20).isActive = true
        titleTxtField.rightAnchor.constraint(equalTo:view.rightAnchor, constant:-20).isActive = true
        titleTxtField.heightAnchor.constraint(equalToConstant:40).isActive = true
        categoryTxtField.topAnchor.constraint(equalTo:titleTxtField.bottomAnchor, constant: 8).isActive = true
        categoryTxtField.leftAnchor.constraint(equalTo:view.leftAnchor, constant:20).isActive = true
        categoryTxtField.rightAnchor.constraint(equalTo:view.rightAnchor, constant:-20).isActive = true
        categoryTxtField.heightAnchor.constraint(equalToConstant:40).isActive = true
        
        priceTxtField.topAnchor.constraint(equalTo:categoryTxtField.bottomAnchor, constant: 8).isActive = true
        priceTxtField.leftAnchor.constraint(equalTo:view.leftAnchor, constant:20).isActive = true
        priceTxtField.rightAnchor.constraint(equalTo:view.rightAnchor, constant:-20).isActive = true
        priceTxtField.heightAnchor.constraint(equalToConstant:40).isActive = true
        
        postAdButton.topAnchor.constraint(equalTo:priceTxtField.bottomAnchor, constant: 20).isActive = true
        postAdButton.leftAnchor.constraint(equalTo:view.leftAnchor, constant:20).isActive = true
        postAdButton.rightAnchor.constraint(equalTo:view.rightAnchor, constant:-20).isActive = true
        postAdButton.heightAnchor.constraint(equalToConstant:40).isActive = true
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func postAdButtonPressed(sender : UIButton!){
        if imageView.image != nil, titleTxtField.text != "", categoryTxtField.text != "", priceTxtField.text != ""{
            self.hud.textLabel.text = "Loading"
            self.hud.show(in: self.view)
            self.view.isUserInteractionEnabled = false
            self.uploadImage(imageView.image!){ url in
                self.saveImage(name: self.titleTxtField.text!, profileURL: url!) {
                    print("Done")
                    let alertController = UIAlertController(title: "Success", message: "Your ad successfully posted", preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                    self.titleTxtField.text = ""
                    self.categoryTxtField.text = ""
                    self.priceTxtField.text = ""
                    self.imageView.image = nil
                    self.imageViewConstraint?.constant = 0
                    self.view.isUserInteractionEnabled = true
                    self.hud.dismiss()
                }
            }
        }
        else{
            let alertController = UIAlertController(title: "Error", message: "Fill all the detail fields", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
}

extension SellViewController{
    func uploadImage(_ image : UIImage, completion : @escaping((_ url : URL?) -> ())){
        let imageName = NSUUID().uuidString
        let storageRef = Storage.storage().reference().child("\(imageName).png")
        let imgData = imageView.image?.pngData()
        let metaData = StorageMetadata()
        metaData.contentType = "image/png"
        storageRef.putData(imgData!, metadata: metaData) { (metadata, error) in
            if error == nil {
                print("Success")
                storageRef.downloadURL (completion: { (url, error) in
                    completion(url!)
                })
            }
            else{
                print("error")
                completion(nil)
            }
        }
    }
    
    func saveImage(name : String, profileURL: URL, completion : @escaping(() -> ())){
        if let title = titleTxtField.text, let category = categoryTxtField.text, let price = priceTxtField.text, let adSender = Auth.auth().currentUser?.email{
            db.collection("ads").addDocument(data: ["sender":adSender, "title" : title, "category" : category, "price" : price, "profileURL" : profileURL.absoluteString , "Date" : Date().timeIntervalSince1970]) { (error) in
                if let e = error{
                    print(e)
                }
                else{
                    print("Data Saved")
                    completion()
                }
            }
        }
    }
}
