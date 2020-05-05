//
//  PreferencesWindow.swift
//  Screenshoddy
//
//  Created by Geoffrey Crowl on 5/4/20.
//  Copyright © 2020 Geof Crowl. All rights reserved.
//

import Cocoa

class PreferencesWindow: NSWindow {

    static var defaultWidth: CGFloat {
        return 512
    }
    
    static var defaultHeight: CGFloat {
        return 400
    }
    
    override init(contentRect: NSRect, styleMask style: NSWindow.StyleMask, backing backingStoreType: NSWindow.BackingStoreType, defer flag: Bool) {
        
        super.init(contentRect: contentRect, styleMask: style, backing: backingStoreType, defer: flag)
        
        title = "Preferences"

        autorecalculatesKeyViewLoop = true
        isRestorable = false
        
        minSize = NSSize(width: 512, height: 250)
    }
}
