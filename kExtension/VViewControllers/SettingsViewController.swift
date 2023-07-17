//
//  settingViewController.swift
//  kExtension
//
//  Created by Imran Rapiq on 5/3/20.
//  Copyright © 2020 Imran R. All rights reserved.
//

import UIKit
import StoreKit
import MessageUI
import SafariServices

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MFMailComposeViewControllerDelegate{
    
    @IBOutlet weak var backBtn: UIButton!
    var tableView = UITableView(frame: .zero)
    
    var details = ["Open Fontz Settings".localized(), "Rate Fontz".localized(), "Leave Feedback".localized(), "Terms of Service".localized(), "Privacy & Policy".localized()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Settings".localized()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "UITableViewCell")
        tableView.separatorStyle = .singleLine
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        tableView.backgroundColor = UIColor.white
        tableView.tableFooterView = UIView()
        self.view.addSubview(tableView)
        tableView.edgesToSuperview()
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
    
        dismiss(animated: true, completion: nil)

        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "UITableViewCell")
        cell.textLabel?.font = UIFont.systemFont(ofSize: 16, weight: .light)
        cell.textLabel?.textColor = .black
        cell.textLabel?.text = details[indexPath.row]
        cell.backgroundColor = .white
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.row{
        case 0:
            if let url = URL(string: UIApplication.openSettingsURLString) {
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }
            break
        case 1:
            SKStoreReviewController.requestReview()
            break
        case 2:
            sendEmailButtonTapped()
            break
        case 3:
            let vc = SFSafariViewController(url: URL(string: IAPHelper.termsOfServiceURL)!)
            present(vc, animated: true)
            break
        case 4:
            let vc = SFSafariViewController(url: URL(string: IAPHelper.privacyPolicyURL)!)
            present(vc, animated: true)
            break
        default:
            break
        }
    }

    func sendEmailButtonTapped() {
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        
        mailComposerVC.setToRecipients(["support@wecode.online"])
        mailComposerVC.setSubject("Support - Fontz".localized())
        mailComposerVC.setMessageBody("", isHTML: false)
        
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        let alertController = UIAlertController(title: "Error".localized(), message:"Your device cannot sent email. Please check your email configuration".localized(), preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "OK".localized(), style: UIAlertAction.Style.default,handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    // MARK: MFMailComposeViewControllerDelegate Method
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
}
    
    

