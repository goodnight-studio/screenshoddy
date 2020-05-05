//
//  AccountPreferencesView.swift
//  Screenshoddy
//
//  Created by Geoffrey Crowl on 5/4/20.
//  Copyright © 2020 Geof Crowl. All rights reserved.
//

import Cocoa

class AccountPreferencesView: NSView {

    let accessIdLabel = NSTextField()
    let accessIdField = NSTextField()
    
    let secretKeyLabel = NSTextField()
    let secretKeyField = NSTextField()
    
    let bucketNameLabel = NSTextField()
    let bucketNameButton = NSPopUpButton()
    
    let gridView: NSGridView!
    
    override init(frame frameRect: NSRect) {
        
        gridView = NSGridView(views: [
            [accessIdLabel, accessIdField],
            [secretKeyLabel, secretKeyField],
            [bucketNameLabel, bucketNameButton]
        ])
        
        super.init(frame: frameRect)
        
        gridView.autoresizingMask = [.height, .width]
        
        addSubview(gridView)
        
        gridView.setContentHuggingPriority(NSLayoutConstraint.Priority(rawValue: 800), for: .vertical)
        gridView.setContentHuggingPriority(NSLayoutConstraint.Priority(rawValue: 800), for: .horizontal)
        
        gridView.rowSpacing = Globals.margin
        gridView.columnSpacing = Globals.margin / 2
        gridView.rowAlignment = .firstBaseline
        
        accessIdLabel.isEditable = false
        accessIdLabel.isSelectable = false
        accessIdLabel.stringValue = "S3 Access ID:"
        accessIdLabel.backgroundColor = .clear
        accessIdLabel.isBezeled = false
        
        accessIdField.placeholderString = "S3 Access ID"
        
        secretKeyLabel.isEditable = false
        secretKeyLabel.isSelectable = false
        secretKeyLabel.stringValue = "S3 Secret Key:"
        secretKeyLabel.backgroundColor = .clear
        secretKeyLabel.isBezeled = false
        
        secretKeyField.placeholderString = "S3 Secret Key"
        
        bucketNameLabel.isEditable = false
        bucketNameLabel.isSelectable = false
        bucketNameLabel.stringValue = "Bucket:"
        bucketNameLabel.backgroundColor = .clear
        bucketNameLabel.isBezeled = false
        
        bucketNameButton.setTitle("Add S3 Credentials To Pick Bucket")
        bucketNameButton.addItem(withTitle: "Test")
//        bucketNameButton.isEnabled = false
    }
    
    override func layout() {
        
//        accessIdLabel.sizeToFit()
//        secretKeyLabel.sizeToFit()
        super.layout()
//
        gridView.frame = bounds.insetBy(dx: Globals.margin * 2, dy: Globals.margin * 2)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
