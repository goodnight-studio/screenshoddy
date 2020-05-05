//
//  ScreenshotWindow.swift
//  Screenshoddy
//
//  Created by Geof Crowl on 5/2/20.
//  Copyright © 2020 Geof Crowl. All rights reserved.
//

import Cocoa

class ScreenshotWindow: NSWindow {
    
    let screenshotVC = ScreenshotViewController()

    static var defaultWidth: CGFloat {
        return 256
    }
    
    static var defaultHeight: CGFloat {
        return 256
    }
    
    override var frameAutosaveName: NSWindow.FrameAutosaveName {
        return NSWindow.FrameAutosaveName("com.geofcrowl.Screenshoddy.ScreenshotWindow")
    }
    
    override init(contentRect: NSRect, styleMask style: NSWindow.StyleMask, backing backingStoreType: NSWindow.BackingStoreType, defer flag: Bool) {
        
        super.init(contentRect: contentRect, styleMask: style, backing: backingStoreType, defer: flag)
        
//        title = "Screenshoddy"
//        titleVisibility = .hidden
        titlebarAppearsTransparent = true
        
        contentViewController = screenshotVC
        autorecalculatesKeyViewLoop = true
        isRestorable = true
        
        minSize = NSSize(width: 250, height: 250)
        delegate = self
    }
    
}

extension ScreenshotWindow: NSWindowDelegate {
    
    func windowDidBecomeMain(_ notification: Notification) {
        
        screenshotVC.checkPasteboardContents()
    }
    
}
