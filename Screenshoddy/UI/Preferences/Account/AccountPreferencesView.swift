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
    
    let getBucketsButton = NSButton()
    
    let bucketNameLabel = NSTextField()
    let bucketNameButton = NSPopUpButton()
    
    let regionLabel = NSTextField()
    let regionButton = NSPopUpButton()
    
    let gridView: NSGridView!
    
    override init(frame frameRect: NSRect) {
        
        gridView = NSGridView(views: [
            [accessIdLabel, accessIdField],
            [secretKeyLabel, secretKeyField],
            [bucketNameLabel, bucketNameButton, getBucketsButton],
            [regionLabel, regionButton]
        ])
        
        super.init(frame: frameRect)
        
        gridView.autoresizingMask = [.width, .height]
        
        addSubview(gridView)
        
        gridView.setContentHuggingPriority(NSLayoutConstraint.Priority(rawValue: 800), for: .vertical)
        gridView.setContentHuggingPriority(NSLayoutConstraint.Priority(rawValue: 800), for: .horizontal)
        
        accessIdField.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        secretKeyField.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        bucketNameButton.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        regionButton.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        
        getBucketsButton.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        getBucketsButton.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        gridView.rowSpacing = Globals.margin
        gridView.rowAlignment = .firstBaseline
        gridView.columnSpacing = Globals.margin / 2
        
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
        
        getBucketsButton.title = "Refresh"
        getBucketsButton.bezelStyle = .roundRect
        
        bucketNameLabel.isEditable = false
        bucketNameLabel.isSelectable = false
        bucketNameLabel.stringValue = "Bucket:"
        bucketNameLabel.backgroundColor = .clear
        bucketNameLabel.isBezeled = false
        
        bucketNameButton.setTitle("Add S3 Credentials To Pick Bucket")
        bucketNameButton.addItem(withTitle: AppDefaults.s3Bucket ?? "")
        bucketNameButton.isEnabled = AppDefaults.s3Bucket != nil ? true : false
        
        regionLabel.isEditable = false
        regionLabel.isSelectable = false
        regionLabel.stringValue = "Region:"
        regionLabel.backgroundColor = .clear
        regionLabel.isBezeled = false
        
        regionButton.setTitle("S3 Region")
        regionButton.addItems(withTitles: AppS3.shared.getRegions())
        regionButton.isEnabled = true
        
        if let region = AppDefaults.s3Region {
            regionButton.selectItem(withTitle: region)
        }
        
        accessIdField.nextKeyView = secretKeyField
        secretKeyField.nextKeyView = bucketNameButton
        bucketNameButton.nextKeyView = getBucketsButton
        getBucketsButton.nextKeyView = accessIdField
    }
    
    override func layout() {
        
        super.layout()
        
        gridView.frame = bounds.insetBy(dx: Globals.margin * 2, dy: Globals.margin * 2)
    }
    
    func updateWith(bucketNames: [String]) {
        
        DispatchQueue.main.async { [weak self] in
            
            guard let strongSelf = self else { return }
            
            strongSelf.bucketNameButton.isEnabled = true
            strongSelf.bucketNameButton.removeAllItems()
            strongSelf.bucketNameButton.addItems(withTitles: bucketNames)
            
            if let bucketName = AppDefaults.s3Bucket {
                strongSelf.bucketNameButton.selectItem(withTitle: bucketName)
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
