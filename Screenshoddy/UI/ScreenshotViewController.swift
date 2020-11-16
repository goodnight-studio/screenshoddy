//
//  ScreenshotViewController.swift
//  Screenshoddy
//
//  Created by Geof Crowl on 5/2/20.
//  Copyright © 2020 Geof Crowl. All rights reserved.
//

import Cocoa
import S3

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

        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [unowned self] (timer) in
            self.checkPasteboardContents()
        }
    }
    
    @objc func didClickUpload(_ sender: NSButton) {
        
        guard let image = screenshotView.imageView.image else { return }
        
        DispatchQueue.main.async {
            self.screenshotView.progressIndicator.startAnimation(self)
        }
        
        do {
            try AppS3.shared.upload(image: image, completion: { url in
                guard let url = url else { return }
                NSPasteboard.general.clearContents()
                NSPasteboard.general.setString(url.absoluteString, forType: .string)
                NSPasteboard.general.setData(url.dataRepresentation, forType: .URL)
                
                DispatchQueue.main.async {
                    self.screenshotView.progressIndicator.increment(by: 1)
                    self.screenshotView.progressIndicator.stopAnimation(self)
                }
                
            }, apiErrorHandler: { error in
                
                DispatchQueue.main.async {
                    let alert = NSAlert()
                    alert.alertStyle = .critical
                    if let awsError = error as? AWSSDKSwiftCore.AWSResponseError {
                        alert.informativeText = "S3 Error: \(awsError.localizedDescription)"
                    } else {
                        alert.informativeText = "S3 Error: \(error.localizedDescription)"
                    }
                    alert.addButton(withTitle: "OK")
                    alert.runModal()
                }
            })
        } catch {
            
            DispatchQueue.main.async {
                let alert = NSAlert()
                alert.alertStyle = .critical
                alert.informativeText = "S3 Error: \(error.localizedDescription)"
                alert.addButton(withTitle: "OK")
                alert.runModal()
            }
        }
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
