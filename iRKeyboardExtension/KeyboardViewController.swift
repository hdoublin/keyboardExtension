//
//  KeyboardViewController.swift
//  iRKeyboardExtension
//
//  Created by Imran Rapiq on 1/3/20.
//  Copyright © 2020 Imran R. All rights reserved.
//

import UIKit


class KeyboardViewController: UIInputViewController,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    /// temporary
    public var isPurchased: Int = 0
    
    private var buttonY: CGFloat = 5
    let spacingWidth : CGFloat = 5
    private var spacingHeight : CGFloat = UIScreen.main.bounds.height * 3 / 192
    let keyboardHeight: CGFloat = UIScreen.main.bounds.height * 3 / 8  //UIScreen.main.bounds.height * 3 / 7
 //UIScreen.main.bounds.height * 3 / 7
    private var buttonHeight : CGFloat = 44
    let screenHeight = UIScreen.main.bounds.height
    let screenWidth = UIScreen.main.bounds.width
    
    
    
    var shiftStatus : Int = 0
    var isChar : Bool = true
    
    var secondCharUpper : [String] = [] // 10
    var secondCharLower : [String] = [] // 10
    
    var secondSymbolUpper : [String] = [] // 10
    var secondSymbolLower : [String] = [] // 10
    
    var thirdCharUpper : [String] = [] // 9
    var thirdCharLower : [String] = [] // 9
    
    var thirdSymbolUpper : [String] = [] // 10
    var thirdSymbolLower : [String] = [] // 10
    
    var forthCharUpper : [String] = [] // 7 (shift, back)
    var forthCharLower : [String] = [] // 7 (shift, back)
    
    var forthSymbol : [String] = [] // 5 (shift, back)
    var fifthSymbol : [String] = ["","","",""] // 4
    
    var fontSource : String = ""
    
    var charSetArray: [String] = []
    var keyboards : [keyboardBtn] = []
    var keyColor = UIColor()
    
    var selectIndex : Int = 0
    
    private let container: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
//        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let charSet: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        return cv
    }()
    
    let locker: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.3619183302, green: 0.3619183302, blue: 0.3619183302, alpha: 0.5)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let unlockBtn = UIButton()
   
    
//    @IBOutlet var nextKeyboardButton: UIButton!
//
    override func updateViewConstraints() {
        super.updateViewConstraints()
        // Add custom view sizing constraints here
//        inputView?.translatesAutoresizingMaskIntoConstraints = false
        inputView?.heightAnchor.constraint(equalToConstant: keyboardHeight + spacingHeight ).isActive = true
        
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        //My Code
        //initialize&removing
        for subView in view.subviews{
            subView.removeFromSuperview()
        }
        fontSource = ""
        charSetArray.removeAll()
        keyboards.removeAll()
        
       spacingHeight = keyboardHeight / 24
       buttonHeight = keyboardHeight / 6
       buttonY = spacingHeight / 2
        
        //create Keyboard_Container
        view.addSubview(container)
        container.translatesAutoresizingMaskIntoConstraints = false
        container.leftAnchor.constraint(equalTo: inputView!.leftAnchor, constant: 0).isActive = true
        container.rightAnchor.constraint(equalTo: inputView!.rightAnchor, constant: 0).isActive = true
        container.topAnchor.constraint(equalTo: inputView!.topAnchor, constant: 0).isActive = true
        container.heightAnchor.constraint(equalToConstant: keyboardHeight + spacingHeight).isActive = true
       
        
        
        //charSet-CollectionView
        container.addSubview(charSet)
        charSet.delegate = self
        charSet.dataSource = self
        charSet.showsHorizontalScrollIndicator = false
        charSet.register(UICollectionViewCell.self,
        forCellWithReuseIdentifier: "cell")
                
        //locker
        self.view.addSubview(locker)
        self.locker.addSubview(unlockBtn)
        if isPurchased == 1 {locker.isHidden = true}
        locker.leftAnchor.constraint(equalTo: container.leftAnchor, constant: 0).isActive = true
        locker.rightAnchor.constraint(equalTo: container.rightAnchor, constant: 0).isActive = true
        locker.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: 0).isActive = true
        locker.heightAnchor.constraint(equalToConstant: keyboardHeight - buttonHeight).isActive = true
        
        unlockBtn.translatesAutoresizingMaskIntoConstraints = false
        unlockBtn.centerYAnchor.constraint(equalTo: locker.centerYAnchor, constant: 0).isActive = true
        unlockBtn.centerXAnchor.constraint(equalTo: locker.centerXAnchor).isActive = true
        unlockBtn.widthAnchor.constraint(equalToConstant: 140).isActive = true
        unlockBtn.heightAnchor.constraint(equalToConstant: buttonHeight).isActive = true
        unlockBtn.layer.cornerRadius = buttonHeight / 8
//        unlockBtn.lay


        unlockBtn.backgroundColor = UIColor(red: 0.573, green: 0.871, blue: 1, alpha: 1)
        unlockBtn.showsTouchWhenHighlighted = true
        unlockBtn.setTitle("UNLOCK", for: .normal)
        unlockBtn.setTitleColor(.black, for: .normal)
        unlockBtn.addTarget(self, action: #selector(willPurchase), for: .touchUpInside)
        
        
        
        //insert the value
        charSetArray.append(font1)
        charSetArray.append(font2)
        charSetArray.append(font3)
        charSetArray.append(font4)
        charSetArray.append(font5)
        charSetArray.append(font6)
        charSetArray.append(font7)
        charSetArray.append(font8)
        charSetArray.append(font9)
        charSetArray.append(font10)
        charSetArray.append(font11)
        charSetArray.append(font12)
        charSetArray.append(font13)
        charSetArray.append(font14)
        charSetArray.append(font15)
        charSetArray.append(font16)
        charSetArray.append(font17)
        charSetArray.append(font18)
        charSetArray.append(font19)
        charSetArray.append(font20)
        fontSource = charSetArray[0] // 96 characters
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if let userDefaults = UserDefaults(suiteName: "group.wecodefonts") {
            isPurchased = userDefaults.integer(forKey: "isPurchased")
        }
        
        if isPurchased == 1 {
            locker.isHidden = true
        } else {
            locker.isHidden = false
        }
        
        if traitCollection.userInterfaceStyle == .light {
           keyColor = UIColor.black
        } else {
           keyColor = UIColor.white
        }
        setupCollectionConstraints()
        self.initializeKeyboard_data(source: fontSource)
        self.array2Keyboard()
    }
    
    
    func initializeKeyboard_data(source: String) {
        // KeyboardData 2 Array
        let splitedArray = fontSource.components(separatedBy: " ")
        secondCharLower.removeAll()
        for i in 0...9 {
            secondCharLower.append(splitedArray[i])
        }
        thirdCharLower.removeAll()
        for i in 10...18 {
            thirdCharLower.append(splitedArray[i])
        }
        forthCharLower.removeAll()
        for i in 19...25{
            forthCharLower.append(splitedArray[i])
        }
        secondCharUpper.removeAll()
        for i in 26...35 {
            secondCharUpper.append(splitedArray[i])
        }
        thirdCharUpper.removeAll()
        for i in 36...44 {
            thirdCharUpper.append(splitedArray[i])
        }
        forthCharUpper.removeAll()
        for i in 45...51{
            forthCharUpper.append(splitedArray[i])
        }
        secondSymbolLower.removeAll()
        for i in 52...61 {
            secondSymbolLower.append(splitedArray[i])
        }
        thirdSymbolLower.removeAll()
        for i in 62...71 {
            thirdSymbolLower.append(splitedArray[i])
        }
        forthSymbol.removeAll()
        for i in 72...76 {
            forthSymbol.append(splitedArray[i])
        }
        secondSymbolUpper.removeAll()
        for i in 77...86 {
            secondSymbolUpper.append(splitedArray[i])
        }
        thirdSymbolUpper.removeAll()
        for i in 87...96 {
            thirdSymbolUpper.append(splitedArray[i])
        }
    }
    
    func setupCollectionConstraints() {

        charSet.translatesAutoresizingMaskIntoConstraints = false
        charSet.topAnchor.constraint(equalTo: container.topAnchor, constant: buttonY).isActive = true
        charSet.heightAnchor.constraint(equalToConstant: buttonHeight).isActive = true
        charSet.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 2.5).isActive = true
        charSet.rightAnchor.constraint(equalTo: container.rightAnchor, constant: -2.5).isActive = true
    }
        
    func array2Keyboard() {
        if (shiftStatus == 0) {
            if isChar{
                button2row(kNames: secondCharLower, rowNumber: 2)
                button2row(kNames: thirdCharLower, rowNumber: 3)
                button2row(kNames: forthCharLower, rowNumber: 4)
                button2row(kNames: fifthSymbol, rowNumber: 5)
            }else{
                button2row(kNames: secondSymbolLower, rowNumber: 2)
                button2row(kNames: thirdSymbolLower, rowNumber: 3)
                button2row(kNames: forthSymbol, rowNumber: 4)
                button2row(kNames: fifthSymbol, rowNumber: 5)
            }
        } else {
            if isChar{
                button2row(kNames: secondCharUpper, rowNumber: 2)
                button2row(kNames: thirdCharUpper, rowNumber: 3)
                button2row(kNames: forthCharUpper, rowNumber: 4)
                button2row(kNames: fifthSymbol, rowNumber: 5)
            }else{
                button2row(kNames: secondSymbolUpper, rowNumber: 2)
                button2row(kNames: thirdSymbolUpper, rowNumber: 3)
                button2row(kNames: forthSymbol, rowNumber: 4)
                button2row(kNames: fifthSymbol, rowNumber: 5)
            }
        }
    }
        
    func button2row (kNames: [String], rowNumber: Int) {
        var buttonX: CGFloat = 2.5  /// buttonY is defined upper
        let numberInRow: CGFloat = CGFloat(kNames.count)
        let startIndex = 0;
        var endIndex = kNames.count - 1
        
        switch numberInRow {
        case 4:
            let subtractXIndex = buttonX*2 + spacingWidth*(numberInRow - 1)
            for i in startIndex...endIndex {
                var buttonWidth = (screenWidth-subtractXIndex)/(numberInRow + 2)
                if i == 2 {buttonWidth *= 3}
                let tempValue : CGFloat = buttonY + buttonHeight * CGFloat(rowNumber - 1) + spacingHeight * CGFloat(rowNumber - 1)  ///offsetY from topAnchor
                let oneBtn = keyboardBtn(frame: CGRect(x: buttonX, y: tempValue, width: buttonWidth, height: buttonHeight))
                buttonX += oneBtn.frame.width + 5
                if i == 0 {
                    if isChar {
                        oneBtn.setImage(#imageLiteral(resourceName: "numbers"), for: .normal)
                        oneBtn.setImage(#imageLiteral(resourceName: "numbersHL"), for: .highlighted)
                    }else {
                        oneBtn.setImage(#imageLiteral(resourceName: "abc"), for: .normal)
                        oneBtn.setImage(#imageLiteral(resourceName: "abcHL"), for: .highlighted)
                    }
                    oneBtn.addTarget(self, action: #selector(switchKeyboardMode), for: .touchUpInside)
                }
                if i == 1 {
                    oneBtn.setTitle("", for: .normal)
                    oneBtn.setImage(#imageLiteral(resourceName: "globe"), for: .normal)
                    oneBtn.setImage(#imageLiteral(resourceName: "globeHL"), for: .highlighted)
                    oneBtn.tintColor = .black
                    oneBtn.addTarget(self, action: #selector(globeKeyPressed), for: .touchUpInside)
                }
                if i == 2 {
                    oneBtn.setTitle("space", for: .normal)
                    oneBtn.addTarget(self, action: #selector(spaceKeyPressed), for: .touchUpInside)
                }
                if i == 3 {
                    oneBtn.setTitle("", for: .normal)
                    oneBtn.setImage(#imageLiteral(resourceName: "return"), for: .normal)
                    oneBtn.setImage(#imageLiteral(resourceName: "returnHL"), for: .highlighted)
                    oneBtn.addTarget(self, action: #selector(returnKeyPressed), for: .touchUpInside)
                }
                oneBtn.setTitleColor(keyColor, for: .normal)
                oneBtn.imageView?.contentMode = .scaleAspectFit
                oneBtn.imageEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
                keyboards.append(oneBtn)
                oneBtn.tag = keyboards.count - 1
                self.container.addSubview(oneBtn)
                oneBtn.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: buttonY).isActive = true
            }
        case 5:
            let subtractXIndex = buttonX*2 + spacingWidth*(numberInRow+1)
            let buttonWidth = (screenWidth-subtractXIndex)/(numberInRow + 2)
            let tempValue : CGFloat = buttonY + buttonHeight * CGFloat(rowNumber - 1) + spacingHeight * CGFloat(rowNumber - 1)  ///offsetY from topAnchor
            endIndex += 2
            for i in startIndex...endIndex {
                let oneBtn = keyboardBtn(frame: CGRect(x: buttonX, y: tempValue, width: buttonWidth, height: buttonHeight))
                buttonX += oneBtn.frame.width + 5
                if i == 0 {
                    oneBtn.setTitle("", for: .normal)
                    oneBtn.setImage(#imageLiteral(resourceName: "shift_0"), for: .normal)
                    oneBtn.setImage(#imageLiteral(resourceName: "shift_0HL"), for: .highlighted)

                    oneBtn.addTarget(self, action: #selector(shiftKeyPressed), for: .touchUpInside)
                }else if i == endIndex {
                    oneBtn.setTitle("", for: .normal)
                    oneBtn.setImage(#imageLiteral(resourceName: "backspace"), for: .normal)
                    oneBtn.setImage(#imageLiteral(resourceName: "backspaceHL"), for: .highlighted)
                    oneBtn.addTarget(self, action: #selector(backspaceKeyPressed), for: .touchUpInside)
                }else{
                    oneBtn.setTitle("\(kNames[i - 1])", for: .normal)
                    oneBtn.addTarget(self, action: #selector(keyPressed(sender:)), for: .touchUpInside)
                }
                
                oneBtn.setTitleColor(keyColor, for: .normal)
                oneBtn.imageView?.contentMode = .scaleAspectFit
                oneBtn.imageEdgeInsets = UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6)
                keyboards.append(oneBtn)
                oneBtn.tag = keyboards.count - 1
                self.container.addSubview(oneBtn)
            }
        case 7:
            let subtractXIndex = buttonX*2 + spacingWidth*(numberInRow + 1)
            let buttonWidth = (screenWidth-subtractXIndex)/(numberInRow + 2)
           let tempValue : CGFloat = buttonY + buttonHeight * CGFloat(rowNumber - 1) + spacingHeight * CGFloat(rowNumber - 1)  ///offsetY from topAnchor
            endIndex += 2
            for i in startIndex...endIndex {
                let oneBtn = keyboardBtn(frame: CGRect(x: buttonX, y: tempValue, width: buttonWidth, height: buttonHeight))
                buttonX += oneBtn.frame.width + 5
                if i == 0 {
                    oneBtn.setTitle("", for: .normal)
                    oneBtn.setImage(#imageLiteral(resourceName: "shift_0"), for: .normal)
                    oneBtn.setImage(#imageLiteral(resourceName: "shift_0HL"), for: .highlighted)
                    oneBtn.addTarget(self, action: #selector(shiftKeyPressed), for: .touchUpInside)
                }else if i == endIndex {
                    oneBtn.setTitle("", for: .normal)
                    oneBtn.setImage(#imageLiteral(resourceName: "backspace"), for: .normal)
                    oneBtn.setImage(#imageLiteral(resourceName: "backspaceHL"), for: .highlighted)
                    oneBtn.addTarget(self, action: #selector(backspaceKeyPressed), for: .touchUpInside)
                }else {
                    oneBtn.setTitle("\(kNames[i-1])", for: .normal)
                    oneBtn.addTarget(self, action: #selector(keyPressed(sender:)), for: .touchUpInside)
                }
                oneBtn.setTitleColor(keyColor, for: .normal)
                oneBtn.imageView?.contentMode = .scaleAspectFit
                oneBtn.imageEdgeInsets = UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6)
                keyboards.append(oneBtn)
                oneBtn.tag = keyboards.count - 1
                self.container.addSubview(oneBtn)
                
            }
        case 9:
            buttonX = 20
            let subtractXIndex = buttonX*2 + spacingWidth*(numberInRow - 1)
            let buttonWidth = (screenWidth-subtractXIndex)/numberInRow
            let tempValue : CGFloat = buttonY + buttonHeight * CGFloat(rowNumber - 1) + spacingHeight * CGFloat(rowNumber - 1)  ///offsetY from topAnchor
            
            for i in startIndex...endIndex {
                let oneBtn = keyboardBtn(frame: CGRect(x: buttonX, y: tempValue, width: buttonWidth, height: buttonHeight))
                buttonX += oneBtn.frame.width + 5
                oneBtn.setTitle("\(kNames[i])", for: .normal)
                
                oneBtn.addTarget(self, action: #selector(keyPressed(sender: )), for: .touchUpInside)
                
                oneBtn.setTitleColor(keyColor, for: .normal)
                keyboards.append(oneBtn)
                oneBtn.tag = keyboards.count - 1
                self.container.addSubview(oneBtn)
            }
        default:
            let subtractXIndex = buttonX*2 + spacingWidth*(numberInRow - 1)
            let buttonWidth = (screenWidth-subtractXIndex)/numberInRow
            let tempValue : CGFloat = buttonY + buttonHeight * CGFloat(rowNumber - 1) + spacingHeight * CGFloat(rowNumber - 1)  ///offsetY from topAnchor
            
            for i in startIndex...endIndex {
                let oneBtn = keyboardBtn(frame: CGRect(x: buttonX, y: tempValue, width: buttonWidth, height: buttonHeight))
                buttonX += oneBtn.frame.width + 5
                oneBtn.setTitle("\(kNames[i])", for: .normal)
                
                oneBtn.addTarget(self, action: #selector(keyPressed(sender: )), for: .touchUpInside)
                oneBtn.setTitleColor(keyColor, for: .normal)
                keyboards.append(oneBtn)
                oneBtn.tag = keyboards.count - 1
                self.container.addSubview(oneBtn)
            }
        }
    }
    
    @objc func willPurchase(){
        
//        let appUrl = NSURL(string: "iRKeyboard://")!
//        self.extensionContext!.completeRequest(returningItems: [], completionHandler: nil)
        //extensionContext?.open(URL(string: "Fontz://")! , completionHandler: nil)

        self.openURL(url: NSURL(string:"Fontz://purchase")!)
        
    }
    
    func openURL(url: NSURL) -> Bool {
        do {
            let application = try self.sharedApplication()
            return application.performSelector(inBackground: "openURL:", with: url) != nil
        }
        catch {
            return false
        }
    }

    func sharedApplication() throws -> UIApplication {
        var responder: UIResponder? = self
        while responder != nil {
            if let application = responder as? UIApplication {
                return application
            }

            responder = responder?.next
        }

        throw NSError(domain: "UIInputViewController+sharedApplication.swift", code: 1, userInfo: nil)
    }
    
    
    @objc func keyPressed(sender: UIButton) {
        //inserts the pressed character into the text document
        var printKey : String = ""
        for i in keyboards{
            if i.tag == sender.tag {printKey = i.titleLabel!.text ?? ""}
        }
        
        textDocumentProxy.insertText(printKey) //String(sender.tag)
//        if shiftStatus is 1, reset it to 0 by pressing the shift key
        if (shiftStatus == 1) {
            shiftKeyPressed()
        }
    }
        
    @objc func globeKeyPressed() {
        advanceToNextInputMode()
    }
    
    @objc func backspaceKeyPressed() {
        textDocumentProxy.deleteBackward()
    }
            
    @objc func spaceKeyPressed() {
        textDocumentProxy.insertText(" ")
    }
    
    @objc func returnKeyPressed() {
        textDocumentProxy.insertText("\n")
    }
            
    @objc func shiftKeyPressed() {
        //if shift is on or in caps lock mode, turn it off. Otherwise, turn it on
        shiftStatus = shiftStatus > 0 ? 0 : 1;
        
        refresh()

    }
     
    @objc func switchKeyboardMode() {
        
        shiftStatus = 0
        isChar = isChar == true ? false : true
        refresh()

        var step : Int = 0
        for i in keyboards{
            if i.imageView?.image == #imageLiteral(resourceName: "numbers") || i.imageView?.image == #imageLiteral(resourceName: "abc") {break}
            step += 1
        }
        
        if isChar {
            keyboards[step].setImage(#imageLiteral(resourceName: "numbers"), for: .normal)
            keyboards[step].setImage(#imageLiteral(resourceName: "numbersHL"), for: .highlighted)
        }else{
            keyboards[step].setImage(#imageLiteral(resourceName: "abc"), for: .normal)
            keyboards[step].setImage(#imageLiteral(resourceName: "abcHL"), for: .highlighted)
        }
        

        
    }
    
    func refresh(){
        for subView in container.subviews{
            subView.removeFromSuperview()
        }
        
        container.addSubview(charSet)
        setupCollectionConstraints()
        self.array2Keyboard()
        
    }
    
    //charSet-CollectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return charSetArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        if indexPath.row == selectIndex {
            if traitCollection.userInterfaceStyle == .light {
              cell.backgroundColor = UIColor.white
           } else {
                cell.backgroundColor = UIColor.darkGray
           }
            
        } else {
            cell.backgroundColor = .lightText
            
        }
        
        cell.layer.cornerRadius = 4
        cell.layer.borderColor = UIColor.systemGray.cgColor
        cell.layer.borderWidth = 1.0
        cell.layer.borderColor = UIColor.lightText.cgColor
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOpacity = 0.1
        cell.layer.shadowRadius = 0.5
        cell.layer.shadowOffset = CGSize(width: 0, height: 1)
        
        let cellLbl = UILabel(frame: CGRect(x: 0, y: 0, width: cell.bounds.width, height: cell.bounds.height))
        cellLbl.textColor = keyColor
        cellLbl.textAlignment = .center
        cellLbl.text = charNameArray[indexPath.row]
        cellLbl.tag = indexPath.row
        cell.addSubview(cellLbl)

        for subview in cell.subviews{
            if subview.tag != indexPath.row {subview.removeFromSuperview()}
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: 80, height: buttonHeight - 2 * buttonY)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
          
       selectIndex = indexPath.row
       collectionView.reloadData()
       fontSource = charSetArray[indexPath.row]

       for subView in container.subviews{
           subView.removeFromSuperview()
       }
       
       container.addSubview(charSet)
       setupCollectionConstraints()
       
       viewWillAppear(true)
        
        if let userDefaults = UserDefaults(suiteName: "group.wecodefonts") {
            isPurchased = userDefaults.integer(forKey: "isPurchased")
        }
        
        if isPurchased == 0 {
            if indexPath.row > 1 {
                locker.isHidden = false
                
            }else{
//                self.view.addSubview(locker)
                locker.isHidden = true
            }                
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 10)
        
    }
}


//extension UIApplication {
//
//    public static func sharedApplication() -> UIApplication {
//        guard UIApplication.respondsToSelector("sharedApplication") else {
//            fatalError("UIApplication.sharedKeyboardApplication(): `UIApplication` does not respond to selector `sharedApplication`.")
//        }
//
//        guard let unmanagedSharedApplication = UIApplication.performSelector("sharedApplication") else {
//            fatalError("UIApplication.sharedKeyboardApplication(): `UIApplication.sharedApplication()` returned `nil`.")
//        }
//
//        guard let sharedApplication = unmanagedSharedApplication.takeUnretainedValue() as? UIApplication else {
//            fatalError("UIApplication.sharedKeyboardApplication(): `UIApplication.sharedApplication()` returned not `UIApplication` instance.")
//        }
//
//        return sharedApplication
//    }
//
//    public func openURL(url: NSURL) -> Bool {
//        return self.performSelector(inBackground: "openURL:", with: url) != nil
//    }
//
//}


//extension UIInputViewController {
//
//    func openURL(url: NSURL) -> Bool {
//        do {
//            let application = try self.sharedApplication()
//            return application.performSelector(inBackground: "openURL:", with: url) != nil
//        }
//        catch {
//            return false
//        }
//    }
//
//    func sharedApplication() throws -> UIApplication {
//        var responder: UIResponder? = self
//        while responder != nil {
//            if let application = responder as? UIApplication {
//                return application
//            }
//
//            responder = responder?.next
//        }
//
//        throw NSError(domain: "UIInputViewController+sharedApplication.swift", code: 1, userInfo: nil)
//    }
//}

