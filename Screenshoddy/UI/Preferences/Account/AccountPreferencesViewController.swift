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
    static let handleGetBucketsButton = #selector(AccountPreferencesViewController.getBucketsButtonClicked(_:))
}

class AccountPreferencesViewController: NSViewController {

    let accountPreferencesView = AccountPreferencesView()
    
    override func loadView() {
        
        view = accountPreferencesView
        
        accountPreferencesView.accessIdField.stringValue = AppDefaults.s3AccessId ?? ""
        accountPreferencesView.secretKeyField.stringValue = AppKeychain.s3SecretKey ?? ""
        accountPreferencesView.bucketNameButton.stringValue = AppDefaults.s3Bucket ?? ""
        
        accountPreferencesView.accessIdField.delegate = self
        accountPreferencesView.secretKeyField.delegate = self
        
        accountPreferencesView.getBucketsButton.target = self
        accountPreferencesView.getBucketsButton.action = .handleGetBucketsButton
        
        accountPreferencesView.bucketNameButton.target = self
        accountPreferencesView.bucketNameButton.action = .bucketNameButtonDidChange
    }
    
    override func viewWillDisappear() {
        
        // TODO: Validation and errors
        AppDefaults.s3AccessId = accountPreferencesView.accessIdField.stringValue
        AppKeychain.s3SecretKey = accountPreferencesView.secretKeyField.stringValue
    }
    
    @objc func bucketNameButtonDidChange(_ sender: NSPopUpButton) {
        
        if let selectedItem = sender.selectedItem {
            AppDefaults.s3Bucket = selectedItem.title
        }
    }
    
    @objc func getBucketsButtonClicked(_ sender: NSButton) {
        // Fetch s3 buckets that the user-supplied keys have access to.
        let listBucketRequest = AppS3.shared.s3.listBuckets()
        
        listBucketRequest.whenSuccess { output in
            
            guard let buckets = output.buckets else { return }
            
            self.accountPreferencesView.updateWith(bucketNames: buckets.compactMap({ (bucket) -> String in
                return bucket.name ?? "Unnamed"
            }))
        }
        
        
        listBucketRequest.whenFailure { [unowned self] error in

            DispatchQueue.main.async {
                let alert = NSAlert()
                alert.alertStyle = .critical
                alert.informativeText = "S3 Error: \(error.localizedDescription)"
                alert.addButton(withTitle: "OK")
                alert.beginSheetModal(for: view.window!)
            }
        }
    }
    
}

extension AccountPreferencesViewController: NSTextFieldDelegate {
    
    func controlTextDidEndEditing(_ obj: Notification) {
        
        if (obj.object as? NSTextField) == accountPreferencesView.accessIdField {
            // Access ID Field has lost focus, validate and save
            AppDefaults.s3AccessId = accountPreferencesView.accessIdField.stringValue
        }
        
        if (obj.object as? NSTextField) == accountPreferencesView.secretKeyField {
            // Secret Key Field has lost focus, validate and save
            AppKeychain.s3SecretKey = accountPreferencesView.secretKeyField.stringValue
        }
    }
}
