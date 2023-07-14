//
//  ViewController.swift
//  kExtension
//
//  Created by Imran Rapiq on 2/3/20.
//  Copyright © 2020 Imran R. All rights reserved.
//

import UIKit
import TinyConstraints

class ViewController: BaseViewController {

    let startButton = UIButton()
    
    let enableView = UIView()
    let enableImage = UIImageView()
    let enableTitle = UILabel()
    
    let enabledView = UIView()
    let enabledImage = UIImageView()
    let enabledTitle = UILabel()
    
    let check1d = UIImageView()
    let check2d = UIImageView()
    let check3d = UIImageView()
    
    let check1 = UIImageView()
    let check2 = UIImageView()
    let check3 = UIImageView()
    
    let checkLabel1 = UILabel()
    let checkLabel2 = UILabel()
    let checkLabel3 = UILabel()
    
    var isKEnabled = false
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.setObserver(self, selector: #selector(self.checkEnabled), name: NSNotification.Name(rawValue: "didBecomeActive"), object: nil)
        
        NotificationCenter.default.setObserver(self, selector: #selector(self.popSubs), name: NSNotification.Name(rawValue: "popSubsNotif"), object: nil)
        
        let setButton = UIButton()
        setButton.setImage(#imageLiteral(resourceName: "btn-settings"), for: .normal)
        setButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        setButton.addTarget(self, action: #selector(self.settingSegue), for: .touchUpInside)
        setButton.widthAnchor.constraint(equalToConstant: 28.0).isActive = true
        setButton.heightAnchor.constraint(equalToConstant: 28.0).isActive = true
        
        let barButtonRight = UIBarButtonItem()
        barButtonRight.customView = setButton
        self.navigationItem.rightBarButtonItem = barButtonRight
        
        let subsButton = UIButton()
        subsButton.setImage(#imageLiteral(resourceName: "ico-allow"), for: .normal)
        subsButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        subsButton.addTarget(self, action: #selector(self.popSubs), for: .touchUpInside)
        subsButton.widthAnchor.constraint(equalToConstant: 28.0).isActive = true
        subsButton.heightAnchor.constraint(equalToConstant: 28.0).isActive = true
        
        let barButtonLeft = UIBarButtonItem()
        barButtonLeft.customView = subsButton
        self.navigationItem.leftBarButtonItem = barButtonLeft
        
        setupViews()
        checkEnabled()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            if !AppCache.shared.isPremium {
                self.popSubs()
            }
        }
    }
    
    func setupViews() {
        
        view.addSubview(enableView)
        enableView.edgesToSuperview()
        
        enableImage.image = #imageLiteral(resourceName: "message-how")
        enableImage.contentMode = .scaleAspectFit
        enableView.addSubview(enableImage)
        enableImage.width(180)
        enableImage.height(120)
        enableImage.top(to: enableView).constant = 80
        enableImage.centerXToSuperview()
        
        enableTitle.text = "Enable Keyboard".localized()
        enableTitle.font = UIFont.systemFont(ofSize: 34, weight: .semibold)
        enableTitle.textAlignment = .center
        enableTitle.textColor = .black
        enableView.addSubview(enableTitle)
        enableTitle.height(40)
        enableTitle.top(to: enableImage).constant = 120
        enableTitle.left(to: view).constant = 30
        enableTitle.right(to: view).constant = -30
        
        
        check1d.image = #imageLiteral(resourceName: "settings-dot")
        check1d.contentMode = .scaleAspectFit
        enableView.addSubview(check1d)
        check1d.width(24)
        check1d.height(24)
        check1d.top(to: enableTitle).constant = 80
        check1d.left(to: view).constant = 30
        
        check1.image = #imageLiteral(resourceName: "ico-settings")
        check1.contentMode = .scaleAspectFit
        enableView.addSubview(check1)
        check1.width(24)
        check1.height(24)
        check1.top(to: enableTitle).constant = 80
        check1.left(to: view).constant = 70
        
        checkLabel1.text = "Go to the Settings".localized()
        checkLabel1.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        checkLabel1.textColor = UIColor.black
        checkLabel1.adjustsFontSizeToFitWidth = true
        enableView.addSubview(checkLabel1)
        checkLabel1.top(to: check1)
        checkLabel1.height(24)
        checkLabel1.left(to: check1).constant = 40
        checkLabel1.right(to: view).constant = -30
        
        //2
        check2d.image = #imageLiteral(resourceName: "settings-dot")
        check2d.contentMode = .scaleAspectFit
        enableView.addSubview(check2d)
        check2d.width(24)
        check2d.height(24)
        check2d.top(to: enableTitle).constant = 140
        check2d.left(to: view).constant = 30
        
        check2.image = #imageLiteral(resourceName: "ico-keyboard")
        check2.contentMode = .scaleAspectFit
        enableView.addSubview(check2)
        check2.width(24)
        check2.height(24)
        check2.top(to: enableTitle).constant = 140
        check2.left(to: view).constant = 70
        
        checkLabel2.text = "Tap Keyboards".localized()
        checkLabel2.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        checkLabel2.textColor = UIColor.black
        checkLabel2.adjustsFontSizeToFitWidth = true
        enableView.addSubview(checkLabel2)
        checkLabel2.top(to: check2)
        checkLabel2.height(24)
        checkLabel2.left(to: check2).constant = 40
        checkLabel2.right(to: view).constant = -30
        
        //3
        check3d.image = #imageLiteral(resourceName: "settings-dot")
        check3d.contentMode = .scaleAspectFit
        enableView.addSubview(check3d)
        check3d.width(24)
        check3d.height(24)
        check3d.top(to: enableTitle).constant = 200
        check3d.left(to: view).constant = 30
        
        check3.image = #imageLiteral(resourceName: "ico-enable")
        check3.contentMode = .scaleAspectFit
        enableView.addSubview(check3)
        check3.width(24)
        check3.height(24)
        check3.top(to: enableTitle).constant = 200
        check3.left(to: view).constant = 70
        
        checkLabel3.text = "Switch on Fontz Keyboard".localized()
        checkLabel3.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        checkLabel3.textColor = UIColor.black
        checkLabel3.adjustsFontSizeToFitWidth = true
        enableView.addSubview(checkLabel3)
        checkLabel3.top(to: check3)
        checkLabel3.height(24)
        checkLabel3.left(to: check3).constant = 40
        checkLabel3.right(to: view).constant = -30

        startButton.addTarget(self, action: #selector(buyButtonTapped), for: .touchUpInside)
        startButton.setTitle("Get Started".localized(), for: .normal)
        startButton.setTitleColor(.black, for: .normal)
        startButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        startButton.backgroundColor = UIColor(red: 0.573, green: 0.871, blue: 1, alpha: 1)
        //startButton.setImage(#imageLiteral(resourceName: "arrow-right"), for: .normal)
        //startButton.imageEdgeInsets = UIEdgeInsets(top: 8, left: 300, bottom: 8, right: 20)
        startButton.layer.cornerRadius = 10
        startButton.layer.masksToBounds = true
        enableView.addSubview(startButton)
        startButton.height(50)
        startButton.left(to: view).constant = 30
        startButton.right(to: view).constant = -30
        startButton.bottom(to: view).constant = -60
        
        
        
        //enabled
        view.addSubview(enabledView)
        enabledView.isHidden = true
        enabledView.edgesToSuperview()
        
        enabledImage.image = #imageLiteral(resourceName: "message-ready")
        enabledImage.contentMode = .scaleAspectFit
        enabledView.addSubview(enabledImage)
        enabledImage.left(to: view).constant = 30
        enabledImage.right(to: view).constant = -30
        enabledImage.top(to: enabledView).constant = 120
        enabledImage.centerXToSuperview()
        
        enabledTitle.text = "Fontz Keyboard is Ready!".localized()
        enabledTitle.font = UIFont.systemFont(ofSize: 34, weight: .semibold)
        enabledTitle.textAlignment = .center
        enabledTitle.textColor = .black
        enabledTitle.numberOfLines = 2
        enabledView.addSubview(enabledTitle)
        enabledTitle.height(100)
        enabledTitle.bottom(to: view).constant = -60
        enabledTitle.left(to: view).constant = 30
        enabledTitle.right(to: view).constant = -30
    }
        
    @objc func buyButtonTapped() {
        
        //Purchase a Product
        //IAPHelper.purchaseProduct(with: IAPHelper.premium, sharedSecret: IAPHelper.sharedSecret, type: .simple)
        
        if let url = URL(string: UIApplication.openSettingsURLString) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
    
    @objc func settingSegue() {
        
        let setVC: UIViewController = storyboardMain.instantiateViewController(withIdentifier: "settings") as! SettingsViewController
        self.navigationController?.pushViewController(setVC, animated: true)

    }
    
    @objc func popSubs() {
        
        if AppCache.shared.popActive == false {
            let VC = storyboardMain.instantiateViewController(withIdentifier: "premium") as! PremiumViewController
            let navVC = UINavigationController(rootViewController: VC)
            navVC.modalPresentationStyle = .fullScreen
            UIApplication.topViewController()!.present(navVC, animated: true, completion: {
                
            })
        }
        
    }
    
    func isKeyboardExtensionEnabled() -> Bool {
        guard let appBundleIdentifier = Bundle.main.bundleIdentifier else {
            fatalError("isKeyboardExtensionEnabled(): Cannot retrieve bundle identifier.")
        }

        guard let keyboards = UserDefaults.standard.dictionaryRepresentation()["AppleKeyboards"] as? [String] else {
            // There is no key `AppleKeyboards` in NSUserDefaults. That happens sometimes.
            return false
        }

        let keyboardExtensionBundleIdentifierPrefix = appBundleIdentifier + "."
        for keyboard in keyboards {
            if keyboard.hasPrefix(keyboardExtensionBundleIdentifierPrefix) {
                return true
            }
        }

        return false
    }
    
    @objc func checkEnabled() {
        isKEnabled = isKeyboardExtensionEnabled()
        
        if isKEnabled {
            enableView.isHidden = true
            enabledView.isHidden = false
        } else {
            enableView.isHidden = false
            enabledView.isHidden = true
        }
        
    }
    
}

