//
//  settingViewController.swift
//  kExtension
//
//  Created by Imran Rapiq on 5/3/20.
//  Copyright © 2020 Imran R. All rights reserved.
//

import UIKit
import StoreKit

class settingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet var tableView: UITableView!
    
    var details1 = ["Language"] //setting
    var details2 = ["Leave Feedback", "Rate Loopy"]//support
    var details3 = ["Privacy & Policy", "Terms of Service"] // plus
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
//        navigationController?.setNavigationBarHidden(true, animated: true)
        
        
        
        
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
    
        dismiss(animated: true, completion: nil)

        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
//        case 0:
//            return details1.count
        case 0:
            return details2.count
        default:
            return details3.count
    
        }
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
//        case 0:
//            return "Settings"
        case 0:
            return "Leave Feedback"
        default:
            return "Plus"
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch indexPath.section {
//        case 0:
//            let cell = tableView.dequeueReusableCell(withIdentifier: "firstCell", for: indexPath) as! firstCell
//            cell.cellLbl.text = details1[indexPath.row]
//
//
//            return cell
            
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "secondCell", for: indexPath) as! secondCell
             cell.cellLbl.text = details2[indexPath.row]
            
             return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "thirdCell", for: indexPath) as! thirdCell
            
             cell.cellLbl.text = details3[indexPath.row]
            return cell
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section{
        case 0:
            if indexPath.row == 0 {
                print("leaveFeedback")
                
                let appleID = "1481805958"
                let appStoreLink =  "https://itunes.apple.com/app/id\(appleID)?action=write-review"
                UIApplication.shared.open(URL(string: appStoreLink)!, options: [:], completionHandler: nil)
                
            }else{
                print("Rate Loopy")
                rateApp()
            }
        default:
            if indexPath.row == 0 {
                print("Privacy&Policy")
                let linkUrlString = "http://developer.apple.com"
                
                guard let url = URL(string: linkUrlString) else {
                    return
                }

                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(url)
                }
                
                
                
            }else{
                print("Terms of service")
                let linkUrlString = "http://developer.apple.com"
                
                guard let url = URL(string: linkUrlString) else {
                    return
                }

                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(url)
                }
                
                
            }
        }
    }
    
    func rateApp() {
        if #available(iOS 10.3, *) {
            SKStoreReviewController.requestReview()

        } else if let url = URL(string: "itms-apps://itunes.apple.com/app/" + "brain-exercise/id1495649432") {//appID
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)

            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
//    https://apps.apple.com/us/app/brain-exercise/id1495649432?ls=1
    


   
}
    
    

