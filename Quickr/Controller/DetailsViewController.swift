//
//  DetailsViewController.swift
//  Quickr
//
//  Created by Anshul Garg on 07/05/20.
//  Copyright © 2020 Anshul Garg. All rights reserved.
//

import UIKit
import PINRemoteImage

class DetailsViewController: UIViewController {
    
    var name = ""
    var adTitle = ""
    var category = ""
    var price = ""
    var imgURL = ""
    
    private let imageView : UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.contentMode = .scaleAspectFit
        return imgView
    }()
    
    private let titleLabel : UILabel = {
        let label = UILabel()
        label.text = "Welcome,"
        label.textColor = .black
        label.textAlignment = .left
       label.font = UIFont(name: "AvenirNext-Medium", size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let categoryLabel : UILabel = {
        let label = UILabel()
        label.text = "Welcome,"
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont(name: "AvenirNext-Medium", size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceLabel : UILabel = {
        let label = UILabel()
        label.text = "Welcome,"
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont(name: "AvenirNext-Medium", size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let ownerLabel : UILabel = {
        let label = UILabel()
        label.text = "Welcome,"
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont(name: "AvenirNext-Medium", size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(imageView)
        view.addSubview(ownerLabel)
        view.addSubview(titleLabel)
        view.addSubview(priceLabel)
        view.addSubview(categoryLabel)
        imageView.pin_setImage(from: URL(string : imgURL))
        ownerLabel.text = "Ad posted by : \(name)"
        priceLabel.text = "Price : \(price)"
        titleLabel.text = "Title : \(adTitle)"
        categoryLabel.text = "Category : \(category)"
        setUpAutoLayout()
    }
    
    func setUpAutoLayout(){
        imageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        imageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        
        ownerLabel.topAnchor.constraint(equalTo:imageView.bottomAnchor, constant: 8).isActive = true
        ownerLabel.leftAnchor.constraint(equalTo:view.leftAnchor, constant:20).isActive = true
        ownerLabel.rightAnchor.constraint(equalTo:view.rightAnchor, constant:-20).isActive = true
        ownerLabel.heightAnchor.constraint(equalToConstant:40).isActive = true
        titleLabel.topAnchor.constraint(equalTo:ownerLabel.bottomAnchor, constant: 8).isActive = true
        titleLabel.leftAnchor.constraint(equalTo:view.leftAnchor, constant:20).isActive = true
        titleLabel.rightAnchor.constraint(equalTo:view.rightAnchor, constant:-20).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant:40).isActive = true
        
        priceLabel.topAnchor.constraint(equalTo:titleLabel.bottomAnchor, constant: 8).isActive = true
        priceLabel.leftAnchor.constraint(equalTo:view.leftAnchor, constant:20).isActive = true
        priceLabel.rightAnchor.constraint(equalTo:view.rightAnchor, constant:-20).isActive = true
        priceLabel.heightAnchor.constraint(equalToConstant:40).isActive = true
        
        categoryLabel.topAnchor.constraint(equalTo:priceLabel.bottomAnchor, constant: 8).isActive = true
        categoryLabel.leftAnchor.constraint(equalTo:view.leftAnchor, constant:20).isActive = true
        categoryLabel.rightAnchor.constraint(equalTo:view.rightAnchor, constant:-20).isActive = true
        categoryLabel.heightAnchor.constraint(equalToConstant:40).isActive = true
    }
    
}
