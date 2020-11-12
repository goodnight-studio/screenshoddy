//
//  AppDefaults.swift
//  Screenshoddy
//
//  Created by Geoffrey Crowl on 5/7/20.
//  Copyright © 2020 Geof Crowl. All rights reserved.
//

import Foundation


public class AppDefaults {
    
    fileprivate struct Key {
        static let s3AccessId = "s3AccessId"
        static var s3Bucket = "s3Bucket"
    }
    
    static var shared: UserDefaults = {
        //        let appIdentifierPrefix = Bundle.main.object(forInfoDictionaryKey: "AppIdentifierPrefix") as! String
        //        let suiteName = "\(appIdentifierPrefix)group.\(Bundle.main.bundleIdentifier!)"
        let suiteName = "group.com.geofcrowl.Screenshoddy"
        print("UserDefaults initialized with suiteName:", suiteName)
        return UserDefaults.init(suiteName: suiteName)!
    }()
    
    static var s3AccessId: String? {
        
        get {
            AppDefaults.shared.string(forKey: Key.s3AccessId)
        }
        
        set {
            AppDefaults.shared.set(newValue, forKey: Key.s3AccessId)
        }
    }
    
    static var s3Bucket: String? {
        
        get {
            AppDefaults.shared.string(forKey: Key.s3Bucket)
        }
        
        set {
            AppDefaults.shared.set(newValue, forKey: Key.s3Bucket)
        }
    }
    
}

