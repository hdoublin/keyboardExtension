//
//  ViewController.swift
//  kExtension
//
//  Created by Imran Rapiq on 2/3/20.
//  Copyright © 2020 Imran R. All rights reserved.
//

import UIKit
import TinyConstraints

class ViewController: UIViewController {

    let priceTag = UILabel()
    let productName = UILabel()
    let productDescription = UILabel()
    let subscriptionTermsText = UITextView()
    
    let buyButton = UIButton()
    let settingButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor(red: 44/255, green: 57/255, blue: 95/255, alpha: 1)
        
        setupViews()

        IAPHelper.getProductInfo(with: IAPHelper.premium, completed: {() -> () in
            self.priceTag.text = IAPHelper.Info[0].priceString //?? "insert appID"
            self.productName.text = IAPHelper.Info[0].name //?? "Insert appID"
            self.productDescription.text = IAPHelper.Info[0].localizedDescription //?? "Insert appId"
        })
    }
    
    func setupViews() {
        view.addSubview(priceTag)
        view.addSubview(productName)
        view.addSubview(productDescription)
        view.addSubview(buyButton)
        view.addSubview(settingButton)
        view.addSubview(subscriptionTermsText)
                
        priceTag.center(in: view)
        productName.center(in: view, offset: CGPoint(x: 0, y: -100))
        productDescription.center(in: view, offset: CGPoint(x: 0, y: -60))
        
        buyButton.setTitle("Buy", for: .normal)
        buyButton.tintColor = .white
        buyButton.backgroundColor = UIColor(red: 11/255, green: 22/255, blue: 53/255, alpha: 1)
        buyButton.layer.cornerRadius = 10
        buyButton.addTarget(self, action: #selector(buyButtonTapped), for: .touchUpInside)
        buyButton.center(in: view, offset: CGPoint(x: 0, y: 50))
        buyButton.height(50)
        buyButton.width(100)
        
        subscriptionTermsText.tintColor = .white
        subscriptionTermsText.top(to: settingButton).constant = 80
        subscriptionTermsText.left(to: view)
        subscriptionTermsText.right(to: view)
        subscriptionTermsText.height(200)
        
        settingButton.setTitle("SETTING", for: .normal)
        settingButton.tintColor = .white
        settingButton.layer.cornerRadius = 10
        settingButton.layer.borderColor = UIColor.white.cgColor
        settingButton.layer.borderWidth = 1
        settingButton.addTarget(self, action: #selector(settingSegue), for: .touchUpInside)
        settingButton.center(in: view, offset: CGPoint(x: 0, y: 110))
        settingButton.height(50)
        settingButton.width(100)
        
        
        //Get your Subscription Terms
        IAPHelper.getSubscriptionTerms(with: IAPHelper.premium, completed: {()->() in
            self.subscriptionTermsText.text = IAPHelper.subscriptionTerms
        })
        
        
        
    }
        
    @objc func buyButtonTapped() {
        
        //Purchase a Product
        IAPHelper.purchaseProduct(with: IAPHelper.premium, sharedSecret: IAPHelper.sharedSecret, type: .simple)
    }
    
    @objc func settingSegue() {
        performSegue(withIdentifier: "settingSegue", sender: nil)

    }
    
}

