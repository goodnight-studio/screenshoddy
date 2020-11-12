//
//  AppKeychain.swift
//  Screenshoddy
//
//  Created by Geof Crowl on 11/11/20.
//  Copyright © 2020 Geof Crowl. All rights reserved.
//

import Foundation
import KeychainAccess

public class AppKeychain {
    
    let keychain = Keychain(service: "com.amazon.s3")
    
    static var shared = AppKeychain()
    
    fileprivate struct Key {
        static let s3AccessId = "s3AccessId"
        static var s3SecretKey = "s3SecretKey"
    }
    
    static var s3AccessId: String? {
        get {
            return AppKeychain.shared.keychain[Key.s3AccessId]
        }
        
        set {
            guard let newValue = newValue else { return }
            AppKeychain.shared.keychain[Key.s3AccessId] = newValue
        }
    }
    
    static var s3SecretKey: String? {
        get {
            return AppKeychain.shared.keychain[Key.s3SecretKey]
        }
        
        set {
            guard let newValue = newValue else { return }
            AppKeychain.shared.keychain[Key.s3SecretKey] = newValue
        }
    }
    
}
