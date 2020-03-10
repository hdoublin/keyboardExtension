//
//  keyboardBtn.swift
//  iRKeyboardExtension
//
//  Created by Imran Rapiq on 2/3/20.
//  Copyright © 2020 Imran R. All rights reserved.
//

import UIKit

class keyboardBtn: UIButton {

     //initWithFrame to init view from code
       override init(frame: CGRect) {
         super.init(frame: frame)
         setupView()
        setAnimation()
       }
       
       //initWithCode to init view from xib or storyboard
       required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
         setupView()
       }
       
       //common func to init our view
       private func setupView() {
        backgroundColor = UIColor.white
        layer.masksToBounds = false
        layer.cornerRadius = 5
        layer.borderColor = UIColor.systemGray.cgColor
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.lightText.cgColor
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 1
        layer.shadowOffset = CGSize(width: 0, height: -1)  
        
       }
    
    private func setAnimation(){
        
        self.addTarget(self, action: #selector(touchDown), for: .touchDown)
        
    }
    
    @objc func touchDown(){
        UIView.animate(withDuration: 0.01,
        animations: {
            self.transform = CGAffineTransform(scaleX: 1.1, y: 1.2)
        },
        completion: { _ in
            UIView.animate(withDuration: 0.01) {
                self.transform = CGAffineTransform.identity
            }
        })
    }
}
