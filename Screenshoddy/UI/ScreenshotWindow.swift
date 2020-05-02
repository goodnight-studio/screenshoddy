//
//  ScreenshotWindow.swift
//  Screenshoddy
//
//  Created by Geof Crowl on 5/2/20.
//  Copyright © 2020 Geof Crowl. All rights reserved.
//

import Cocoa

class ScreenshotWindow: NSWindow {

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
        
        titleVisibility = .hidden
        
    }
    
}
