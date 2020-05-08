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
    static let accessIdFieldDidChange = #selector(AccountPreferencesViewController.accessIdFieldDidChange(_:))
}

class AccountPreferencesViewController: NSViewController {

    let accountPreferencesView = AccountPreferencesView()
    
    override func loadView() {
        
        view = accountPreferencesView
        
        accountPreferencesView.accessIdField.stringValue = AppDefaults.s3AccessId ?? ""
        accountPreferencesView.secretKeyField.stringValue = AppDefaults.s3SecretKey ?? ""
        accountPreferencesView.bucketNameButton.stringValue = AppDefaults.s3Bucket ?? ""
        
        accountPreferencesView.accessIdField.delegate = self
        accountPreferencesView.secretKeyField.delegate = self
    }
    
    override func viewWillDisappear() {
        
        // TODO: Validation and errors
        AppDefaults.s3AccessId = accountPreferencesView.accessIdField.stringValue
        AppDefaults.s3SecretKey = accountPreferencesView.secretKeyField.stringValue
        AppDefaults.s3Bucket = accountPreferencesView.bucketNameButton.stringValue
    }
    
    @objc func accessIdFieldDidChange(_ sender: NSTextField) {
        print("here")
    }
    
    @objc func bucketNameButtonDidChange(_ sender: NSPopUpButton) {
        print("Changed")
    }
    
}

extension AccountPreferencesViewController: NSTextFieldDelegate {
    
    func controlTextDidEndEditing(_ obj: Notification) {
        
        if (obj.object as? NSTextField) == accountPreferencesView.accessIdField {
            // Access ID Field has lost focus, validate?
        }
        
        if (obj.object as? NSTextField) == accountPreferencesView.secretKeyField {
            // Secret Key Field has lost focus, validate?
        }
    }
}
