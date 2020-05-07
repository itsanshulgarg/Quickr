//
//  CollectionViewCell.swift
//  Quickr
//
//  Created by Anshul Garg on 06/05/20.
//  Copyright © 2020 Anshul Garg. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    let imageView : UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.contentMode = .scaleAspectFit
        imgView.layer.masksToBounds = true
        return imgView
    }()
    
    let priceLabel : UILabel = {
        let label = UILabel()
        label.text = "₹"
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont(name: "AvenirNext-Medium", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let titleLabel : UILabel = {
        let label = UILabel()
        label.text = "₹"
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont(name: "AvenirNext-Medium", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let categoryLabel : UILabel = {
        let label = UILabel()
        label.text = "₹"
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont(name: "AvenirNext-Medium", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addViews(){
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 10
        addSubview(imageView)
        addSubview(priceLabel)
        addSubview(titleLabel)
        addSubview(categoryLabel)
        
        imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4).isActive = true
        imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8).isActive = true
        imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        priceLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8).isActive = true
        priceLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
        priceLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).isActive = true
        priceLabel.heightAnchor.constraint(equalToConstant: 22).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 8).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 22).isActive = true
        
        categoryLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8).isActive = true
        categoryLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
        categoryLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).isActive = true
        categoryLabel.heightAnchor.constraint(equalToConstant: 22).isActive = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.layer.cornerRadius = 10
    }
}
