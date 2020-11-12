//
//  AccountPreferencesViewController.swift
//  Screenshoddy
//
//  Created by Geoffrey Crowl on 5/4/20.
//  Copyright © 2020 Geof Crowl. All rights reserved.
//

import Cocoa
import S3

fileprivate extension Selector {
    static let bucketNameButtonDidChange = #selector(AccountPreferencesViewController.bucketNameButtonDidChange(_:))
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
        
        accountPreferencesView.getBucketsButton.action = #selector(AccountPreferencesViewController.getBucketsButtonClicked)
        accountPreferencesView.getBucketsButton.target = self
    }
    
    override func viewWillDisappear() {
        
        // TODO: Validation and errors
        AppDefaults.s3AccessId = accountPreferencesView.accessIdField.stringValue
        AppKeychain.s3SecretKey = accountPreferencesView.secretKeyField.stringValue
        AppDefaults.s3Bucket = accountPreferencesView.bucketNameButton.stringValue
    }
    
    @objc func bucketNameButtonDidChange(_ sender: NSPopUpButton) {
        print("Changed")
    }
    
    @objc func getBucketsButtonClicked(_ sender: NSButton) {
        // Fetch s3 buckets that the user-supplied keys have access to.
        let s3 = S3(
            accessKeyId: accountPreferencesView.accessIdField.stringValue,
            secretAccessKey: accountPreferencesView.secretKeyField.stringValue
        )
        let listBucketRequest = s3.listBuckets()
        
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
