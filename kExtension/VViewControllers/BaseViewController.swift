//
//  BaseViewController.swift
//
//
//  Created by Can Aksoy on 14.09.2018.
//  Copyright © 2018 Can Aksoy. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        
        let backItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        self.navigationItem.backBarButtonItem = backItem

    }
    
    func startLoading() {
//        startAnimating(nil, message: nil, type: NVActivityIndicatorType.ballBeat, color: UIColor(red: 0.573, green: 0.871, blue: 1, alpha: 1), padding: 10, displayTimeThreshold: nil, minimumDisplayTime: 100)
        
    }
    
    func stopLoading() {
//        stopAnimating()
    }

}
