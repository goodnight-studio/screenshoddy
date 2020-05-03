//
//  ScreenshotViewController.swift
//  Screenshoddy
//
//  Created by Geof Crowl on 5/2/20.
//  Copyright © 2020 Geof Crowl. All rights reserved.
//

import Cocoa

fileprivate extension Selector {
    static let didClickUpload = #selector(ScreenshotViewController.didClickUpload(_:))
}

class ScreenshotViewController: NSViewController {

    let screenshotView = ScreenshotView()
    
    override func loadView() {
        
        view = screenshotView
        
        screenshotView.uploadButton.target = self
        screenshotView.uploadButton.action = .didClickUpload
    }
    
    override func viewDidLoad() {
//        checkPasteboardContents()
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [unowned self] (timer) in
            self.checkPasteboardContents()
        }
    }
    
    @objc func didClickUpload(_ sender: NSButton) {
        
        let alert = NSAlert()
        alert.alertStyle = .warning
        alert.messageText = "Did not upload"
        alert.informativeText = "This is where upload code would go!"
        alert.addButton(withTitle: "OK")
        alert.runModal()
    }
    
    func checkPasteboardContents() {
        
        guard let items = NSPasteboard.general.pasteboardItems else { return }
        if items.count == 0 { return }
        
        for item in items {
            if let imageData = item.data(forType: NSPasteboard.PasteboardType.png) {
                screenshotView.imageView.image = NSImage(data: imageData)
            }
        }
    }
    
}
