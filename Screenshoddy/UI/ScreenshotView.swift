//
//  ScreenshotView.swift
//  Screenshoddy
//
//  Created by Geof Crowl on 5/2/20.
//  Copyright © 2020 Geof Crowl. All rights reserved.
//

import Cocoa

class ScreenshotView: NSView {
    
    let uploadButton = NSButton()
    let messageTextView = NSTextView()
    let imageView = NSImageView()
    let controlView = NSVisualEffectView()
    let progressIndicator = NSProgressIndicator()

    override init(frame frameRect: NSRect) {
        
        super.init(frame: frameRect)
        
        wantsLayer = true
        layer?.backgroundColor = NSColor.underPageBackgroundColor.cgColor
        
        addSubview(messageTextView)
        messageTextView.string = "No image in pasteboard"
        messageTextView.isEditable = false
        messageTextView.isSelectable = false
        messageTextView.alignment = .center
        messageTextView.font = NSFont.systemFont(ofSize: 17)
        messageTextView.backgroundColor = .clear
        messageTextView.textColor = .secondaryLabelColor
        
        addSubview(imageView)
        imageView.allowsCutCopyPaste = true
        
        addSubview(controlView)
        controlView.blendingMode = .withinWindow
        
        addSubview(progressIndicator)
        progressIndicator.isIndeterminate = true
        progressIndicator.isDisplayedWhenStopped = false
        
        addSubview(uploadButton)
        uploadButton.title = "Upload"
        uploadButton.bezelStyle = .roundRect
        uploadButton.keyEquivalent = "Return"
    }
    
    override func layout() {
        
        uploadButton.sizeToFit()
        uploadButton.frame.size.width += Globals.margin
        uploadButton.frame.origin.x = bounds.width - uploadButton.frame.size.width - Globals.margin
        uploadButton.frame.origin.y = Globals.margin
        
        progressIndicator.frame.size.width = 32
        progressIndicator.frame.size.height = 8
        progressIndicator.frame.origin.x = uploadButton.frame.origin.x - progressIndicator.frame.width - Globals.margin
        progressIndicator.frame.origin.y = uploadButton.frame.origin.y + 6
        
        controlView.frame.size.width = bounds.width
        controlView.frame.size.height = uploadButton.frame.maxY + Globals.margin
        controlView.frame.origin.x = 0
        controlView.frame.origin.y = 0
        
        messageTextView.sizeToFit()
        messageTextView.frame.size.width = bounds.width - Globals.margin * 2
        messageTextView.frame.origin.x = (bounds.width / 2) - (messageTextView.frame.width / 2)
        messageTextView.frame.origin.y = (bounds.height / 2) + (messageTextView.frame.height / 2)
        
        imageView.frame.size.width = bounds.width - Globals.margin * 2
        imageView.frame.size.height = bounds.height - controlView.frame.maxY - Globals.margin * 2
        imageView.frame.origin.x = 16
        imageView.frame.origin.y = controlView.frame.maxY + Globals.margin
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
