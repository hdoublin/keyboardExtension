//
//  IAPHelper.swift
//  kExtension
//
//  Created by Imran Rapiq on 9/3/20.
//  Copyright © 2020 Imran R. All rights reserved.
//

import Foundation
import SwiftyStoreKit
import StoreKit

class AppCache {
    
    static let shared = AppCache()
    
    var isPremium = false
    var expireDate = ""
    
    var yearlyPrice = "$19.99"
    var specialPrice = "0.99"
    var currencySymbol = "$"
    var specialPeriod = "1 month"
    
    var popActive = false

}

struct IAPHelper {
    typealias Finished = () -> ()
    // Your sharedSecrets
    static let sharedSecret = "ec860eee216d409bb7269f2e89505296"
    static var premium = "fonts.premium1w"
    
    //just for subscriptions
    static let termsOfServiceURL = "https://wecode.online/app/terms_and_conditions.html"
    static let privacyPolicyURL = "https://wecode.online/app/privacy_policy.html"
    
    static let IAPSet : Set<String> = ["fonts.premium1w"]
    
    enum PurchaseType: Int {
        case simple = 0,
        autoRenewable,
        nonRenewing
    }
    
    static func verifyPurchase(with id: String, sharedSecret: String, type: PurchaseType, validDuration: TimeInterval? = nil){
        let appleValidator = AppleReceiptValidator(service: .production, sharedSecret: sharedSecret)
        SwiftyStoreKit.verifyReceipt(using: appleValidator) { result in
            switch result {
            case .success(let receipt):
                let productId = id
                // Verify the purchase of a Subscription
                switch type {
                case .simple:
                    // Verify the purchase of Consumable or NonConsumable
                    let purchaseResult = SwiftyStoreKit.verifyPurchase(
                        productId: id,
                        inReceipt: receipt)
                    
                    switch purchaseResult {
                    case .purchased(let receiptItem):
                        print("\(productId) is purchased: \(receiptItem)")
                    case .notPurchased:
                        print("The user has never purchased \(productId)")
                    }
                case .autoRenewable:
                    let purchaseResult = SwiftyStoreKit.verifySubscription(
                        ofType: .autoRenewable, // or .nonRenewing (see below)
                        productId: productId,
                        inReceipt: receipt)
                    
                    switch purchaseResult {
                    case .purchased(let expiryDate):
                        
                        print("\(productId) is valid until \(expiryDate)")
                        AppCache.shared.isPremium = true
                        UserDefaults(suiteName: "group.wecodefonts")?.set(1, forKey: "isPurchased")
                        UserDefaults(suiteName: "group.wecodefonts")?.synchronize()
                        NotificationCenter.default.post(name: Notification.Name("subsOK"), object: nil)
                    case .expired(let expiryDate):
                        
                        print("\(productId) is expired since \(expiryDate)")
                        AppCache.shared.isPremium = false
                        UserDefaults(suiteName: "group.wecodefonts")?.set(0, forKey: "isPurchased")
                        UserDefaults(suiteName: "group.wecodefonts")?.synchronize()
                    case .notPurchased:
                        AppCache.shared.isPremium = false
                        UserDefaults(suiteName: "group.wecodefonts")?.set(0, forKey: "isPurchased")
                        UserDefaults(suiteName: "group.wecodefonts")?.synchronize()
                        print("The user has never purchased \(productId)")
                    }
                case .nonRenewing:
                    guard let validDuration = validDuration else {return}
                    let purchaseResult = SwiftyStoreKit.verifySubscription(
                        ofType: .nonRenewing(validDuration: validDuration),
                        productId: id,
                        inReceipt: receipt)
                    
                    switch purchaseResult {
                    case .purchased(let expiryDate):
                        print("\(productId) is valid until \(expiryDate)")
                    case .expired(let expiryDate):
                        print("\(productId) is expired since \(expiryDate)")
                    case .notPurchased:
                        print("The user has never purchased \(productId)")
                    }
                    
                }
            case .error(let error):
                print("Receipt verification failed: \(error)")
            }
        }
    }
    
    static func purchaseProduct(with id: String, sharedSecret: String, type: PurchaseType, validDuration: TimeInterval? = nil){
        Spinner.start()
        if type == .simple {
            SwiftyStoreKit.retrieveProductsInfo([id]) { result in
                if let product = result.retrievedProducts.first {
                    SwiftyStoreKit.purchaseProduct(product, quantity: 1, atomically: true) { result in
                        switch result {
                        case .success(let product):
                            // fetch content from your server, then:
                            if product.needsFinishTransaction {
                                SwiftyStoreKit.finishTransaction(product.transaction)
                            }
                            print("Purchase Success: \(product.productId)")
                            Spinner.stop()
                        case .error(let error):
                            switch error.code {
                            case .unknown: print("Unknown error. Please contact support")
                            case .clientInvalid: print("Not allowed to make the payment")
                            case .paymentCancelled: break
                            case .paymentInvalid: print("The purchase identifier was invalid")
                            case .paymentNotAllowed: print("The device is not allowed to make the payment")
                            case .storeProductNotAvailable: print("The product is not available in the current storefront")
                            case .cloudServicePermissionDenied: print("Access to cloud service information is not allowed")
                            case .cloudServiceNetworkConnectionFailed: print("Could not connect to the network")
                            case .cloudServiceRevoked: print("User has revoked permission to use this cloud service")
                            default: print((error as NSError).localizedDescription)
                            }
                            Spinner.stop()
                        }
                    }
                }
            }
        }else{
            SwiftyStoreKit.purchaseProduct(id, atomically: true) { result in
                
                if case .success(let purchase) = result {
                    Spinner.stop()
                    // Deliver content from server, then:
                    if purchase.needsFinishTransaction {
                        SwiftyStoreKit.finishTransaction(purchase.transaction)
                    }
                    guard let validDuration = validDuration else { return }
                    self.verifyPurchase(with: id, sharedSecret: sharedSecret, type: type,validDuration: validDuration)
                    
                } else {
                    Spinner.stop()
                    // purchase error
                }
            }
        }
        
    }
    static func restorePurchases(){
        Spinner.start()
        SwiftyStoreKit.restorePurchases(atomically: true) { results in
            if results.restoreFailedPurchases.count > 0 {
                print("Restore Failed: \(results.restoreFailedPurchases)")
                
            }
            else if results.restoredPurchases.count > 0 {
                print("Restore Success: \(results.restoredPurchases)")
                NotificationCenter.default.post(name: Notification.Name("subsOK"), object: nil)
            }
            else {
                print("Nothing to Restore")
                
            }
            Spinner.stop()
        }
    }
    
    static func checkSubscription(completion: @escaping (_ result: Bool)->()) {
        
        let appleValidator = AppleReceiptValidator(service: .production, sharedSecret: IAPHelper.sharedSecret)
        SwiftyStoreKit.verifyReceipt(using: appleValidator) { result in
            if case .success(let receipt) = result {
                let purchaseResult = SwiftyStoreKit.verifySubscriptions(ofType: .autoRenewable, productIds: IAPHelper.IAPSet, inReceipt: receipt)
                
                switch purchaseResult {
                case .purchased(let expiryDate, let items):
                    
                    for item in items
                    {
                        print("Product \(item.productId) is valid until \(expiryDate)")
                        UserDefaults(suiteName: "group.wecodefonts")?.set(expiryDate, forKey: "appExpire")
                        AppCache.shared.expireDate = "\(expiryDate)"
                        
                        if item.productId.contains("premium") {
                            UserDefaults(suiteName: "group.wecodefonts")?.set(1, forKey: "isPurchased")
                            UserDefaults(suiteName: "group.wecodefonts")?.synchronize()
                            AppCache.shared.isPremium = true
                        }
                    }
                    
                    
                    NotificationCenter.default.post(name: Notification.Name("subsOK"), object: nil)
                    //API.sharedInstance.updatePayment(product: (items.first?.productId)!, status: "active", expired: expiryDate.string(withFormat: "YYYY-MM-dd HH:mm:ss"), transID: (items.first?.transactionId)!)
                    completion(true)
                case .expired(let expiryDate, let items):
                    
                    for item in items
                    {
                        print("Product \(item.productId) is valid until \(expiryDate)")
                        UserDefaults(suiteName: "group.wecodefonts")?.set(expiryDate, forKey: "appExpire")
                        AppCache.shared.expireDate = "\(expiryDate)"
                        
                        if item.productId.contains("premium") {
                            UserDefaults(suiteName: "group.wecodefonts")?.set(1, forKey: "isPurchased")
                            UserDefaults(suiteName: "group.wecodefonts")?.synchronize()
                            AppCache.shared.isPremium = false
                        }
                    }
                    
                    
                    NotificationCenter.default.post(name: Notification.Name("subsEX"), object: nil)
                    //API.sharedInstance.updatePayment(product: (items.first?.productId)!, status: "expired", expired: expiryDate.string(withFormat: "YYYY-MM-dd HH:mm:ss"), transID: (items.first?.transactionId)!)
                    completion(false)
                case .notPurchased:
                    print("This product has never been purchased")
                    UserDefaults(suiteName: "group.wecodefonts")?.set(Date().addingTimeInterval(TimeInterval(-14440)), forKey: "appExpire")
                    UserDefaults(suiteName: "group.wecodefonts")?.set(0, forKey: "isPurchased")
                    //UserDefaults.standard.set(0, forKey: "isUltimate")
                    UserDefaults(suiteName: "group.wecodefonts")?.synchronize()
                    AppCache.shared.isPremium = false
                    completion(false)
                }
            } else {
                print("Receipt verification error", result)
                completion(false)
            }
        }
    }
    
    static func startHelper() {
                
        SwiftyStoreKit.completeTransactions(atomically: true) { purchases in
            for purchase in purchases {
                switch purchase.transaction.transactionState {
                case .purchased, .restored:
                    if purchase.needsFinishTransaction {
                        // Deliver content from server, then:
                        SwiftyStoreKit.finishTransaction(purchase.transaction)
                    }
                // Unlock content
                    UserDefaults(suiteName: "group.wecodefonts")?.set(1, forKey: "isPurchased")
                    UserDefaults(suiteName: "group.wecodefonts")?.synchronize()
                    AppCache.shared.isPremium = true
                case .failed, .purchasing, .deferred:
                    break // do nothing
                }
            }
        }
    }
    
    struct Objects {
        var name : String!
        var priceString : String!
        var localizedDescription : String!
    }
    
    static var Info = [Objects]()
    
    static func getProductInfo(with id: String, completed: @escaping Finished)  {
        Spinner.start()
        SwiftyStoreKit.retrieveProductsInfo([id]) { result in
            if let product = result.retrievedProducts.first {
                let priceString = product.localizedPrice!
                print("Product: \(product.localizedDescription), price: \(priceString)")
                Info.append(Objects(name: product.localizedTitle, priceString: product.localizedPrice, localizedDescription: product.localizedDescription))
                
            }
            else if let invalidProductId = result.invalidProductIDs.first {
                print("Invalid product identifier: \(invalidProductId)")
                
            }
            else {
                print("Error: \(result.error)")
            }
            Spinner.stop()
            completed()
        }
    }
    
    static var subscriptionTerms = "Please read below about the auto-renewing subscription nature of this product: • Payment will be charged to iTunes Account at confirmation of purchase • Subscription automatically renews unless auto-renew is turned off at least 24-hours before the end of the current period • Account will be charged for renewal within 24-hours prior to the end of the current period, and identify the cost of the renewal • Subscriptions may be managed by the user and auto-renewal may be turned off by going to the user's Account Settings after purchase • Any unused portion of a free trial period, if offered, will be forfeited when the user purchases a subscription to that publication, where applicable Terms of Use: \(termsOfServiceURL) \nPrivacy Policy: \(privacyPolicyURL)"
    static func getSubscriptionTerms(with id: String, completed: @escaping Finished) {
        SwiftyStoreKit.retrieveProductsInfo([id]) { result in
            if let product = result.retrievedProducts.first {
                AppCache.shared.yearlyPrice = product.localizedPrice!
                
                if #available(iOS 11.2, *) {
                    
                        if let period = product.introductoryPrice?.subscriptionPeriod{
                            
                            AppCache.shared.specialPrice = "\(product.introductoryPrice?.price ?? 0.99)"
                            AppCache.shared.currencySymbol = "\(product.introductoryPrice?.priceLocale.currencySymbol ?? "$")"
                            AppCache.shared.specialPeriod = "\(period.numberOfUnits) \(unitName(unitRawValue: period.unit.rawValue))"
                            //print("\(product.introductoryPrice?.price) \(product.introductoryPrice?.priceLocale.currencySymbol) -   \(period.numberOfUnits) \(unitName(unitRawValue: period.unit.rawValue))")

                            subscriptionTerms = "Special offer \(period.numberOfUnits) \(unitName(unitRawValue: period.unit.rawValue)) \(AppCache.shared.currencySymbol)\(AppCache.shared.specialPrice) - Subscription price: \(AppCache.shared.yearlyPrice) Description: \(product.localizedDescription).\n\nPlease read below about the auto-renewing subscription nature of this product: \n\n• Payment will be charged to iTunes Account at confirmation of purchase \n• Subscription automatically renews unless auto-renew is turned off at least 24-hours before the end of the current period \n• Account will be charged for renewal within 24-hours prior to the end of the current period, and identify the cost of the renewal \n• Subscriptions may be managed by the user and auto-renewal may be turned off by going to the user's Account Settings after purchase \n• Any unused portion of a free trial period, if offered, will be forfeited when the user purchases a subscription to that publication, where applicable \n\nTerms of Use: \(termsOfServiceURL) \nPrivacy Policy: \(privacyPolicyURL)"
                        }
                    
                } else {
                }
            }
            else if let invalidProductId = result.invalidProductIDs.first {
                print("Invalid product identifier: \(invalidProductId)")
            }
            else {
                print("Error: \(result.error)")
            }
            completed()
        }
        
    }
    static func unitName(unitRawValue:UInt) -> String {
        switch unitRawValue {
        case 0: return "days"
        case 1: return "week"
        case 2: return "month"
        case 3: return "years"
        default: return ""
        }
    }
}
