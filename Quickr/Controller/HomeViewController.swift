//
//  HomeViewController.swift
//  Quickr
//
//  Created by Anshul Garg on 04/05/20.
//  Copyright © 2020 Anshul Garg. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import PINRemoteImage

class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var adData = [AdModel]()
    let layout = UICollectionViewFlowLayout()
    var collectionView : UICollectionView?
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        self.navigationItem.title = "Buy"
        let signOutButton = UIBarButtonItem(title: "Log Out", style: UIBarButtonItem.Style.plain, target: self, action: #selector(signOut))
        self.navigationItem.setRightBarButton(signOutButton, animated: false)
        view.backgroundColor = .white
        
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10)
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "MyCell")
        collectionView?.backgroundColor = UIColor.white
        collectionView?.dataSource = self
        collectionView?.delegate = self
        collectionView?.register(CollectionViewCell.self, forCellWithReuseIdentifier: "MyCell")
        loadAds()
        view.addSubview(collectionView ?? UICollectionView())
    }
    
    @objc func signOut(sender : UIButton!){
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            let loginVC = LoginViewController()
            self.navigationController?.pushViewController(loginVC, animated: false)
            
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
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
        db.collection("ads")
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
                                let newAd = AdModel(title: adTitle, category: adCategory, price: adPrice, imageURL: adImageURL,adOwner: adSender  )
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = DetailsViewController()
        detailVC.name = adData[indexPath.item].adOwner!
        detailVC.adTitle = adData[indexPath.item].title!
        detailVC.category = adData[indexPath.item].category!
        detailVC.price = adData[indexPath.item].price!
        detailVC.imgURL = adData[indexPath.item].imageURL!
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension HomeViewController : UICollectionViewDelegateFlowLayout{
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
