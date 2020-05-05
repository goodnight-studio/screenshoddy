//
//  AccountPreferencesViewController.swift
//  Screenshoddy
//
//  Created by Geoffrey Crowl on 5/4/20.
//  Copyright © 2020 Geof Crowl. All rights reserved.
//

import Cocoa

fileprivate extension Selector {
    static let bucketNameButtonDidChange = #selector(AccountPreferencesViewController.bucketNameButtonDidChange(_:))
}

class AccountPreferencesViewController: NSViewController {

    let accountPreferencesView = AccountPreferencesView()
    
    override func loadView() {
        
        view = accountPreferencesView
        
        // TODO: This isn't right
        NotificationCenter.default.addObserver(
            self,
            selector: .bucketNameButtonDidChange,
            name: NSPopUpButton.willPopUpNotification,
            object: nil)
    }
    
    @objc func bucketNameButtonDidChange(_ sender: NSPopUpButton) {
        print("Changed")
    }
    
}
