//
//  PremiumViewController.swift
//  kExtension
//
//  Created by Can Aksoy on 14.03.2020.
//  Copyright © 2020 Imran R. All rights reserved.
//

import UIKit

class PremiumViewController: BaseViewController {

    let subscriptionTermsText = UITextView()
    let bgImageView = UIImageView()
    let bgWhite = UIView()
    let topImageView = UIImageView()
    let check1 = UIImageView()
    let check2 = UIImageView()
    let checkLabel1 = UILabel()
    let checkLabel2 = UILabel()
    
    let buyButton = UIButton()
    let tryLabel = UILabel()
    let tryDesc = UILabel()
    let subsLabel = UILabel()
    let subsPrice = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AppCache.shared.popActive = true
        
        NotificationCenter.default.setObserver(self, selector: #selector(self.subsOK), name: NSNotification.Name(rawValue: "subsOK"), object: nil)

        bgImageView.image = #imageLiteral(resourceName: "bg_premium")
        bgImageView.contentMode = .scaleAspectFill
        view.addSubview(bgImageView)
        bgImageView.edgesToSuperview()
        
        topImageView.image = #imageLiteral(resourceName: "ico-premium")
        topImageView.contentMode = .scaleAspectFit
        view.addSubview(topImageView)
        topImageView.centerXToSuperview()
        topImageView.width(100)
        topImageView.height(100)
        topImageView.top(to: view).constant = 80
        
        check1.image = #imageLiteral(resourceName: "ico-check")
        check1.contentMode = .scaleAspectFit
        view.addSubview(check1)
        check1.width(24)
        check1.height(24)
        check1.top(to: topImageView).constant = 140
        check1.left(to: view).constant = 30
        
        checkLabel1.text = "Unlock all super fonts".localized()
        checkLabel1.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        checkLabel1.textColor = UIColor.black
        view.addSubview(checkLabel1)
        checkLabel1.top(to: check1)
        checkLabel1.height(24)
        checkLabel1.left(to: check1).constant = 40
        checkLabel1.right(to: view).constant = -30
        
        check2.image = #imageLiteral(resourceName: "ico-check")
        check2.contentMode = .scaleAspectFit
        view.addSubview(check2)
        check2.width(24)
        check2.height(24)
        check2.top(to: topImageView).constant = 180
        check2.left(to: view).constant = 30
        
        checkLabel2.text = "New fonts updated every months".localized()
        checkLabel2.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        checkLabel2.textColor = UIColor.black
        view.addSubview(checkLabel2)
        checkLabel2.top(to: check2)
        checkLabel2.height(24)
        checkLabel2.left(to: check1).constant = 40
        checkLabel2.right(to: view).constant = -30
        
        view.addSubview(subscriptionTermsText)
        subscriptionTermsText.textColor = .black
        subscriptionTermsText.tintColor = .white
        subscriptionTermsText.backgroundColor = .clear
        subscriptionTermsText.bottomToSuperview(usingSafeArea: true).constant = -10
        subscriptionTermsText.left(to: view).constant = 30
        subscriptionTermsText.right(to: view).constant = -30
        subscriptionTermsText.height(120)
        
        bgWhite.backgroundColor = .white
        bgWhite.layer.cornerRadius = 12
        bgWhite.layer.masksToBounds = true
        view.addSubview(bgWhite)
        bgWhite.left(to: view).constant = 30
        bgWhite.right(to: view).constant = -30
        bgWhite.height(160)
        bgWhite.bottom(to: subscriptionTermsText).constant = -160.0
        
        tryLabel.text = "Try".localized()
        tryLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        tryLabel.textColor = UIColor.black
        view.addSubview(tryLabel)
        tryLabel.top(to: bgWhite).constant = 20
        tryLabel.height(30)
        tryLabel.left(to: bgWhite).constant = 20
        tryLabel.right(to: bgWhite).constant = -30
        
        tryDesc.text = "1 month".localized()
        tryDesc.font = UIFont.systemFont(ofSize: 14, weight: .light)
        tryDesc.textColor = UIColor.black
        view.addSubview(tryDesc)
        tryDesc.top(to: bgWhite).constant = 40
        tryDesc.height(24)
        tryDesc.left(to: bgWhite).constant = 20
        tryDesc.right(to: bgWhite).constant = -30
        
        subsLabel.text = "then $19.99 / year".localized()
        subsLabel.font = UIFont.systemFont(ofSize: 14, weight: .light)
        subsLabel.textColor = UIColor.darkGray
        subsLabel.textAlignment = .center
        view.addSubview(subsLabel)
        subsLabel.top(to: bgWhite).constant = 66
        subsLabel.height(30)
        subsLabel.left(to: bgWhite).constant = 20
        subsLabel.right(to: bgWhite).constant = -20
        
        subsPrice.text = "$0.99".localized()
        subsPrice.font = UIFont.systemFont(ofSize: 28, weight: .light)
        subsPrice.textColor = UIColor.black
        subsPrice.textAlignment = .right
        view.addSubview(subsPrice)
        subsPrice.top(to: bgWhite).constant = 20
        subsPrice.height(44)
        subsPrice.left(to: bgWhite).constant = 20
        subsPrice.right(to: bgWhite).constant = -20
        
        buyButton.addTarget(self, action: #selector(buyButtonTapped), for: .touchUpInside)
        buyButton.setTitle("Unlock All Fonts".localized(), for: .normal)
        buyButton.setTitleColor(.white, for: .normal)
        buyButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        buyButton.backgroundColor = UIColor(red: 0.551, green: 0.475, blue: 1, alpha: 1)
        buyButton.layer.cornerRadius = 6
        buyButton.layer.masksToBounds = true
        bgWhite.addSubview(buyButton)
        buyButton.height(50)
        buyButton.left(to: bgWhite).constant = 10
        buyButton.right(to: bgWhite).constant = -10
        buyButton.bottom(to: bgWhite).constant = -10
        
        let setButton = UIButton()
        setButton.setImage(#imageLiteral(resourceName: "ico-close"), for: .normal)
        setButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        setButton.addTarget(self, action: #selector(self.dismissView), for: .touchUpInside)
        setButton.widthAnchor.constraint(equalToConstant: 28.0).isActive = true
        setButton.heightAnchor.constraint(equalToConstant: 28.0).isActive = true
        
        let barButtonRight = UIBarButtonItem()
        barButtonRight.customView = setButton
        self.navigationItem.rightBarButtonItem = barButtonRight
        
        IAPHelper.getSubscriptionTerms(with: IAPHelper.premium, completed: {()->() in
            self.subscriptionTermsText.text = IAPHelper.subscriptionTerms
            self.subsPrice.text = "\(AppCache.shared.currencySymbol)\(AppCache.shared.specialPrice)"
            self.subsLabel.text = "then \(AppCache.shared.yearlyPrice) / year"
        })
    }
    
    @objc func buyButtonTapped() {
        IAPHelper.purchaseProduct(with: IAPHelper.premium, sharedSecret: IAPHelper.sharedSecret, type: .autoRenewable)
    }
    
    @objc func dismissView() {
        self.dismiss(animated: true) {
            AppCache.shared.popActive = false
        }
    }
    
    @objc func subsOK() {
        dismissView()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
