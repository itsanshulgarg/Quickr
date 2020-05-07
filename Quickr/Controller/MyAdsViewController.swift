//
//  MyAdsViewController.swift
//  Quickr
//
//  Created by Anshul Garg on 04/05/20.
//  Copyright © 2020 Anshul Garg. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import PINRemoteImage
import IQKeyboardManagerSwift

class MyAdsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var adData = [AdModel]()
    let layout = UICollectionViewFlowLayout()
    var collectionView : UICollectionView?
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = false
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        self.navigationItem.title = "My Ads"
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10)
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "MyCell")
        collectionView?.backgroundColor = UIColor.white
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.register(CollectionViewCell.self, forCellWithReuseIdentifier: "MyCell")
        let refreshButton   = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.refresh, target: self, action: #selector(didTapRefreshButton))
        self.navigationItem.setRightBarButtonItems([refreshButton], animated: true)
        loadAds()
        view.addSubview(collectionView ?? UICollectionView())
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return adData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as? CollectionViewCell as CollectionViewCell?
        myCell?.imageView.pin_setImage(from: URL(string: adData[indexPath.item].imageURL!))
        myCell?.priceLabel.text = "₹\(adData[indexPath.item].price ?? "100")"
        myCell?.categoryLabel.text = adData[indexPath.item].category
        myCell?.titleLabel.text = adData[indexPath.item].title
        return myCell!
    }
    
    func loadAds(){
        self.adData = []
        db.collection("ads").whereField("sender", isEqualTo: Auth.auth().currentUser!.email!)
            .order(by: "Date")
            .addSnapshotListener { documentSnapshot, error in
                self.adData = []
                
                if let e = error {
                    print("There was an issue retrieving data from Firestore. \(e)")
                }
                else {
                    if let snapshotDocuments = documentSnapshot?.documents {
                        for doc in snapshotDocuments {
                            let data = doc.data()
                            if let adSender = data["sender"] as? String, let adTitle = data["title"] as? String , let adCategory = data["category"] as? String, let adPrice = data["price"] as? String, let adImageURL = data["profileURL"] as? String{
                                let newAd = AdModel(title: adTitle, category: adCategory, price: adPrice, imageURL: adImageURL, adOwner: adSender )
                                self.adData.append(newAd)
                                
                                DispatchQueue.main.async {
                                    self.collectionView?.reloadData()
                                }
                            }
                        }
                    }
                }
        }
    }
    @objc func didTapRefreshButton(sender: AnyObject){
        loadAds()
    }
}

extension MyAdsViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionWidth = collectionView.bounds.width
        return CGSize(width: collectionWidth/2 - 20, height: 220)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}
