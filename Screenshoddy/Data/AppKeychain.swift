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
        static var s3SecretKey = "s3SecretKey"
    }
    
    static var s3SecretKey: String? {
        get {
            guard let s3AccessId = AppDefaults.s3AccessId else { return nil }
            return AppKeychain.shared.keychain[s3AccessId]
        }
        
        set {
            guard let newValue = newValue else { return }
            guard let s3AccessId = AppDefaults.s3AccessId else { return }
            AppKeychain.shared.keychain[s3AccessId] = newValue
        }
    }
    
}
