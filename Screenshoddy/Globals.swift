//
//  Globals.swift
//  Screenshoddy
//
//  Created by Geof Crowl on 5/2/20.
//  Copyright © 2020 Geof Crowl. All rights reserved.
//

import Cocoa

class Globals {
    
    static var margin: CGFloat {
        return 16
    }
    
    static var screenVisibleFrame: CGRect {
        get {
            if let screen = NSScreen.main {
                return screen.visibleFrame
            } else {
                return CGRect(x: 0, y: 0, width: 0, height: 0)
            }
        }
    }
    
    static var screenScale: CGFloat {
        return NSScreen.main?.backingScaleFactor ?? 1
    }
}
